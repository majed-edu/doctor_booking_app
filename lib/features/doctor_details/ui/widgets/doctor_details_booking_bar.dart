import 'package:doctor_booking_app/core/helpers/spacing.dart';
import 'package:doctor_booking_app/core/routing/routes.dart';
import 'package:doctor_booking_app/core/theming/colors.dart';
import 'package:doctor_booking_app/core/theming/text_styles.dart';
import 'package:doctor_booking_app/features/home/data/models/specializations_response_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DoctorDetailsBookingBar extends StatelessWidget {
  final Doctors doctor;
  const DoctorDetailsBookingBar({super.key, required this.doctor});
  @override
  Widget build(BuildContext context) => Container(
    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
    decoration: BoxDecoration(
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.05),
          offset: const Offset(0, -3),
          blurRadius: 10,
        ),
      ],
    ),
    child: Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Price', style: TextStyles.font12GrayRegular),
            verticalSpace(2),
            Text(
              '\$${doctor.displayPrice}',
              style: TextStyles.font18DarkBlueBold.copyWith(
                color: ColorsManager.mainBlue,
              ),
            ),
          ],
        ),
        horizontalSpace(24),
        Expanded(
          child: ElevatedButton(
            onPressed: () => Navigator.of(
              context,
            ).pushNamed(Routes.bookingScreen, arguments: doctor),
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorsManager.mainBlue,
              elevation: 0,
              padding: EdgeInsets.symmetric(vertical: 14.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              'Book Appointment',
              style: TextStyles.font16WhiteSemiBold,
            ),
          ),
        ),
      ],
    ),
  );
}
