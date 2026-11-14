import 'package:doctor_booking_app/core/theming/colors.dart';
import 'package:doctor_booking_app/core/theming/text_styles.dart';
import 'package:doctor_booking_app/features/profile/logic/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileLogoutButton extends StatelessWidget {
  final VoidCallback onPressed;
  const ProfileLogoutButton({super.key, required this.onPressed});
  @override
  Widget build(BuildContext context) => SizedBox(
    width: double.infinity,
    child: OutlinedButton.icon(
      onPressed: onPressed,
      icon: const Icon(
        Icons.logout_rounded,
        color: ColorsManager.red,
        size: 18,
      ),
      label: Text(
        'Log Out',
        style: TextStyle(
          color: ColorsManager.red,
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: ColorsManager.red),
        padding: EdgeInsets.symmetric(vertical: 14.h),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
  );
}

void showLogoutDialog(BuildContext context) => showDialog(
  context: context,
  builder: (dialogCtx) => AlertDialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
    title: Text('Log Out', style: TextStyles.font18DarkBlueBold),
    content: Text(
      'Are you sure you want to log out from DocApp?',
      style: TextStyles.font14DarkBlueMedium,
    ),
    actions: [
      TextButton(
        onPressed: () => Navigator.of(dialogCtx).pop(),
        child: Text('Cancel', style: TextStyles.font12GrayMedium),
      ),
      ElevatedButton(
        onPressed: () {
          Navigator.of(dialogCtx).pop();
          context.read<ProfileCubit>().logout();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorsManager.red,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: const Text('Log Out', style: TextStyle(color: Colors.white)),
      ),
    ],
  ),
);
