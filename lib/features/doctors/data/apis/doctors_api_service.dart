import 'package:dio/dio.dart';
import 'package:doctor_booking_app/core/networking/api_constants.dart';
import 'package:doctor_booking_app/features/doctors/data/models/doctor_models.dart';
import 'package:doctor_booking_app/features/home/data/models/specializations_response_model.dart';

class DoctorsApiService {
  final Dio _dio;

  DoctorsApiService(this._dio);

  Future<DoctorsResponseModel> getAllDoctors() async {
    final response = await _dio.get('${ApiConstants.apiBaseUrl}${ApiConstants.doctors}');
    return DoctorsResponseModel.fromJson(response.data);
  }

  Future<DoctorsResponseModel> searchDoctors(String name) async {
    final response = await _dio.get(
      '${ApiConstants.apiBaseUrl}${ApiConstants.doctorSearch}',
      queryParameters: {'name': name},
    );
    return DoctorsResponseModel.fromJson(response.data);
  }

  Future<DoctorsResponseModel> filterDoctors({
    int? specialization,
    int? governrate,
    int? city,
  }) async {
    final queryParams = <String, dynamic>{};
    if (specialization != null) queryParams['specialization'] = specialization;
    if (governrate != null) queryParams['governrate'] = governrate;
    if (city != null) queryParams['city'] = city;

    final response = await _dio.get(
      '${ApiConstants.apiBaseUrl}${ApiConstants.doctorFilter}',
      queryParameters: queryParams,
    );
    return DoctorsResponseModel.fromJson(response.data);
  }

  Future<DoctorDetailsResponseModel> getDoctorDetails(int doctorId) async {
    final response = await _dio.get('${ApiConstants.apiBaseUrl}doctor/show/$doctorId');
    return DoctorDetailsResponseModel.fromJson(response.data);
  }

  Future<GovernoratesResponseModel> getGovernorates() async {
    final response = await _dio.get('${ApiConstants.apiBaseUrl}${ApiConstants.governrates}');
    return GovernoratesResponseModel.fromJson(response.data);
  }

  Future<CitiesResponseModel> getCities() async {
    final response = await _dio.get('${ApiConstants.apiBaseUrl}${ApiConstants.cities}');
    return CitiesResponseModel.fromJson(response.data);
  }

  Future<SpecializationsResponseModel> getSpecializations() async {
    final response = await _dio.get('${ApiConstants.apiBaseUrl}${ApiConstants.specializations}');
    return SpecializationsResponseModel.fromJson(response.data);
  }
}
