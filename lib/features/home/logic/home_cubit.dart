import 'package:doctor_booking_app/core/networking/api_error_handler.dart';
import 'package:doctor_booking_app/core/networking/api_result.dart';
import 'package:doctor_booking_app/features/home/data/models/specializations_response_model.dart';
import 'package:doctor_booking_app/features/home/data/repos/home_repo.dart';
import 'package:doctor_booking_app/features/home/logic/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepo _homeRepo;
  HomeCubit(this._homeRepo) : super(const HomeState.initial());

  List<SpecializationsData> specializationsList = [];
  List<Doctors> allDoctorsList = [];

  Future<void> getSpecializations() async {
    emit(const HomeState.specializationsLoading());
    final response = await _homeRepo.getSpecialization();
    response.when(
      success: (specializationsResponseModel) {
        // emit(HomeState.specializationsSuccess(specializationsResponseModel));
        specializationsList =
            (specializationsResponseModel.specializationDataList ??
                    const <SpecializationsData>[])
                .whereType<SpecializationsData>()
                .toList();
        allDoctorsList = specializationsResponseModel.doctorsList ?? [];

        emit(HomeState.specializationsSuccess(specializationsList));
        getDoctorsList(
          specializationId: specializationsList.isNotEmpty
              ? specializationsList.first.id
              : null,
        );
      },
      failure: (errorHandler) {
        emit(HomeState.specializationsError(errorHandler));
      },
    );
  }

  void getDoctorsList({required int? specializationId}) {
    List<Doctors?>? doctorsList = getDoctorsListBySpecializationId(
      specializationId,
    );

    // if (!doctorsList.isNullOrEmpty()) {
    if (doctorsList != null && doctorsList.isNotEmpty) {
      emit(HomeState.doctorsSuccess(doctorsList));
    } else {
      emit(HomeState.doctorsError(ErrorHandler.handle('No doctors found')));
    }
  }

  /// returns the list of doctors based on the specialization id
  List<Doctors?>? getDoctorsListBySpecializationId(int? specializationId) {
    if (specializationId == null) {
      return allDoctorsList;
    }

    SpecializationsData? specialization;
    for (final item in specializationsList) {
      if (item.id == specializationId) {
        specialization = item;
        break;
      }
    }
    if (specialization == null) {
      return const [];
    }

    final doctorsInSpecialization = specialization.doctorsList ?? const [];
    if (doctorsInSpecialization.isNotEmpty) {
      return doctorsInSpecialization;
    }

    return allDoctorsList
        .where(
          (doctor) =>
              doctor.specializationId == specializationId ||
              doctor.specialization?.id == specializationId,
        )
        .toList();
  }
}
