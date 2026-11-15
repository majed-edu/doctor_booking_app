import 'package:doctor_booking_app/core/helpers/constants.dart';
import 'package:doctor_booking_app/core/helpers/shared_pref_helper.dart';
import 'package:doctor_booking_app/core/networking/api_error_handler.dart';
import 'package:doctor_booking_app/core/networking/api_result.dart';
import 'package:doctor_booking_app/core/networking/dio_factory.dart';
import 'package:doctor_booking_app/features/profile/data/apis/profile_api_service.dart';
import 'package:doctor_booking_app/features/profile/data/models/user_profile_model.dart';

class ProfileRepo {
  final ProfileApiService _apiService;

  ProfileRepo(this._apiService);

  Future<ApiResult<UserModel>> getUserProfile() async {
    try {
      final response = await _apiService.getUserProfile();
      if (response.data != null) {
        if (response.data!.name?.trim().isNotEmpty == true) {
          await SharedPrefHelper.setData(
            SharedPrefKeys.userName,
            response.data!.name!.trim(),
          );
        }
        return ApiResult.success(response.data!);
      }
      return ApiResult.failure(ErrorHandler.handle('User profile not found'));
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<UserModel>> updateUserProfile(
    UpdateProfileRequestBody body,
  ) async {
    try {
      final response = await _apiService.updateUserProfile(body);
      if (response.data != null) {
        // Also update stored user name
        if (response.data!.name != null) {
          await SharedPrefHelper.setData(
            SharedPrefKeys.userName,
            response.data!.name!,
          );
        }
        return ApiResult.success(response.data!);
      }
      return ApiResult.failure(ErrorHandler.handle('Failed to update profile'));
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<void>> logout() async {
    try {
      try {
        await _apiService.logout();
      } catch (_) {
        // even if backend logout fails, clear local credentials
      }
      await DioFactory.clearToken();
      await SharedPrefHelper.removeData(SharedPrefKeys.userName);
      return const ApiResult.success(null);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
