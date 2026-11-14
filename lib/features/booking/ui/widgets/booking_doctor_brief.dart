import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_booking_app/core/helpers/spacing.dart';
import 'package:doctor_booking_app/core/theming/colors.dart';
import 'package:doctor_booking_app/core/theming/text_styles.dart';
import 'package:doctor_booking_app/features/home/data/models/specializations_response_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookingDoctorBrief extends StatelessWidget {
  final Doctors doctor;
  const BookingDoctorBrief({super.key, required this.doctor});
  @override
  Widget build(BuildContext context) => Container(
    padding: EdgeInsets.all(12.w),
    decoration: BoxDecoration(
      color: ColorsManager.lightBlue,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: ColorsManager.lighterGray),
    ),
    child: Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: doctor.displayPhoto.isNotEmpty
              ? CachedNetworkImage(
                  imageUrl: doctor.displayPhoto,
                  width: 70.w,
                  height: 75.h,
                  fit: BoxFit.cover,
                  errorWidget: (_, __, ___) => _placeholder(),
                )
              : _placeholder(),
        ),
        horizontalSpace(12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                doctor.name ?? 'Doctor Name',
                style: TextStyles.font15DarkBlueMedium.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              verticalSpace(4),
              Text(
                doctor.specialization?.name ?? doctor.displayDegree,
                style: TextStyles.font12BlueRegular,
              ),
              verticalSpace(4),
              Text(
                'Fee: \$${doctor.displayPrice}',
                style: TextStyles.font13DarkBlueMedium.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
  Widget _placeholder() => Container(
    width: 70.w,
    height: 75.h,
    color: ColorsManager.moreLighterGray,
    child: const Icon(Icons.person, color: ColorsManager.lightGray, size: 32),
  );
}
