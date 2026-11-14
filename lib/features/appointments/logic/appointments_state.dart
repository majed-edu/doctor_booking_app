import 'package:doctor_booking_app/features/appointments/data/models/appointment_model.dart';

enum AppointmentsStatus { initial, loading, success, error }

class AppointmentsState {
  final AppointmentsStatus status;
  final List<AppointmentModel> appointments;
  final String? errorMessage;

  const AppointmentsState({
    this.status = AppointmentsStatus.initial,
    this.appointments = const [],
    this.errorMessage,
  });

  AppointmentsState copyWith({
    AppointmentsStatus? status,
    List<AppointmentModel>? appointments,
    String? errorMessage,
  }) {
    return AppointmentsState(
      status: status ?? this.status,
      appointments: appointments ?? this.appointments,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
