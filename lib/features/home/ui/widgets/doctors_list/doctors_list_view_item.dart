import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_booking_app/core/helpers/spacing.dart';
import 'package:doctor_booking_app/core/routing/routes.dart';
import 'package:doctor_booking_app/core/theming/colors.dart';
import 'package:doctor_booking_app/core/theming/text_styles.dart';
import 'package:doctor_booking_app/features/home/data/models/specializations_response_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class DoctorsListViewItem extends StatelessWidget {
  const DoctorsListViewItem({super.key, this.doctorsModel});

  final Doctors? doctorsModel;

  @override
  Widget build(BuildContext context) {
    final imageUrl = doctorsModel?.displayPhoto ?? '';

    return InkWell(
      onTap: () {
        if (doctorsModel != null) {
          Navigator.of(context).pushNamed(
            Routes.doctorDetailsScreen,
            arguments: doctorsModel,
          );
        }
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        margin: EdgeInsets.only(bottom: 16.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: imageUrl.isNotEmpty
                  ? CachedNetworkImage(
                      imageUrl: imageUrl,
                      width: 100.w,
                      height: 105.h,
                      fit: BoxFit.cover,
                      placeholder: (_, __) => Shimmer.fromColors(
                        baseColor: ColorsManager.lighterGray,
                        highlightColor: Colors.white,
                        child: Container(
                          width: 100.w,
                          height: 105.h,
                          color: Colors.white,
                        ),
                      ),
                      errorWidget: (_, __, ___) => _imagePlaceholder(),
                    )
                  : _imagePlaceholder(),
            ),
            horizontalSpace(16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    doctorsModel?.name ?? 'Name',
                    style: TextStyles.font18DarkBlueBold,
                    overflow: TextOverflow.ellipsis,
                  ),
                  verticalSpace(5),
                  Text(
                    '${doctorsModel?.displayDegree ?? 'Specialist'} | ${doctorsModel?.phone ?? ''}',
                    style: TextStyles.font12GrayMedium,
                    overflow: TextOverflow.ellipsis,
                  ),
                  verticalSpace(5),
                  Text(
                    doctorsModel?.email ?? 'Email',
                    style: TextStyles.font12GrayMedium,
                    overflow: TextOverflow.ellipsis,
                  ),
                  verticalSpace(6),
                  Row(
                    children: [
                      const Icon(Icons.star, size: 14, color: Colors.amber),
                      horizontalSpace(4),
                      Text(
                        (doctorsModel?.rating ?? 4.9).toStringAsFixed(1),
                        style: TextStyles.font12DarkBlueRegular.copyWith(fontWeight: FontWeight.w600),
                      ),
                      const Spacer(),
                      Text(
                        '\$${doctorsModel?.displayPrice ?? 0}',
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

  Widget _imagePlaceholder() {
    return Container(
      width: 100.w,
      height: 105.h,
      color: ColorsManager.moreLighterGray,
      child: const Icon(Icons.person, color: ColorsManager.lightGray, size: 36),
    );
  }
}
