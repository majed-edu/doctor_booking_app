import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_booking_app/core/helpers/spacing.dart';
import 'package:doctor_booking_app/core/theming/colors.dart';
import 'package:doctor_booking_app/core/theming/text_styles.dart';
import 'package:doctor_booking_app/features/appointments/data/models/appointment_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'appointment_status_badge.dart';

class AppointmentCard extends StatelessWidget {
  final AppointmentModel appointment;
  final VoidCallback onTap;
  const AppointmentCard({
    super.key,
    required this.appointment,
    required this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    final doctor = appointment.doctor;
    final photo = doctor?.displayPhoto ?? '';
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: ColorsManager.lighterGray),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: photo.isNotEmpty
                      ? CachedNetworkImage(
                          imageUrl: photo,
                          width: 65.w,
                          height: 70.h,
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
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              doctor?.name ?? 'Doctor Name',
                              style: TextStyles.font15DarkBlueMedium.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          AppointmentStatusBadge(
                            status: appointment.displayStatus.toLowerCase(),
                          ),
                        ],
                      ),
                      verticalSpace(4),
                      Text(
                        doctor?.specialization?.name ??
                            doctor?.displayDegree ??
                            'Specialist',
                        style: TextStyles.font12BlueRegular,
                      ),
                      verticalSpace(4),
                      Text(
                        'Fee: \$${appointment.displayPrice}',
                        style: TextStyles.font12GrayMedium,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            verticalSpace(12),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: ColorsManager.moreLighterGray,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.calendar_today_outlined,
                    size: 15,
                    color: ColorsManager.mainBlue,
                  ),
                  horizontalSpace(8),
                  Expanded(
                    child: Text(
                      appointment.displayTime,
                      style: TextStyles.font12DarkBlueRegular.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const Icon(
                    Icons.arrow_forward_ios,
                    size: 12,
                    color: ColorsManager.gray,
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
    width: 65.w,
    height: 70.h,
    color: ColorsManager.moreLighterGray,
    child: const Icon(Icons.person, color: ColorsManager.lightGray, size: 30),
  );
}
