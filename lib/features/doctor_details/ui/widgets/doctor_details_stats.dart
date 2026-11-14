import 'package:doctor_booking_app/core/helpers/spacing.dart';
import 'package:doctor_booking_app/core/theming/colors.dart';
import 'package:doctor_booking_app/core/theming/text_styles.dart';
import 'package:doctor_booking_app/features/home/data/models/specializations_response_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DoctorDetailsStats extends StatelessWidget {
  final Doctors doctor;
  const DoctorDetailsStats({super.key, required this.doctor});
  @override
  Widget build(BuildContext context) => Row(
    children: [
      _item(Icons.attach_money, 'Consultation Fee', '\$${doctor.displayPrice}'),
      horizontalSpace(12),
      _item(
        Icons.access_time_rounded,
        'Working Hours',
        doctor.startTime != null && doctor.endTime != null
            ? '${doctor.startTime!.substring(0, 5)} - ${doctor.endTime!.substring(0, 5)}'
            : '09:00 - 17:00',
      ),
    ],
  );
  Widget _item(IconData icon, String title, String value) => Expanded(
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: ColorsManager.lightBlue,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: ColorsManager.lighterGray),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: ColorsManager.mainBlue, size: 20),
          ),
          horizontalSpace(10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyles.font12GrayRegular,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                verticalSpace(2),
                Text(
                  value,
                  style: TextStyles.font14DarkBlueMedium.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
