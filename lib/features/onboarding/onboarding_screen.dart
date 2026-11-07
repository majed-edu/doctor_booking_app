import 'package:doctor_booking_app/core/theming/text_styles.dart';
import 'package:doctor_booking_app/features/onboarding/widgets/doc_logo_and_name.dart';
import 'package:doctor_booking_app/features/onboarding/widgets/doctor_image_and_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: 30.h, bottom: 30.h),
            child: Column(
              children: [
                const DocLogoAndName(),

                SizedBox(height: 30.h),

                const DoctorImageAndText(),


                Padding(
                  padding: const EdgeInsets.symmetric(  horizontal: 8.0),
                  child: Column(
                    children: [
                      Text(
                        'Book your doctor appointment in just a few taps and get the best medical care at your fingertips.',
                        style: TextStyles.font13GreyRegular,
                        textAlign: TextAlign.center ,
                      ),
                      SizedBox(
                        height: 30.h,
                      ),

                      

                      
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
