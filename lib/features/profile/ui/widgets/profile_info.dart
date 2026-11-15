import 'package:doctor_booking_app/core/helpers/spacing.dart';
import 'package:doctor_booking_app/core/theming/colors.dart';
import 'package:doctor_booking_app/core/theming/text_styles.dart';
import 'package:doctor_booking_app/features/profile/data/models/user_profile_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileInfo extends StatelessWidget {
  final UserModel user;
  const ProfileInfo({super.key, required this.user});
  @override
  Widget build(BuildContext context) => Container(
    padding: EdgeInsets.all(16.w),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: ColorsManager.lighterGray),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Account Information',
          style: TextStyles.font14DarkBlueMedium.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        verticalSpace(14),
        _row(Icons.phone_outlined, 'Phone', user.phone ?? 'Not specified'),
        Divider(height: 20.h, color: ColorsManager.lighterGray),
        _row(Icons.person_outline, 'Gender', user.displayGender),
        Divider(height: 20.h, color: ColorsManager.lighterGray),
        _row(Icons.badge_outlined, 'Account Type', user.type ?? 'Patient'),
      ],
    ),
  );
  Widget _row(IconData icon, String label, String value) => Row(
    children: [
      Icon(icon, size: 18, color: ColorsManager.gray),
      horizontalSpace(12),
      Text(label, style: TextStyles.font12GrayRegular),
      const Spacer(),
      Text(
        value,
        style: TextStyles.font13DarkBlueMedium.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
    ],
  );
}
