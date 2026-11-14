import 'package:doctor_booking_app/core/helpers/spacing.dart';
import 'package:doctor_booking_app/core/theming/colors.dart';
import 'package:doctor_booking_app/core/theming/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppointmentsEmptyState extends StatelessWidget {
  final VoidCallback onFindDoctor;
  const AppointmentsEmptyState({super.key, required this.onFindDoctor});
  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: EdgeInsets.all(24.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.calendar_month_outlined,
            size: 64.sp,
            color: ColorsManager.lightGray,
          ),
          verticalSpace(16),
          Text(
            'No Appointments Booked',
            style: TextStyles.font18DarkBlueSemiBold,
          ),
          verticalSpace(8),
          Text(
            'You have no scheduled appointments yet. Find a doctor and book your consultation now.',
            style: TextStyles.font12GrayRegular,
            textAlign: TextAlign.center,
          ),
          verticalSpace(16),
          ElevatedButton(
            onPressed: onFindDoctor,
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorsManager.mainBlue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'Find a Doctor',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    ),
  );
}
