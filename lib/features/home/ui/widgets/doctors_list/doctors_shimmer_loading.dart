import 'package:doctor_booking_app/core/helpers/spacing.dart';
import 'package:doctor_booking_app/core/theming/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class DoctorsShimmerLoading extends StatelessWidget {
  const DoctorsShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        itemCount: 6,
        separatorBuilder: (_, __) => verticalSpace(16),
        itemBuilder: (_, __) => Row(
          children: [
            _shimmer(width: 110.w, height: 120.h, radius: 12),
            horizontalSpace(16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _shimmer(width: 180.w, height: 18.h),
                  verticalSpace(12),
                  _shimmer(width: 160.w, height: 14.h),
                  verticalSpace(12),
                  _shimmer(width: 160.w, height: 14.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _shimmer({
    required double width,
    required double height,
    double radius = 8,
  }) {
    return Shimmer.fromColors(
      baseColor: ColorsManager.lightGray,
      highlightColor: Colors.white,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: ColorsManager.lightGray,
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
    );
  }
}
