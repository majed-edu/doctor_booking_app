import 'package:doctor_booking_app/core/theming/text_styles.dart';
import 'package:doctor_booking_app/features/appointments/logic/appointments_cubit.dart';
import 'package:doctor_booking_app/features/appointments/logic/appointments_state.dart';
import 'package:doctor_booking_app/features/main_layout/logic/main_layout_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'appointment_details_sheet.dart';
import 'appointments_empty_state.dart';
import 'appointments_error_state.dart';
import 'appointments_list.dart';
import 'appointments_loading.dart';

class AppointmentsContent extends StatefulWidget {
  const AppointmentsContent({super.key});
  @override
  State<AppointmentsContent> createState() => _AppointmentsContentState();
}

class _AppointmentsContentState extends State<AppointmentsContent> {
  @override
  void initState() {
    super.initState();
    context.read<AppointmentsCubit>().getAppointments();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.white,
    appBar: AppBar(
      title: Text('My Appointments', style: TextStyles.font18DarkBlueBold),
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: false,
    ),
    body: SafeArea(
      child: BlocBuilder<AppointmentsCubit, AppointmentsState>(
        builder: (context, state) {
          switch (state.status) {
            case AppointmentsStatus.loading:
            case AppointmentsStatus.initial:
              return const AppointmentsLoading();
            case AppointmentsStatus.error:
              return AppointmentsErrorState(error: state.errorMessage);
            case AppointmentsStatus.success:
              return state.appointments.isEmpty
                  ? AppointmentsEmptyState(
                      onFindDoctor: () =>
                          context.read<MainLayoutCubit>().changeTab(1),
                    )
                  : AppointmentsList(
                      appointments: state.appointments,
                      onAppointmentTap: (appointment) =>
                          showAppointmentDetails(context, appointment),
                    );
          }
        },
      ),
    ),
  );
}
