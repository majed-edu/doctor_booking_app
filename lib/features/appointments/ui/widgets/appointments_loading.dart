import 'package:doctor_booking_app/core/helpers/spacing.dart';
import 'package:doctor_booking_app/core/theming/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class AppointmentsLoading extends StatelessWidget {
  const AppointmentsLoading({super.key});
  @override
  Widget build(BuildContext context) => ListView.separated(
    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
    itemCount: 4,
    separatorBuilder: (_, __) => verticalSpace(12),
    itemBuilder: (_, __) => Shimmer.fromColors(
      baseColor: ColorsManager.lighterGray,
      highlightColor: Colors.white,
      child: Container(
        height: 120.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    ),
  );
}
