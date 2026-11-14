import 'package:doctor_booking_app/core/networking/api_error_handler.dart';
import 'package:doctor_booking_app/core/networking/api_result.dart';
import 'package:doctor_booking_app/features/doctors/data/apis/doctors_api_service.dart';
import 'package:doctor_booking_app/features/doctors/data/models/doctor_models.dart';
import 'package:doctor_booking_app/features/home/data/models/specializations_response_model.dart';

class DoctorsRepo {
  final DoctorsApiService _apiService;

  DoctorsRepo(this._apiService);

  Future<ApiResult<List<Doctors>>> getAllDoctors() async {
    try {
      final response = await _apiService.getAllDoctors();
      return ApiResult.success(response.data ?? []);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<List<Doctors>>> searchDoctors(String name) async {
    try {
      final response = await _apiService.searchDoctors(name);
      return ApiResult.success(response.data ?? []);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<List<Doctors>>> filterDoctors({
    int? specialization,
    int? governrate,
    int? city,
  }) async {
    try {
      final response = await _apiService.filterDoctors(
        specialization: specialization,
        governrate: governrate,
        city: city,
      );
      return ApiResult.success(response.data ?? []);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<Doctors>> getDoctorDetails(int doctorId) async {
    try {
      final response = await _apiService.getDoctorDetails(doctorId);
      if (response.data != null) {
        return ApiResult.success(response.data!);
      }
      return ApiResult.failure(ErrorHandler.handle('Doctor details not found'));
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<List<GovernorateModel>>> getGovernorates() async {
    try {
      final response = await _apiService.getGovernorates();
      return ApiResult.success(response.data ?? []);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<List<CityModel>>> getCities() async {
    try {
      final response = await _apiService.getCities();
      return ApiResult.success(response.data ?? []);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<List<SpecializationsData>>> getSpecializations() async {
    try {
      final response = await _apiService.getSpecializations();
      return ApiResult.success(response.specializationDataList ?? []);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
