import 'package:doctor_booking_app/core/helpers/spacing.dart';
import 'package:doctor_booking_app/core/theming/colors.dart';
import 'package:doctor_booking_app/core/theming/text_styles.dart';
import 'package:doctor_booking_app/features/booking/logic/booking_state.dart';
import 'booking_time_slots.dart';
import 'package:doctor_booking_app/features/home/data/models/specializations_response_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class BookingSummary extends StatelessWidget {
  final Doctors doctor;
  final BookingState state;
  const BookingSummary({super.key, required this.doctor, required this.state});
  @override
  Widget build(BuildContext context) {
    final slot = BookingTimeSlots.slots.firstWhere(
      (s) => s['value'] == state.selectedTimeSlot,
      orElse: () => {'label': state.selectedTimeSlot},
    )['label'];
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: ColorsManager.moreLighterGray,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: ColorsManager.lighterGray),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Booking Summary',
            style: TextStyles.font14DarkBlueMedium.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          verticalSpace(10),
          _row(
            'Date',
            DateFormat('EEEE, MMM d, yyyy').format(state.selectedDate),
          ),
          verticalSpace(6),
          _row('Time', slot ?? state.selectedTimeSlot),
          verticalSpace(6),
          _row('Consultation Fee', '\$${doctor.displayPrice}'),
        ],
      ),
    );
  }

  Widget _row(String a, String b) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(a, style: TextStyles.font12GrayRegular),
      Text(
        b,
        style: TextStyles.font12DarkBlueRegular.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
    ],
  );
}
