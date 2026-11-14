import 'package:doctor_booking_app/core/helpers/spacing.dart';
import 'package:doctor_booking_app/core/theming/colors.dart';
import 'package:doctor_booking_app/core/theming/text_styles.dart';
import 'package:doctor_booking_app/features/profile/data/models/user_profile_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileHeader extends StatelessWidget {
  final UserModel user;
  final VoidCallback onEdit;
  const ProfileHeader({super.key, required this.user, required this.onEdit});
  @override
  Widget build(BuildContext context) {
    final initials = user.name != null && user.name!.trim().isNotEmpty
        ? user.name!
              .trim()
              .split(' ')
              .map((e) => e.isNotEmpty ? e[0] : '')
              .take(2)
              .join()
        : 'U';
    return Center(
      child: Column(
        children: [
          CircleAvatar(
            radius: 46.r,
            backgroundColor: ColorsManager.lightBlue,
            child: Text(
              initials.toUpperCase(),
              style: TextStyle(
                fontSize: 28.sp,
                fontWeight: FontWeight.bold,
                color: ColorsManager.mainBlue,
              ),
            ),
          ),
          verticalSpace(14),
          Text(user.name ?? 'User Name', style: TextStyles.font18DarkBlueBold),
          verticalSpace(4),
          Text(
            user.email ?? 'user@example.com',
            style: TextStyles.font12GrayRegular,
          ),
          verticalSpace(12),
          OutlinedButton.icon(
            onPressed: onEdit,
            icon: const Icon(
              Icons.edit_outlined,
              size: 16,
              color: ColorsManager.mainBlue,
            ),
            label: Text('Edit Profile', style: TextStyles.font12BlueRegular),
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: ColorsManager.mainBlue),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
