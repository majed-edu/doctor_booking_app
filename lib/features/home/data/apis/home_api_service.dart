
import 'package:dio/dio.dart';
import 'package:doctor_booking_app/core/networking/api_constants.dart';
import 'package:doctor_booking_app/features/home/data/apis/home_api_constants.dart';
import 'package:doctor_booking_app/features/home/data/models/specializations_response_model.dart';
import 'package:retrofit/retrofit.dart';

part 'home_api_service.g.dart';

@RestApi(baseUrl: ApiConstants.apiBaseUrl)

abstract class HomeApiService {
  factory HomeApiService(Dio dio) = _HomeApiService;

  @GET(HomeApiConstants.specializationsEP)
  Future<SpecializationsResponseModel> getSpecialization();
}



// dart run build_runner build --delete-conflicting-outputs