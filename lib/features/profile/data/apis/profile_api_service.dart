import 'package:dio/dio.dart';
import 'package:doctor_booking_app/core/networking/api_constants.dart';
import 'package:doctor_booking_app/features/profile/data/models/user_profile_model.dart';

class ProfileApiService {
  final Dio _dio;

  ProfileApiService(this._dio);

  Future<UserProfileResponseModel> getUserProfile() async {
    final response = await _dio.get('${ApiConstants.apiBaseUrl}${ApiConstants.userProfile}');
    return UserProfileResponseModel.fromJson(response.data);
  }

  Future<UserProfileResponseModel> updateUserProfile(UpdateProfileRequestBody body) async {
    final response = await _dio.post(
      '${ApiConstants.apiBaseUrl}${ApiConstants.userUpdate}',
      data: body.toJson(),
    );
    return UserProfileResponseModel.fromJson(response.data);
  }

  Future<void> logout() async {
    await _dio.post('${ApiConstants.apiBaseUrl}${ApiConstants.logout}');
  }
}
