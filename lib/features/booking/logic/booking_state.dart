import 'package:doctor_booking_app/features/appointments/data/models/appointment_model.dart';

enum BookingStatus { initial, loading, success, error }

class BookingState {
  final BookingStatus status;
  final DateTime selectedDate;
  final String selectedTimeSlot;
  final String notes;
  final AppointmentModel? createdAppointment;
  final String? errorMessage;

  BookingState({
    this.status = BookingStatus.initial,
    DateTime? selectedDate,
    this.selectedTimeSlot = '09:00:00',
    this.notes = '',
    this.createdAppointment,
    this.errorMessage,
  }) : selectedDate =
           selectedDate ?? DateTime.now().add(const Duration(days: 1));

  bool get isLoading => status == BookingStatus.loading;

  String get formattedStartTime {
    final y = selectedDate.year.toString().padLeft(4, '0');
    final m = selectedDate.month.toString().padLeft(2, '0');
    final d = selectedDate.day.toString().padLeft(2, '0');
    final time = selectedTimeSlot.length >= 5
        ? selectedTimeSlot.substring(0, 5)
        : selectedTimeSlot;
    return '$y-$m-$d $time';
  }

  BookingState copyWith({
    BookingStatus? status,
    DateTime? selectedDate,
    String? selectedTimeSlot,
    String? notes,
    AppointmentModel? createdAppointment,
    String? errorMessage,
  }) {
    return BookingState(
      status: status ?? this.status,
      selectedDate: selectedDate ?? this.selectedDate,
      selectedTimeSlot: selectedTimeSlot ?? this.selectedTimeSlot,
      notes: notes ?? this.notes,
      createdAppointment: createdAppointment ?? this.createdAppointment,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
