import 'package:doctor_booking_app/core/helpers/spacing.dart';
import 'package:doctor_booking_app/core/theming/colors.dart';
import 'package:doctor_booking_app/core/theming/text_styles.dart';
import 'package:doctor_booking_app/features/home/data/models/specializations_response_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DoctorDetailsLocation extends StatelessWidget {
  final Doctors doctor;
  const DoctorDetailsLocation({super.key, required this.doctor});
  @override
  Widget build(BuildContext context) => Container(
    padding: EdgeInsets.all(14.w),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: ColorsManager.lighterGray),
    ),
    child: Row(
      children: [
        Container(
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            color: ColorsManager.lightBlue,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(
            Icons.location_on_outlined,
            color: ColorsManager.mainBlue,
            size: 22,
          ),
        ),
        horizontalSpace(12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                doctor.displayLocation.isNotEmpty
                    ? doctor.displayLocation
                    : 'Clinic Location',
                style: TextStyles.font14DarkBlueMedium.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (doctor.address != null && doctor.address!.isNotEmpty) ...[
                verticalSpace(2),
                Text(doctor.address!, style: TextStyles.font12GrayRegular),
              ],
            ],
          ),
        ),
      ],
    ),
  );
}
