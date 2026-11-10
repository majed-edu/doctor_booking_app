import 'package:doctor_booking_app/core/routing/routes.dart';
import 'package:doctor_booking_app/core/theming/text_styles.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class AlreadyHaveAccountText extends StatelessWidget {
      const AlreadyHaveAccountText({super.key});

      @override
      Widget build(BuildContext context) {
        return RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Already have an account?',
                style: TextStyles.font13DarkBlueRegular
              ),
              TextSpan(
                text: ' Login',
                style: TextStyles.font13BlueSemiBold,
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.pushNamed(context, Routes.loginScreen);
                  },
              ),
            ],
          ),
        );
      }   
          
}
