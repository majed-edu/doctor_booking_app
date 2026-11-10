from pathlib import Path
import re
import sys


PROJECT = Path(__file__).resolve().parents[1] / "ios" / "Runner.xcodeproj" / "project.pbxproj"
FLAVORS = ("production", "development")


def balanced(text):
    stack = []
    in_string = False
    escaped = False
    in_comment = False
    index = 0
    while index < len(text):
        character = text[index]
        if in_comment:
            if character == "\n":
                in_comment = False
        elif in_string:
            if escaped:
                escaped = False
            elif character == "\\":
                escaped = True
            elif character == '"':
                in_string = False
        elif text.startswith("/*", index):
            end = text.find("*/", index + 2)
            if end == -1:
                return "unterminated comment"
            index = end + 1
        elif text.startswith("//", index):
            in_comment = True
        elif character == '"':
            in_string = True
        elif character in "{(":
            stack.append(character)
        elif character in "})":
            expected = "{" if character == "}" else "("
            if not stack or stack.pop() != expected:
                return f"unmatched {character} at offset {index}"
        index += 1
    if in_string:
        return "unterminated string"
    if stack:
        return f"unclosed {stack[-1]}"
    return None


def main():
    text = PROJECT.read_text(encoding="utf-8")
    problem = balanced(text)
    if problem:
        return problem

    definitions = re.findall(r"^\s*([A-F0-9]{24})\s*=\s*\{", text, re.MULTILINE)
    duplicates = sorted({object_id for object_id in definitions if definitions.count(object_id) > 1})
    if duplicates:
        return "duplicate object IDs: " + ", ".join(duplicates)

    xc_configurations = set(
        re.findall(r"^\s*([A-F0-9]{24})\s*/\* [^*]+ \*/ = \{\n\s*isa = XCBuildConfiguration;", text, re.MULTILINE)
    )
    lists = re.findall(
        r"/\* Build configuration list for (?:PBXProject|PBXNativeTarget) \"(?:Runner|RunnerTests)\" \*/ = \{(.*?)\n\s*\};",
        text,
        re.DOTALL,
    )
    if len(lists) != 3:
        return f"expected 3 XCConfigurationList blocks, found {len(lists)}"
    for block in lists:
        ids = re.findall(r"^\s*([A-F0-9]{24}) /\* (?:Debug|Release|Profile)-[a-z]+ \*/,$", block, re.MULTILINE)
        missing = sorted(set(ids) - xc_configurations)
        if missing:
            return "buildConfigurations references missing XCBuildConfiguration IDs: " + ", ".join(missing)
        names = re.findall(r"/\* ((?:Debug|Release|Profile)-[a-z]+) \*/", block)
        expected = {f"{build}-{flavor}" for flavor in FLAVORS for build in ("Debug", "Release", "Profile")}
        if set(names) != expected:
            return "configuration list names mismatch: " + ", ".join(sorted(set(names) ^ expected))
    return "OK"


if __name__ == "__main__":
    result = main()
    print(result)
    sys.exit(0 if result == "OK" else 1)