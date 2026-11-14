import 'package:doctor_booking_app/core/helpers/spacing.dart';
import 'package:doctor_booking_app/core/theming/colors.dart';
import 'package:doctor_booking_app/core/theming/text_styles.dart';
import 'package:doctor_booking_app/features/appointments/data/models/appointment_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void showAppointmentDetails(
  BuildContext context,
  AppointmentModel appointment,
) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (sheetContext) => Padding(
      padding: EdgeInsets.all(20.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: ColorsManager.lightGray,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          verticalSpace(16),
          Text('Appointment Details', style: TextStyles.font18DarkBlueBold),
          verticalSpace(16),
          _row('Booking ID', '#${appointment.id ?? '---'}'),
          verticalSpace(8),
          _row('Doctor', appointment.doctor?.name ?? '---'),
          verticalSpace(8),
          _row(
            'Specialization',
            appointment.doctor?.specialization?.name ?? '---',
          ),
          verticalSpace(8),
          _row('Date & Time', appointment.displayTime),
          verticalSpace(8),
          _row('Consultation Fee', '\$${appointment.displayPrice}'),
          verticalSpace(8),
          _row('Status', appointment.displayStatus.toUpperCase()),
          if (appointment.notes != null && appointment.notes!.isNotEmpty) ...[
            verticalSpace(8),
            _row('Notes', appointment.notes!),
          ],
          verticalSpace(24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Navigator.of(sheetContext).pop(),
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorsManager.mainBlue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text('Close', style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _row(String title, String value) => Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Text(title, style: TextStyles.font12GrayRegular),
    horizontalSpace(12),
    Expanded(
      child: Text(
        value,
        textAlign: TextAlign.end,
        style: TextStyles.font13DarkBlueMedium.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
  ],
);
