import 'package:doctor_booking_app/core/helpers/spacing.dart';
import 'package:doctor_booking_app/core/theming/colors.dart';
import 'package:doctor_booking_app/core/theming/text_styles.dart';
import 'package:flutter/material.dart';

class PasswordValidations extends StatelessWidget {
  const PasswordValidations({
    super.key,
    required this.hasUpperCase,
    required this.hasLowerCase,
    required this.hasSpecialCharacter,
    required this.hasNumber,
    required this.hasMinLength,
    this.isVisible = true,
    this.showOnlyInvalid = false,
  });

  final bool hasUpperCase;
  final bool hasLowerCase;
  final bool hasSpecialCharacter;
  final bool hasNumber;
  final bool hasMinLength;
  final bool isVisible;
  final bool showOnlyInvalid;

  @override
  Widget build(BuildContext context) {
    if (!isVisible) {
      return const SizedBox.shrink();
    }

    final hasValidPassword =
        hasUpperCase &&
        hasLowerCase &&
        hasSpecialCharacter &&
        hasNumber &&
        hasMinLength;

    if (hasValidPassword) {
      return const SizedBox.shrink();
    }

    if (showOnlyInvalid) {
      return Container(
        width: double.infinity,
        margin: const EdgeInsets.only(top: 10),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: ColorsManager.lightRed,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: ColorsManager.red.withValues(alpha: 0.2)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(
              Icons.warning_amber_rounded,
              color: ColorsManager.red,
              size: 20,
            ),
            horizontalSpace(8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Password must include:',
                    style: TextStyles.font13DarkBlueRegular.copyWith(
                      color: ColorsManager.red,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  verticalSpace(4),
                  if (!hasUpperCase)
                    buildValidationRow('At least one uppercase letter', false),
                  if (!hasLowerCase)
                    buildValidationRow('At least one lowercase letter', false),
                  if (!hasSpecialCharacter)
                    buildValidationRow('At least one special character', false),
                  if (!hasNumber)
                    buildValidationRow('At least one number', false),
                  if (!hasMinLength)
                    buildValidationRow('At least 8 characters', false),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      children: [
        buildValidationRow('At least one uppercase letter', hasUpperCase),
        verticalSpace(2),
        buildValidationRow('At least one lowercase letter', hasLowerCase),
        verticalSpace(2),
        buildValidationRow(
          'At least one special character',
          hasSpecialCharacter,
        ),
        verticalSpace(2),
        buildValidationRow('At least one number', hasNumber),
        verticalSpace(2),
        buildValidationRow('At least 8 characters', hasMinLength),
      ],
    );
  }

  Widget buildValidationRow(String text, bool hasValidated) {
    return Row(
      children: [
        if (showOnlyInvalid)
          const Icon(Icons.close_rounded, color: ColorsManager.red, size: 15)
        else
          const CircleAvatar(radius: 2.5, backgroundColor: Colors.grey),
        horizontalSpace(6),
        Text(
          text,
          style: TextStyles.font13DarkBlueRegular.copyWith(
            decoration: hasValidated ? TextDecoration.lineThrough : null,
            decorationColor: Colors.green,
            decorationThickness: 2,
            color: showOnlyInvalid
                ? ColorsManager.red
                : hasValidated
                ? ColorsManager.gray
                : ColorsManager.darkBlue,
          ),
        ),
      ],
    );
  }
}
