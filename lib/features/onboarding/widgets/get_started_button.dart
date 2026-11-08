import 'package:doctor_booking_app/core/helpers/extentions.dart';
import 'package:doctor_booking_app/core/routing/routes.dart';
import 'package:doctor_booking_app/core/theming/colors.dart';
import 'package:doctor_booking_app/core/theming/text_styles.dart';
import 'package:flutter/material.dart';

class GetStartedButton extends StatelessWidget {
  const GetStartedButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: ()
       {
        context.pushNamed(Routes.loginScreen);

      },
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all<Color>(ColorsManager.mainBlue),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        minimumSize: WidgetStateProperty.all(
          const Size(double.infinity, 52
          )
          ),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
        ),

      ),

      child:  Text(
      'Get Started',
      style: TextStyles.font16WhiteSemiBold,
      
      ),
    );
  }
}