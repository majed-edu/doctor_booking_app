import 'package:doctor_booking_app/features/booking/logic/booking_cubit.dart';
import 'package:doctor_booking_app/features/booking/logic/booking_state.dart';
import 'package:doctor_booking_app/core/theming/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookingTimeSlots extends StatelessWidget {
  final BookingState state;
  const BookingTimeSlots({super.key, required this.state});
  static const slots = [
    {'label': '09:00 AM', 'value': '09:00:00'},
    {'label': '10:00 AM', 'value': '10:00:00'},
    {'label': '11:30 AM', 'value': '11:30:00'},
    {'label': '01:00 PM', 'value': '13:00:00'},
    {'label': '02:30 PM', 'value': '14:30:00'},
    {'label': '04:00 PM', 'value': '16:00:00'},
    {'label': '05:30 PM', 'value': '17:30:00'},
    {'label': '07:00 PM', 'value': '19:00:00'},
  ];
  @override
  Widget build(BuildContext context) => Wrap(
    spacing: 10.w,
    runSpacing: 10.h,
    children: slots.map((slot) {
      final selected = state.selectedTimeSlot == slot['value'];
      return GestureDetector(
        onTap: () =>
            context.read<BookingCubit>().selectTimeSlot(slot['value']!),
        child: Container(
          width: 100.w,
          padding: EdgeInsets.symmetric(vertical: 10.h),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: selected ? ColorsManager.mainBlue : Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: selected
                  ? ColorsManager.mainBlue
                  : ColorsManager.lighterGray,
            ),
          ),
          child: Text(
            slot['label']!,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: selected ? FontWeight.bold : FontWeight.w500,
              color: selected ? Colors.white : ColorsManager.darkBlue,
            ),
          ),
        ),
      );
    }).toList(),
  );
}
