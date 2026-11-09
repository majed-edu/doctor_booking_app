import 'package:doctor_booking_app/core/theming/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DoctorImageAndText extends StatelessWidget {
  const DoctorImageAndText({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SvgPicture.asset('assets/svgs/docdoc_logo_low_opacity.svg'),

        Container(
          foregroundDecoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.white,
               Colors.white.withValues(alpha: 0.0),
               ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              stops: const [0.14, 0.4],
            ),
          ),
          child: Image.asset(
            'assets/images/onboarding_doctor.png',
            // fit: BoxFit.cover,
          ),
        ),
        Positioned(
          // top: 0,
          left: 0,
          right: 0,
          bottom: 30,
          child: Center(
            child: Text(
              'Best Doctor\nAppointment App',
              textAlign: TextAlign.center,

              style: TextStyles.font32BlueBold.copyWith(height: 1.4),
            ),
          ),
        ),
      ],
    );
  }
}
