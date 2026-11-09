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
  });

  final bool hasUpperCase;
  final bool hasLowerCase;
  final bool hasSpecialCharacter;
  final bool hasNumber;
  final bool hasMinLength;


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildValidationRow('At least one uppercase letter', hasUpperCase),
        verticalSpace(2),
        buildValidationRow('At least one lowercase letter', hasLowerCase),
        verticalSpace(2),
        buildValidationRow('At least one special character', hasSpecialCharacter),
        verticalSpace(2),
        buildValidationRow('At least one number', hasNumber),
        verticalSpace(2),
        buildValidationRow('At least 8 characters', hasMinLength),
      ],
    );
  }

  Widget buildValidationRow(String text, bool hasValidated ) {
    return Row(
      children: [
        const CircleAvatar(
          radius: 2.5,
          backgroundColor: Colors.grey,
        ),
        horizontalSpace(6) ,
        Text(
          text,
          style: TextStyles.font13DarkBlueRegular.copyWith(
            decoration: hasValidated ? TextDecoration.lineThrough : null,
            decorationColor: Colors.green,
            decorationThickness: 2,
            color: hasValidated ? ColorsManager.gray : ColorsManager.darkBlue,
          ),
        
          

        ),
      ],
    );

  }
}
