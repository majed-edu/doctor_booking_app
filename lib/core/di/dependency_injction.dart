import 'package:dio/dio.dart';
import 'package:doctor_booking_app/core/networking/api_service.dart';
import 'package:doctor_booking_app/core/networking/dio_factory.dart';
import 'package:doctor_booking_app/features/appointments/data/apis/appointments_api_service.dart';
import 'package:doctor_booking_app/features/appointments/data/repos/appointments_repo.dart';
import 'package:doctor_booking_app/features/doctors/data/apis/doctors_api_service.dart';
import 'package:doctor_booking_app/features/doctors/data/repos/doctors_repo.dart';
import 'package:doctor_booking_app/features/home/data/apis/home_api_service.dart';
import 'package:doctor_booking_app/features/home/data/repos/home_repo.dart';
import 'package:doctor_booking_app/features/login/data/repos/login_repo.dart';
import 'package:doctor_booking_app/features/login/logic/cubit/login_cubit.dart';
import 'package:doctor_booking_app/features/profile/data/apis/profile_api_service.dart';
import 'package:doctor_booking_app/features/profile/data/repos/profile_repo.dart';
import 'package:doctor_booking_app/features/sign_up/data/repos/sign_up_repo.dart';
import 'package:doctor_booking_app/features/sign_up/logic/cubit/sign_up_cubit.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  // Dio & ApiService
  Dio dio = DioFactory.getDio();

  getIt.registerLazySingleton<ApiService>(() => ApiService(dio));

  // login
  getIt.registerLazySingleton<LoginRepo>(() => LoginRepo(getIt()));
  getIt.registerFactory<LoginCubit>(() => LoginCubit(getIt()));

  // sign up
  getIt.registerLazySingleton<SignupRepo>(() => SignupRepo(getIt()));
  getIt.registerFactory<SignupCubit>(() => SignupCubit(getIt()));

  // home
  getIt.registerLazySingleton<HomeApiService>(() => HomeApiService(dio));
  getIt.registerLazySingleton<HomeRepo>(() => HomeRepo(getIt()));

  // doctors
  getIt.registerLazySingleton<DoctorsApiService>(() => DoctorsApiService(dio));
  getIt.registerLazySingleton<DoctorsRepo>(() => DoctorsRepo(getIt()));

  // appointments
  getIt.registerLazySingleton<AppointmentsApiService>(
      () => AppointmentsApiService(dio));
  getIt.registerLazySingleton<AppointmentsRepo>(
      () => AppointmentsRepo(getIt()));

  // profile
  getIt.registerLazySingleton<ProfileApiService>(() => ProfileApiService(dio));
  getIt.registerLazySingleton<ProfileRepo>(() => ProfileRepo(getIt()));
}
