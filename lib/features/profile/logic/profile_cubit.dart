import 'package:doctor_booking_app/core/networking/api_result.dart';
import 'package:doctor_booking_app/features/profile/data/models/user_profile_model.dart';
import 'package:doctor_booking_app/features/profile/data/repos/profile_repo.dart';
import 'package:doctor_booking_app/features/profile/logic/profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepo _profileRepo;

  ProfileCubit(this._profileRepo) : super(const ProfileState());

  Future<void> getUserProfile() async {
    emit(state.copyWith(status: ProfileStatus.loading, errorMessage: null));

    final result = await _profileRepo.getUserProfile();

    result.when(
      success: (user) {
        emit(state.copyWith(
          status: ProfileStatus.success,
          user: user,
        ));
      },
      failure: (error) {
        emit(state.copyWith(
          status: ProfileStatus.error,
          errorMessage: error.apiErrorModel.message ?? 'Failed to load profile',
        ));
      },
    );
  }

  Future<void> updateUserProfile({
    required String name,
    required String email,
    required String phone,
    required dynamic gender,
  }) async {
    emit(state.copyWith(status: ProfileStatus.updating, errorMessage: null));

    final requestBody = UpdateProfileRequestBody(
      name: name,
      email: email,
      phone: phone,
      gender: gender,
    );

    final result = await _profileRepo.updateUserProfile(requestBody);

    result.when(
      success: (updatedUser) {
        emit(state.copyWith(
          status: ProfileStatus.updateSuccess,
          user: updatedUser,
          successMessage: 'Profile updated successfully',
        ));
      },
      failure: (error) {
        emit(state.copyWith(
          status: ProfileStatus.error,
          errorMessage: error.apiErrorModel.message ?? 'Failed to update profile',
        ));
      },
    );
  }

  Future<void> logout() async {
    emit(state.copyWith(status: ProfileStatus.loading));
    await _profileRepo.logout();
    emit(state.copyWith(status: ProfileStatus.loggedOut));
  }
}
