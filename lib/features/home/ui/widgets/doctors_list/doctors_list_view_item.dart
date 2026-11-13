import 'package:doctor_booking_app/core/helpers/spacing.dart';
import 'package:doctor_booking_app/core/theming/text_styles.dart';
import 'package:doctor_booking_app/features/home/data/models/specializations_response_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DoctorsListViewItem extends StatelessWidget {
  const DoctorsListViewItem({super.key, this.doctorsModel});

  final Doctors? doctorsModel;

  @override
  Widget build(BuildContext context) {
    final imageUrl = doctorsModel?.photo ?? doctorsModel?.image;

    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: imageUrl?.isNotEmpty == true
                ? Image.network(
                    imageUrl!,
                    width: 110.w,
                    height: 120.h,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => _imagePlaceholder(),
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
                  '${doctorsModel?.degree ?? ''} | ${doctorsModel?.phone ?? ''}',
                  style: TextStyles.font12GrayMedium,
                  overflow: TextOverflow.ellipsis,
                ),
                verticalSpace(5),
                Text(
                  doctorsModel?.email ?? 'Email',
                  style: TextStyles.font12GrayMedium,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _imagePlaceholder() {
    return Container(
      width: 110.w,
      height: 120.h,
      color: Colors.grey.shade200,
      child: const Icon(Icons.person_outline),
    );
  }
}
