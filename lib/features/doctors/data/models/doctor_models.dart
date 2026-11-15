import 'package:doctor_booking_app/features/home/data/models/specializations_response_model.dart';

class GovernorateModel {
  final int? id;
  final String? name;

  GovernorateModel({this.id, this.name});

  factory GovernorateModel.fromJson(Map<String, dynamic> json) =>
      GovernorateModel(
        id: (json['id'] as num?)?.toInt(),
        name: json['name'] as String?,
      );

  Map<String, dynamic> toJson() => {'id': id, 'name': name};
}

class CityModel {
  final int? id;
  final String? name;
  final int? governorateId;
  final GovernorateModel? governrate;

  CityModel({this.id, this.name, this.governorateId, this.governrate});

  factory CityModel.fromJson(Map<String, dynamic> json) => CityModel(
        id: (json['id'] as num?)?.toInt(),
        name: json['name'] as String?,
        governorateId: (json['governorate_id'] as num?)?.toInt(),
        governrate: json['governrate'] is Map<String, dynamic>
            ? GovernorateModel.fromJson(
                json['governrate'] as Map<String, dynamic>)
            : null,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'governorate_id': governorateId,
        'governrate': governrate?.toJson(),
      };
}

class DoctorsResponseModel {
  final String? message;
  final bool? status;
  final int? code;
  final List<Doctors>? data;

  DoctorsResponseModel({this.message, this.status, this.code, this.data});

  factory DoctorsResponseModel.fromJson(Map<String, dynamic> json) {
    return DoctorsResponseModel(
      message: json['message'] as String?,
      status: json['status'] as bool?,
      code: (json['code'] as num?)?.toInt(),
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Doctors.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class DoctorDetailsResponseModel {
  final String? message;
  final bool? status;
  final int? code;
  final Doctors? data;

  DoctorDetailsResponseModel({this.message, this.status, this.code, this.data});

  factory DoctorDetailsResponseModel.fromJson(Map<String, dynamic> json) {
    return DoctorDetailsResponseModel(
      message: json['message'] as String?,
      status: json['status'] as bool?,
      code: (json['code'] as num?)?.toInt(),
      data: json['data'] is Map<String, dynamic>
          ? Doctors.fromJson(json['data'] as Map<String, dynamic>)
          : null,
    );
  }
}

class GovernoratesResponseModel {
  final String? message;
  final bool? status;
  final int? code;
  final List<GovernorateModel>? data;

  GovernoratesResponseModel({this.message, this.status, this.code, this.data});

  factory GovernoratesResponseModel.fromJson(Map<String, dynamic> json) {
    return GovernoratesResponseModel(
      message: json['message'] as String?,
      status: json['status'] as bool?,
      code: (json['code'] as num?)?.toInt(),
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => GovernorateModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class CitiesResponseModel {
  final String? message;
  final bool? status;
  final int? code;
  final List<CityModel>? data;

  CitiesResponseModel({this.message, this.status, this.code, this.data});

  factory CitiesResponseModel.fromJson(Map<String, dynamic> json) {
    return CitiesResponseModel(
      message: json['message'] as String?,
      status: json['status'] as bool?,
      code: (json['code'] as num?)?.toInt(),
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => CityModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
