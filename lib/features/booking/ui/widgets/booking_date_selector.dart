import 'package:doctor_booking_app/core/helpers/spacing.dart';
import 'package:doctor_booking_app/core/theming/colors.dart';
import 'package:doctor_booking_app/features/booking/logic/booking_cubit.dart';
import 'package:doctor_booking_app/features/booking/logic/booking_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class BookingDateSelector extends StatelessWidget {
  final BookingState state;
  const BookingDateSelector({super.key, required this.state});
  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    return SizedBox(
      height: 92.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: 14,
        separatorBuilder: (_, __) => horizontalSpace(10),
        itemBuilder: (_, index) {
          final date = today.add(Duration(days: index + 1));
          final selected =
              state.selectedDate.year == date.year &&
              state.selectedDate.month == date.month &&
              state.selectedDate.day == date.day;
          return GestureDetector(
            onTap: () => context.read<BookingCubit>().selectDate(date),
            child: Container(
              width: 62.w,
              padding: EdgeInsets.symmetric(vertical: 8.h),
              decoration: BoxDecoration(
                color: selected ? ColorsManager.mainBlue : Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: selected
                      ? ColorsManager.mainBlue
                      : ColorsManager.lighterGray,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    DateFormat('E').format(date),
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: selected ? Colors.white70 : ColorsManager.gray,
                    ),
                  ),
                  verticalSpace(4),
                  Text(
                    '${date.day}',
                    style: TextStyle(
                      fontSize: 18.sp,
                      color: selected ? Colors.white : ColorsManager.darkBlue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  verticalSpace(2),
                  Text(
                    DateFormat('MMM').format(date),
                    style: TextStyle(
                      fontSize: 10.sp,
                      color: selected ? Colors.white70 : ColorsManager.gray,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
