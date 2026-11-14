import 'package:doctor_booking_app/features/home/data/models/specializations_response_model.dart';

int? _parseInt(dynamic value) {
  if (value is num) return value.toInt();
  return value is String ? int.tryParse(value.trim()) : null;
}

num? _parseNum(dynamic value) {
  if (value is num) return value;
  return value is String ? num.tryParse(value.trim()) : null;
}

class AppointmentModel {
  final int? id;
  final int? userId;
  final int? doctorId;
  final String? startTime;
  final String? notes;
  final String? status;
  final String? createdAt;
  final String? appointmentTime;
  final num? appointmentPrice;
  final Doctors? doctor;
  final PatientBrief? patient;

  AppointmentModel({
    this.id,
    this.userId,
    this.doctorId,
    this.startTime,
    this.notes,
    this.status,
    this.createdAt,
    this.appointmentTime,
    this.appointmentPrice,
    this.doctor,
    this.patient,
  });

  String get displayTime => appointmentTime ?? startTime ?? '';

  num get displayPrice => appointmentPrice ?? doctor?.price ?? 0;

  String get displayStatus => status?.isNotEmpty == true ? status! : 'pending';

  factory AppointmentModel.fromJson(Map<String, dynamic> json) {
    return AppointmentModel(
      id: _parseInt(json['id']),
      userId: _parseInt(json['user_id']),
      doctorId: _parseInt(json['doctor_id']),
      startTime: json['start_time'] as String?,
      notes: json['notes'] as String?,
      status: json['status'] as String?,
      createdAt: json['created_at'] as String?,
      appointmentTime: json['appointment_time'] as String?,
      appointmentPrice: _parseNum(json['appointment_price']),
      doctor: json['doctor'] is Map
          ? Doctors.fromJson(Map<String, dynamic>.from(json['doctor'] as Map))
          : null,
      patient: json['patient'] is Map
          ? PatientBrief.fromJson(
              Map<String, dynamic>.from(json['patient'] as Map),
            )
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'user_id': userId,
    'doctor_id': doctorId,
    'start_time': startTime,
    'notes': notes,
    'status': status,
    'created_at': createdAt,
    'appointment_time': appointmentTime,
    'appointment_price': appointmentPrice,
    'doctor': doctor?.toJson(),
    'patient': patient?.toJson(),
  };
}

class PatientBrief {
  final int? id;
  final String? name;

  PatientBrief({this.id, this.name});

  factory PatientBrief.fromJson(Map<String, dynamic> json) =>
      PatientBrief(id: _parseInt(json['id']), name: json['name'] as String?);

  Map<String, dynamic> toJson() => {'id': id, 'name': name};
}

class AppointmentsResponseModel {
  final String? message;
  final bool? status;
  final int? code;
  final List<AppointmentModel>? data;

  AppointmentsResponseModel({this.message, this.status, this.code, this.data});

  factory AppointmentsResponseModel.fromJson(Map<String, dynamic> json) {
    final rawData = json['data'];
    final data = rawData is Map
        ? (rawData['appointments'] ?? rawData['data'])
        : rawData;
    return AppointmentsResponseModel(
      message: json['message'] as String?,
      status: json['status'] as bool?,
      code: (json['code'] as num?)?.toInt(),
      data: data is List
          ? data
                .whereType<Map>()
                .map(
                  (e) =>
                      AppointmentModel.fromJson(Map<String, dynamic>.from(e)),
                )
                .toList()
          : const [],
    );
  }
}

class CreateAppointmentResponseModel {
  final String? message;
  final bool? status;
  final int? code;
  final AppointmentModel? data;

  CreateAppointmentResponseModel({
    this.message,
    this.status,
    this.code,
    this.data,
  });

  factory CreateAppointmentResponseModel.fromJson(Map<String, dynamic> json) {
    final rawData = json['data'];
    final appointmentData = rawData is Map && rawData['appointment'] is Map
        ? rawData['appointment']
        : rawData;
    return CreateAppointmentResponseModel(
      message: json['message'] as String?,
      status: json['status'] as bool?,
      code: (json['code'] as num?)?.toInt(),
      data: appointmentData is Map
          ? AppointmentModel.fromJson(
              Map<String, dynamic>.from(appointmentData),
            )
          : null,
    );
  }
}

class CreateAppointmentRequestBody {
  final int doctorId;
  final String startTime;
  final String? notes;

  CreateAppointmentRequestBody({
    required this.doctorId,
    required this.startTime,
    this.notes,
  });

  Map<String, dynamic> toJson() => {
    'doctor_id': doctorId,
    'start_time': startTime,
    if (notes != null && notes!.trim().isNotEmpty) 'notes': notes!.trim(),
  };
}
