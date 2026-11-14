import 'package:doctor_booking_app/core/theming/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppointmentStatusBadge extends StatelessWidget {
  final String status;
  const AppointmentStatusBadge({super.key, required this.status});
  @override
  Widget build(BuildContext context) {
    var background = ColorsManager.lightAmber;
    var foreground = ColorsManager.amber;
    if (status == 'confirmed' || status == 'completed') {
      background = ColorsManager.lightGreen;
      foreground = ColorsManager.green;
    } else if (status == 'cancelled') {
      background = ColorsManager.lightRed;
      foreground = ColorsManager.red;
    }
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        status.toUpperCase(),
        style: TextStyle(
          fontSize: 10.sp,
          fontWeight: FontWeight.bold,
          color: foreground,
        ),
      ),
    );
  }
}
