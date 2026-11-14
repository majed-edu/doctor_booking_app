import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_booking_app/core/helpers/spacing.dart';
import 'package:doctor_booking_app/core/routing/routes.dart';
import 'package:doctor_booking_app/core/theming/colors.dart';
import 'package:doctor_booking_app/core/theming/text_styles.dart';
import 'package:doctor_booking_app/features/home/data/models/specializations_response_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class DoctorCard extends StatelessWidget {
  final Doctors doctor;
  const DoctorCard({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    final photo = doctor.displayPhoto;
    return InkWell(
      onTap: () => Navigator.of(
        context,
      ).pushNamed(Routes.doctorDetailsScreen, arguments: doctor),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: ColorsManager.lighterGray),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: photo.isNotEmpty
                  ? CachedNetworkImage(
                      imageUrl: photo,
                      width: 90.w,
                      height: 100.h,
                      fit: BoxFit.cover,
                      placeholder: (_, __) => Shimmer.fromColors(
                        baseColor: ColorsManager.lighterGray,
                        highlightColor: Colors.white,
                        child: Container(
                          width: 90.w,
                          height: 100.h,
                          color: Colors.white,
                        ),
                      ),
                      errorWidget: (_, __, ___) => _placeholder(),
                    )
                  : _placeholder(),
            ),
            horizontalSpace(14),
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
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  verticalSpace(6),
                  Row(
                    children: [
                      const Icon(Icons.star, size: 15, color: Colors.amber),
                      horizontalSpace(4),
                      Text(
                        (doctor.rating ?? 4.8).toStringAsFixed(1),
                        style: TextStyles.font12DarkBlueRegular.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      horizontalSpace(12),
                      if (doctor.experience != null) ...[
                        const Icon(
                          Icons.work_outline,
                          size: 14,
                          color: ColorsManager.gray,
                        ),
                        horizontalSpace(4),
                        Text(
                          '${doctor.experience} yrs',
                          style: TextStyles.font12GrayRegular,
                        ),
                      ],
                    ],
                  ),
                  verticalSpace(6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (doctor.displayLocation.isNotEmpty)
                        Expanded(
                          child: Row(
                            children: [
                              const Icon(
                                Icons.location_on_outlined,
                                size: 14,
                                color: ColorsManager.gray,
                              ),
                              horizontalSpace(2),
                              Expanded(
                                child: Text(
                                  doctor.displayLocation,
                                  style: TextStyles.font12GrayRegular,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      Text(
                        '\$${doctor.displayPrice}',
                        style: TextStyles.font14kBlueSemiBold,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _placeholder() => Container(
    width: 90.w,
    height: 100.h,
    color: ColorsManager.moreLighterGray,
    child: const Icon(Icons.person, color: ColorsManager.lightGray, size: 36),
  );
}
