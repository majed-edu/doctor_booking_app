import 'package:doctor_booking_app/core/networking/api_error_handler.dart';
import 'package:doctor_booking_app/core/networking/api_result.dart';
import 'package:doctor_booking_app/features/appointments/data/apis/appointments_api_service.dart';
import 'package:doctor_booking_app/features/appointments/data/models/appointment_model.dart';

class AppointmentsRepo {
  final AppointmentsApiService _apiService;

  AppointmentsRepo(this._apiService);

  Future<ApiResult<List<AppointmentModel>>> getAppointments() async {
    try {
      final response = await _apiService.getAppointments();
      return ApiResult.success(response.data ?? []);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<AppointmentModel>> createAppointment(
    CreateAppointmentRequestBody body,
  ) async {
    try {
      final response = await _apiService.createAppointment(body);
      if (response.status == true && response.data != null) {
        return ApiResult.success(response.data!);
      }
      return ApiResult.failure(
        ErrorHandler.handle(response.message ?? 'Failed to book appointment'),
      );
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
