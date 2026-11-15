import 'package:doctor_booking_app/core/helpers/spacing.dart';
import 'package:doctor_booking_app/core/theming/colors.dart';
import 'package:doctor_booking_app/core/theming/text_styles.dart';
import 'package:doctor_booking_app/features/profile/logic/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileError extends StatelessWidget {
  final String? error;
  const ProfileError({super.key, this.error});
  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: EdgeInsets.all(24.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline_rounded,
            size: 54.sp,
            color: ColorsManager.red,
          ),
          verticalSpace(16),
          Text(
            'Failed to Load Profile',
            style: TextStyles.font18DarkBlueSemiBold,
          ),
          verticalSpace(8),
          Text(
            error ?? 'An unexpected error occurred. Please try again.',
            style: TextStyles.font12GrayRegular,
            textAlign: TextAlign.center,
          ),
          verticalSpace(16),
          ElevatedButton.icon(
            onPressed: () => context.read<ProfileCubit>().getUserProfile(),
            icon: const Icon(Icons.refresh, color: Colors.white),
            label: const Text('Retry', style: TextStyle(color: Colors.white)),
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorsManager.mainBlue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
