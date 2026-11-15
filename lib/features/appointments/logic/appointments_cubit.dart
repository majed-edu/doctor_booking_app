import 'package:doctor_booking_app/core/networking/api_result.dart';
import 'package:doctor_booking_app/features/appointments/data/repos/appointments_repo.dart';
import 'package:doctor_booking_app/features/appointments/logic/appointments_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppointmentsCubit extends Cubit<AppointmentsState> {
  final AppointmentsRepo _appointmentsRepo;

  AppointmentsCubit(this._appointmentsRepo) : super(const AppointmentsState());

  Future<void> getAppointments() async {
    emit(state.copyWith(status: AppointmentsStatus.loading, errorMessage: null));

    final result = await _appointmentsRepo.getAppointments();

    result.when(
      success: (appointments) {
        emit(state.copyWith(
          status: AppointmentsStatus.success,
          appointments: appointments,
        ));
      },
      failure: (error) {
        emit(state.copyWith(
          status: AppointmentsStatus.error,
          errorMessage: error.apiErrorModel.message ?? 'Failed to load appointments',
        ));
      },
    );
  }
}
