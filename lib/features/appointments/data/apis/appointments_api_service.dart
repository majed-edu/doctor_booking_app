import 'package:dio/dio.dart';
import 'package:doctor_booking_app/core/networking/api_constants.dart';
import 'package:doctor_booking_app/features/appointments/data/models/appointment_model.dart';

class AppointmentsApiService {
  final Dio _dio;

  AppointmentsApiService(this._dio);

  Future<AppointmentsResponseModel> getAppointments() async {
    final response = await _dio.get('${ApiConstants.apiBaseUrl}${ApiConstants.appointments}');
    return AppointmentsResponseModel.fromJson(response.data);
  }

  Future<CreateAppointmentResponseModel> createAppointment(
    CreateAppointmentRequestBody body,
  ) async {
    final response = await _dio.post(
      '${ApiConstants.apiBaseUrl}${ApiConstants.storeAppointment}',
      data: body.toJson(),
    );
    return CreateAppointmentResponseModel.fromJson(response.data);
  }
}
