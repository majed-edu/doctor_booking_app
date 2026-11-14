import 'dart:async';
import 'package:doctor_booking_app/core/networking/api_result.dart';
import 'package:doctor_booking_app/features/doctors/data/repos/doctors_repo.dart';
import 'package:doctor_booking_app/features/doctors/logic/doctors_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoctorsCubit extends Cubit<DoctorsState> {
  final DoctorsRepo _doctorsRepo;
  Timer? _debounceTimer;

  final TextEditingController searchController = TextEditingController();

  DoctorsCubit(this._doctorsRepo) : super(const DoctorsState());

  void init() async {
    await fetchFilterMetadata();
    await fetchDoctors();
  }

  Future<void> fetchFilterMetadata() async {
    final specsResult = await _doctorsRepo.getSpecializations();
    final govsResult = await _doctorsRepo.getGovernorates();
    final citiesResult = await _doctorsRepo.getCities();

    emit(
      state.copyWith(
        specializations: specsResult.when(
          success: (data) => data,
          failure: (_) => state.specializations,
        ),
        governorates: govsResult.when(
          success: (data) => data,
          failure: (_) => state.governorates,
        ),
        cities: citiesResult.when(
          success: (data) => data,
          failure: (_) => state.cities,
        ),
      ),
    );
  }

  Future<void> fetchDoctors() async {
    emit(state.copyWith(status: DoctorsStatus.loading, errorMessage: null));

    // If active filters (specialization, governrate, city)
    if (state.selectedSpecializationId != null ||
        state.selectedGovernorateId != null ||
        state.selectedCityId != null) {
      final result = await _doctorsRepo.filterDoctors(
        specialization: state.selectedSpecializationId,
        governrate: state.selectedGovernorateId,
        city: state.selectedCityId,
      );

      result.when(
        success: (doctors) {
          // If search query is also active, filter by name locally
          var filtered = doctors;
          if (state.searchQuery.trim().isNotEmpty) {
            filtered = doctors
                .where((d) => (d.name ?? '')
                    .toLowerCase()
                    .contains(state.searchQuery.toLowerCase().trim()))
                .toList();
          }
          emit(state.copyWith(
            status: DoctorsStatus.success,
            doctors: filtered,
          ));
        },
        failure: (error) {
          emit(state.copyWith(
            status: DoctorsStatus.error,
            errorMessage: error.apiErrorModel.message ?? 'Failed to load doctors',
          ));
        },
      );
      return;
    }

    // If only search query is active
    if (state.searchQuery.trim().isNotEmpty) {
      final result = await _doctorsRepo.searchDoctors(state.searchQuery.trim());
      result.when(
        success: (doctors) {
          emit(state.copyWith(
            status: DoctorsStatus.success,
            doctors: doctors,
          ));
        },
        failure: (error) {
          emit(state.copyWith(
            status: DoctorsStatus.error,
            errorMessage: error.apiErrorModel.message ?? 'Failed to search doctors',
          ));
        },
      );
      return;
    }

    // Otherwise, fetch all doctors
    final result = await _doctorsRepo.getAllDoctors();
    result.when(
      success: (doctors) {
        emit(state.copyWith(
          status: DoctorsStatus.success,
          doctors: doctors,
        ));
      },
      failure: (error) {
        emit(state.copyWith(
          status: DoctorsStatus.error,
          errorMessage: error.apiErrorModel.message ?? 'Failed to load doctors',
        ));
      },
    );
  }

  void onSearchChanged(String query) {
    emit(state.copyWith(searchQuery: query));
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 400), () {
      fetchDoctors();
    });
  }

  void onSpecializationSelected(int? specializationId) {
    if (state.selectedSpecializationId == specializationId) {
      emit(state.copyWith(selectedSpecializationId: () => null));
    } else {
      emit(state.copyWith(selectedSpecializationId: () => specializationId));
    }
    fetchDoctors();
  }

  void onGovernorateSelected(int? governorateId) {
    emit(state.copyWith(
      selectedGovernorateId: () => governorateId,
      selectedCityId: () => null,
    ));
    fetchDoctors();
  }

  void onCitySelected(int? cityId) {
    emit(state.copyWith(selectedCityId: () => cityId));
    fetchDoctors();
  }

  void clearAllFilters() {
    searchController.clear();
    emit(state.copyWith(
      selectedSpecializationId: () => null,
      selectedGovernorateId: () => null,
      selectedCityId: () => null,
      searchQuery: '',
    ));
    fetchDoctors();
  }

  @override
  Future<void> close() {
    _debounceTimer?.cancel();
    searchController.dispose();
    return super.close();
  }
}
