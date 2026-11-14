import 'package:doctor_booking_app/core/helpers/spacing.dart';
import 'package:doctor_booking_app/core/theming/colors.dart';
import 'package:doctor_booking_app/core/theming/text_styles.dart';
import 'package:doctor_booking_app/features/home/data/models/specializations_response_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DoctorDetailsContact extends StatelessWidget {
  final Doctors doctor;
  const DoctorDetailsContact({super.key, required this.doctor});
  @override
  Widget build(BuildContext context) => Container(
    padding: EdgeInsets.all(14.w),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: ColorsManager.lighterGray),
    ),
    child: Column(
      children: [
        if (doctor.phone != null)
          Row(
            children: [
              const Icon(
                Icons.phone_outlined,
                color: ColorsManager.gray,
                size: 20,
              ),
              horizontalSpace(12),
              Text(doctor.phone!, style: TextStyles.font13DarkBlueMedium),
            ],
          ),
        if (doctor.phone != null && doctor.email != null)
          Divider(height: 20.h, color: ColorsManager.lighterGray),
        if (doctor.email != null)
          Row(
            children: [
              const Icon(
                Icons.email_outlined,
                color: ColorsManager.gray,
                size: 20,
              ),
              horizontalSpace(12),
              Text(doctor.email!, style: TextStyles.font13DarkBlueMedium),
            ],
          ),
      ],
    ),
  );
}
