import 'package:doctor_booking_app/features/doctors/data/models/doctor_models.dart';
import 'package:doctor_booking_app/features/home/data/models/specializations_response_model.dart';

enum DoctorsStatus { initial, loading, success, error }

class DoctorsState {
  final DoctorsStatus status;
  final List<Doctors> doctors;
  final List<SpecializationsData> specializations;
  final List<GovernorateModel> governorates;
  final List<CityModel> cities;
  final int? selectedSpecializationId;
  final int? selectedGovernorateId;
  final int? selectedCityId;
  final String searchQuery;
  final String? errorMessage;

  const DoctorsState({
    this.status = DoctorsStatus.initial,
    this.doctors = const [],
    this.specializations = const [],
    this.governorates = const [],
    this.cities = const [],
    this.selectedSpecializationId,
    this.selectedGovernorateId,
    this.selectedCityId,
    this.searchQuery = '',
    this.errorMessage,
  });

  bool get hasActiveFilters =>
      selectedSpecializationId != null ||
      selectedGovernorateId != null ||
      selectedCityId != null ||
      searchQuery.trim().isNotEmpty;

  List<CityModel> get availableCities {
    if (selectedGovernorateId == null) return cities;
    return cities
        .where((c) => c.governorateId == selectedGovernorateId)
        .toList();
  }

  DoctorsState copyWith({
    DoctorsStatus? status,
    List<Doctors>? doctors,
    List<SpecializationsData>? specializations,
    List<GovernorateModel>? governorates,
    List<CityModel>? cities,
    int? Function()? selectedSpecializationId,
    int? Function()? selectedGovernorateId,
    int? Function()? selectedCityId,
    String? searchQuery,
    String? errorMessage,
  }) {
    return DoctorsState(
      status: status ?? this.status,
      doctors: doctors ?? this.doctors,
      specializations: specializations ?? this.specializations,
      governorates: governorates ?? this.governorates,
      cities: cities ?? this.cities,
      selectedSpecializationId: selectedSpecializationId != null
          ? selectedSpecializationId()
          : this.selectedSpecializationId,
      selectedGovernorateId: selectedGovernorateId != null
          ? selectedGovernorateId()
          : this.selectedGovernorateId,
      selectedCityId:
          selectedCityId != null ? selectedCityId() : this.selectedCityId,
      searchQuery: searchQuery ?? this.searchQuery,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
