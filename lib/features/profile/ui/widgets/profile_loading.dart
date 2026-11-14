import 'package:doctor_booking_app/core/helpers/spacing.dart';
import 'package:doctor_booking_app/core/theming/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ProfileLoading extends StatelessWidget {
  const ProfileLoading({super.key});
  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.all(20.w),
    child: Column(
      children: [
        Shimmer.fromColors(
          baseColor: ColorsManager.lighterGray,
          highlightColor: Colors.white,
          child: CircleAvatar(radius: 46.r, backgroundColor: Colors.white),
        ),
        verticalSpace(24),
        Shimmer.fromColors(
          baseColor: ColorsManager.lighterGray,
          highlightColor: Colors.white,
          child: Container(
            height: 180.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ],
    ),
  );
}
