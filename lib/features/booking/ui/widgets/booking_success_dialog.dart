import 'package:doctor_booking_app/core/helpers/spacing.dart';
import 'package:doctor_booking_app/core/theming/colors.dart';
import 'package:doctor_booking_app/core/theming/text_styles.dart';
import 'package:doctor_booking_app/features/booking/logic/booking_state.dart';
import 'package:doctor_booking_app/features/home/data/models/specializations_response_model.dart';
import 'package:doctor_booking_app/features/main_layout/logic/main_layout_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

void showBookingSuccessDialog(
  BuildContext context,
  Doctors doctor,
  BookingState state,
) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (dialogContext) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      contentPadding: EdgeInsets.all(24.w),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 60.w,
            height: 60.w,
            decoration: const BoxDecoration(
              color: ColorsManager.lightGreen,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.check,
              color: ColorsManager.green,
              size: 36,
            ),
          ),
          verticalSpace(16),
          Text(
            'Booking Confirmed!',
            style: TextStyles.font18DarkBlueBold,
            textAlign: TextAlign.center,
          ),
          verticalSpace(8),
          Text(
            'Your appointment with ${doctor.name ?? 'Doctor'} has been scheduled successfully.',
            style: TextStyles.font12GrayRegular,
            textAlign: TextAlign.center,
          ),
          verticalSpace(16),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: ColorsManager.lightBlue,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Text(
                  DateFormat('MMM d, yyyy').format(state.selectedDate),
                  style: TextStyles.font14DarkBlueMedium.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                verticalSpace(4),
                Text(
                  state.selectedTimeSlot,
                  style: TextStyles.font12BlueRegular,
                ),
              ],
            ),
          ),
          verticalSpace(20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
                Navigator.of(context).pop();
                context.read<MainLayoutCubit>().changeTab(2);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorsManager.mainBlue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'View My Appointments',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          verticalSpace(8),
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              Navigator.of(context).pop();
            },
            child: Text('Done', style: TextStyles.font12GrayMedium),
          ),
        ],
      ),
    ),
  );
}
