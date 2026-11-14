import 'package:doctor_booking_app/core/helpers/spacing.dart';
import 'package:doctor_booking_app/core/theming/colors.dart';
import 'package:doctor_booking_app/core/theming/text_styles.dart';
import 'package:doctor_booking_app/features/profile/data/models/user_profile_model.dart';
import 'package:doctor_booking_app/features/profile/logic/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void showProfileEditSheet(BuildContext context, UserModel user) {
  final name = TextEditingController(text: user.name ?? '');
  final email = TextEditingController(text: user.email ?? '');
  final phone = TextEditingController(text: user.phone ?? '');
  var gender = (user.gender ?? '0').toString();
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (sheetContext) => StatefulBuilder(
      builder: (context, setState) => Padding(
        padding: EdgeInsets.only(
          left: 20.w,
          right: 20.w,
          top: 20.h,
          bottom: MediaQuery.of(sheetContext).viewInsets.bottom + 20.h,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: ColorsManager.lightGray,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              verticalSpace(16),
              Text('Edit Profile', style: TextStyles.font18DarkBlueBold),
              verticalSpace(16),
              _field('Full Name', name),
              verticalSpace(12),
              _field('Email', email, TextInputType.emailAddress),
              verticalSpace(12),
              _field('Phone', phone, TextInputType.phone),
              verticalSpace(12),
              Text('Gender', style: TextStyles.font12GrayRegular),
              verticalSpace(6),
              Row(
                children: [
                  Expanded(
                    child: RadioListTile<String>(
                      title: const Text('Male'),
                      value: '0',
                      groupValue: gender,
                      contentPadding: EdgeInsets.zero,
                      onChanged: (v) => setState(() => gender = v!),
                    ),
                  ),
                  Expanded(
                    child: RadioListTile<String>(
                      title: const Text('Female'),
                      value: '1',
                      groupValue: gender,
                      contentPadding: EdgeInsets.zero,
                      onChanged: (v) => setState(() => gender = v!),
                    ),
                  ),
                ],
              ),
              verticalSpace(20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(sheetContext).pop();
                    context.read<ProfileCubit>().updateUserProfile(
                      name: name.text.trim(),
                      email: email.text.trim(),
                      phone: phone.text.trim(),
                      gender: gender,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorsManager.mainBlue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                  ),
                  child: const Text(
                    'Save Changes',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget _field(
  String label,
  TextEditingController controller, [
  TextInputType type = TextInputType.text,
]) => Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Text(label, style: TextStyles.font12GrayRegular),
    verticalSpace(6),
    TextField(
      controller: controller,
      keyboardType: type,
      decoration: InputDecoration(
        isDense: true,
        filled: true,
        fillColor: ColorsManager.moreLighterGray,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: ColorsManager.lighterGray),
        ),
      ),
      style: TextStyles.font14DarkBlueMedium,
    ),
  ],
);
