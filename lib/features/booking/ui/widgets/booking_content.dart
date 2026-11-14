import 'package:doctor_booking_app/core/helpers/spacing.dart';
import 'package:doctor_booking_app/core/theming/colors.dart';
import 'package:doctor_booking_app/core/theming/text_styles.dart';
import 'package:doctor_booking_app/features/appointments/logic/appointments_cubit.dart';
import 'package:doctor_booking_app/features/booking/logic/booking_cubit.dart';
import 'package:doctor_booking_app/features/booking/logic/booking_state.dart';
import 'package:doctor_booking_app/features/home/data/models/specializations_response_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'booking_doctor_brief.dart';
import 'booking_date_selector.dart';
import 'booking_time_slots.dart';
import 'booking_summary.dart';
import 'booking_success_dialog.dart';

class BookingContent extends StatelessWidget {
  final Doctors doctor;
  const BookingContent({super.key, required this.doctor});
  @override
  Widget build(
    BuildContext context,
  ) => BlocConsumer<BookingCubit, BookingState>(
    listener: (context, state) {
      if (state.status == BookingStatus.success) {
        context.read<AppointmentsCubit>().getAppointments();
        showBookingSuccessDialog(context, doctor, state);
      } else if (state.status == BookingStatus.error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(state.errorMessage ?? 'Failed to book appointment'),
            backgroundColor: ColorsManager.red,
          ),
        );
      }
    },
    builder: (context, state) {
      final cubit = context.read<BookingCubit>();
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: ColorsManager.darkBlue,
              size: 20,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text('Book Appointment', style: TextStyles.font18DarkBlueBold),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 12.h,
                  ),
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BookingDoctorBrief(doctor: doctor),
                      verticalSpace(20),
                      Text(
                        'Select Date',
                        style: TextStyles.font18DarkBlueSemiBold,
                      ),
                      verticalSpace(12),
                      BookingDateSelector(state: state),
                      verticalSpace(20),
                      Text(
                        'Select Consultation Time',
                        style: TextStyles.font18DarkBlueSemiBold,
                      ),
                      verticalSpace(12),
                      BookingTimeSlots(state: state),
                      verticalSpace(20),
                      Text(
                        'Additional Notes (Optional)',
                        style: TextStyles.font18DarkBlueSemiBold,
                      ),
                      verticalSpace(10),
                      TextField(
                        controller: cubit.notesController,
                        maxLines: 3,
                        decoration: InputDecoration(
                          hintText:
                              'Enter reason for visit, symptoms, or any note...',
                          hintStyle: TextStyles.font12GrayRegular,
                          filled: true,
                          fillColor: ColorsManager.moreLighterGray,
                          contentPadding: EdgeInsets.all(12.w),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: ColorsManager.lighterGray,
                            ),
                          ),
                        ),
                        style: TextStyles.font14DarkBlueMedium,
                      ),
                      verticalSpace(20),
                      BookingSummary(doctor: doctor, state: state),
                      verticalSpace(20),
                    ],
                  ),
                ),
              ),
              SafeArea(
                top: false,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 14.h,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        offset: const Offset(0, -3),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    height: 52.h,
                    child: ElevatedButton(
                      onPressed: state.isLoading || doctor.id == null
                          ? null
                          : () => cubit.bookAppointment(doctor.id!),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorsManager.mainBlue,
                        disabledBackgroundColor: ColorsManager.lightGray,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: state.isLoading
                          ? const SizedBox(
                              width: 22,
                              height: 22,
                              child: CircularProgressIndicator(
                                strokeWidth: 2.5,
                                color: Colors.white,
                              ),
                            )
                          : Text(
                              'Confirm Booking',
                              style: TextStyles.font16WhiteSemiBold,
                            ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
