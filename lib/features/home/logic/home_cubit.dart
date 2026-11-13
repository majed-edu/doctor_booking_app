import 'package:doctor_booking_app/core/networking/api_result.dart';
import 'package:doctor_booking_app/features/home/data/repos/home_repo.dart';
import 'package:doctor_booking_app/features/home/logic/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class HomeCubit extends Cubit<HomeState> {
  final HomeRepo _homeRepo;
  HomeCubit(this._homeRepo) : super(const HomeState.initial());

  void getSpecializations() async {
    emit(const HomeState.specializationsLoading());
    final response = await _homeRepo.getSpecialization();
    response.when(
      success: (specializationsResponseModel) {
        emit(HomeState.specializationsSuccess(specializationsResponseModel));
      },
      failure: (errorHandler) {
        emit(HomeState.specializationsError(errorHandler));
      },
    );
  }
}