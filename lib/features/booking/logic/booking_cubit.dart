import 'package:doctor_booking_app/core/networking/api_result.dart';
import 'package:doctor_booking_app/features/appointments/data/models/appointment_model.dart';
import 'package:doctor_booking_app/features/appointments/data/repos/appointments_repo.dart';
import 'package:doctor_booking_app/features/booking/logic/booking_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookingCubit extends Cubit<BookingState> {
  final AppointmentsRepo _appointmentsRepo;
  final TextEditingController notesController = TextEditingController();

  BookingCubit(this._appointmentsRepo) : super(BookingState());

  void selectDate(DateTime date) {
    emit(state.copyWith(selectedDate: date));
  }

  void selectTimeSlot(String slot) {
    emit(state.copyWith(selectedTimeSlot: slot));
  }

  Future<void> bookAppointment(int doctorId) async {
    if (state.isLoading) return;

    emit(state.copyWith(status: BookingStatus.loading, errorMessage: null));

    final requestBody = CreateAppointmentRequestBody(
      doctorId: doctorId,
      startTime: state.formattedStartTime,
      notes: notesController.text.trim().isNotEmpty ? notesController.text.trim() : null,
    );

    final result = await _appointmentsRepo.createAppointment(requestBody);

    result.when(
      success: (appointment) {
        emit(state.copyWith(
          status: BookingStatus.success,
          createdAppointment: appointment,
        ));
      },
      failure: (error) {
        emit(state.copyWith(
          status: BookingStatus.error,
          errorMessage: error.apiErrorModel.message ?? 'Failed to book appointment',
        ));
      },
    );
  }

  @override
  Future<void> close() {
    notesController.dispose();
    return super.close();
  }
}
