import 'package:doctor_booking_app/core/helpers/spacing.dart';
import 'package:doctor_booking_app/core/theming/colors.dart';
import 'package:doctor_booking_app/features/appointments/data/models/appointment_model.dart';
import 'package:doctor_booking_app/features/appointments/logic/appointments_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'appointment_card.dart';

class AppointmentsList extends StatelessWidget {
  final List<AppointmentModel> appointments;
  final ValueChanged<AppointmentModel> onAppointmentTap;
  const AppointmentsList({
    super.key,
    required this.appointments,
    required this.onAppointmentTap,
  });
  @override
  Widget build(BuildContext context) => RefreshIndicator(
    onRefresh: () => context.read<AppointmentsCubit>().getAppointments(),
    color: ColorsManager.mainBlue,
    child: ListView.separated(
      padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 24.h),
      itemCount: appointments.length,
      separatorBuilder: (_, __) => verticalSpace(12),
      itemBuilder: (_, index) => AppointmentCard(
        appointment: appointments[index],
        onTap: () => onAppointmentTap(appointments[index]),
      ),
    ),
  );
}
