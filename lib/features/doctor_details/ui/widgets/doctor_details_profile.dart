import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_booking_app/core/helpers/spacing.dart';
import 'package:doctor_booking_app/core/theming/colors.dart';
import 'package:doctor_booking_app/core/theming/text_styles.dart';
import 'package:doctor_booking_app/features/home/data/models/specializations_response_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class DoctorDetailsProfile extends StatelessWidget {
  final Doctors doctor;
  const DoctorDetailsProfile({super.key, required this.doctor});
  @override
  Widget build(BuildContext context) => Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: doctor.displayPhoto.isNotEmpty
            ? CachedNetworkImage(
                imageUrl: doctor.displayPhoto,
                width: 110.w,
                height: 120.h,
                fit: BoxFit.cover,
                placeholder: (_, __) => Shimmer.fromColors(
                  baseColor: ColorsManager.lighterGray,
                  highlightColor: Colors.white,
                  child: SizedBox(width: 110.w, height: 120.h),
                ),
                errorWidget: (_, __, ___) => _placeholder(),
              )
            : _placeholder(),
      ),
      horizontalSpace(16),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              doctor.name ?? 'Doctor Name',
              style: TextStyles.font18DarkBlueBold,
            ),
            verticalSpace(6),
            Text(
              doctor.specialization?.name ?? doctor.displayDegree,
              style: TextStyles.font13BlueRegular.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            verticalSpace(6),
            Text(doctor.displayDegree, style: TextStyles.font12GrayRegular),
            verticalSpace(8),
            Row(
              children: [
                const Icon(Icons.star, size: 16, color: Colors.amber),
                horizontalSpace(4),
                Text(
                  (doctor.rating ?? 4.9).toStringAsFixed(1),
                  style: TextStyles.font12DarkBlueRegular.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (doctor.experience != null) ...[
                  horizontalSpace(12),
                  const Icon(
                    Icons.work_outline,
                    size: 15,
                    color: ColorsManager.gray,
                  ),
                  horizontalSpace(4),
                  Text(
                    '${doctor.experience} Years Exp.',
                    style: TextStyles.font12GrayRegular,
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    ],
  );
  Widget _placeholder() => Container(
    width: 110.w,
    height: 120.h,
    color: ColorsManager.moreLighterGray,
    child: const Icon(Icons.person, color: ColorsManager.lightGray, size: 48),
  );
}
