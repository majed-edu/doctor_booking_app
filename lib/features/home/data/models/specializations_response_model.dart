int? _parseInt(dynamic val) {
  if (val == null) return null;
  if (val is num) return val.toInt();
  if (val is String) return int.tryParse(val.trim());
  return null;
}

num? _parseNum(dynamic val) {
  if (val == null) return null;
  if (val is num) return val;
  if (val is String) return num.tryParse(val.trim());
  return null;
}

class SpecializationsResponseModel {
  final String? message;
  final bool? status;
  final int? code;
  final List<SpecializationsData>? specializationDataList;
  final List<Doctors>? doctorsList;

  SpecializationsResponseModel({
    this.message,
    this.status,
    this.code,
    this.specializationDataList,
    this.doctorsList,
  });

  factory SpecializationsResponseModel.fromJson(Map<String, dynamic> json) {
    final rawData = json['data'];
    final data = rawData is Map
        ? Map<String, dynamic>.from(rawData)
        : <String, dynamic>{};
    final rawSpecializations =
        (data['specializations'] ??
        data['specialization'] ??
        json['specializations'] ??
        json['specialization'] ??
        (rawData is List ? rawData : null));
    final rawDoctors = data['doctors'] ?? json['doctors'];

    final list = _parseSpecializations(rawSpecializations);
    final doctors = _parseDoctors(rawDoctors);
    final doctorsFromSpecializations = list
        .expand<Doctors>(
          (specialization) => specialization.doctorsList ?? const <Doctors>[],
        )
        .toList();
    final specializationsWithDoctors = list.isNotEmpty
        ? list
        : _parseSpecializations(json['data']);

    return SpecializationsResponseModel(
      message: json['message'] as String?,
      status: _parseBool(json['status']),
      code: _parseInt(json['code']),
      specializationDataList: specializationsWithDoctors,
      doctorsList: doctors.isNotEmpty ? doctors : doctorsFromSpecializations,
    );
  }

  static bool? _parseBool(dynamic value) {
    if (value is bool) return value;
    if (value is String) return value.toLowerCase() == 'true' || value == '1';
    if (value is num) return value != 0;
    return null;
  }

  static List<SpecializationsData> _parseSpecializations(dynamic value) {
    if (value is! List) return [];
    return value
        .whereType<Map>()
        .map(
          (item) =>
              SpecializationsData.fromJson(Map<String, dynamic>.from(item)),
        )
        .toList();
  }

  static List<Doctors> _parseDoctors(dynamic value) {
    if (value is! List) return [];
    return value
        .whereType<Map>()
        .map((item) => Doctors.fromJson(Map<String, dynamic>.from(item)))
        .toList();
  }

  Map<String, dynamic> toJson() => {
    'message': message,
    'status': status,
    'code': code,
    'data': specializationDataList?.map((e) => e.toJson()).toList(),
    'doctors': doctorsList?.map((e) => e.toJson()).toList(),
  };
}

class SpecializationsData {
  final int? id;
  final String? name;
  final String? nameAr;
  final String? image;
  final List<Doctors>? doctorsList;

  SpecializationsData({
    this.id,
    this.name,
    this.nameAr,
    this.image,
    this.doctorsList,
  });

  factory SpecializationsData.fromJson(Map<String, dynamic> json) {
    final rawDocs = json['doctors'] ?? json['doctors_list'] ?? json['data'];
    List<Doctors> docs = [];
    if (rawDocs is List) {
      for (final d in rawDocs) {
        if (d is Map<String, dynamic>) {
          docs.add(Doctors.fromJson(d));
        } else if (d is Map) {
          docs.add(Doctors.fromJson(Map<String, dynamic>.from(d)));
        }
      }
    }

    return SpecializationsData(
      id: _parseInt(json['id']),
      name: json['name']?.toString() ?? json['specialization']?.toString(),
      nameAr: json['name_ar']?.toString(),
      image:
          json['image']?.toString() ??
          json['photo']?.toString() ??
          json['icon']?.toString(),
      doctorsList: docs,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'name_ar': nameAr,
    'image': image,
    'doctors': doctorsList?.map((e) => e.toJson()).toList(),
  };
}

class Doctors {
  final int? id;
  final String? name;
  final String? email;
  final String? phone;
  final String? image;
  final String? photo;
  final dynamic gender;
  final int? price;
  final String? degree;
  final String? title;
  final String? about;
  final String? description;
  final String? address;
  final int? experience;
  final num? rating;
  final int? specializationId;
  final int? cityId;
  final int? governorateId;
  final String? startTime;
  final String? endTime;
  final SpecializationBrief? specialization;
  final CityBrief? city;

  Doctors({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.image,
    this.photo,
    this.gender,
    this.price,
    this.degree,
    this.title,
    this.about,
    this.description,
    this.address,
    this.experience,
    this.rating,
    this.specializationId,
    this.cityId,
    this.governorateId,
    this.startTime,
    this.endTime,
    this.specialization,
    this.city,
  });

  String get displayPhoto => photo?.isNotEmpty == true
      ? photo!
      : (image?.isNotEmpty == true ? image! : '');

  String get displayDegree => degree?.isNotEmpty == true
      ? degree!
      : (title?.isNotEmpty == true ? title! : 'Specialist');

  String get displayDescription => description?.isNotEmpty == true
      ? description!
      : (about?.isNotEmpty == true ? about! : '');

  int get displayPrice => price ?? 0;

  String get displayLocation {
    if (city != null) {
      final cityName = city!.name ?? '';
      final govName = city!.governrate?.name ?? '';
      if (cityName.isNotEmpty && govName.isNotEmpty) {
        return '$cityName, $govName';
      }
      return cityName.isNotEmpty ? cityName : govName;
    }
    return address ?? '';
  }

  factory Doctors.fromJson(Map<String, dynamic> json) {
    return Doctors(
      id: _parseInt(json['id']),
      name: json['name']?.toString(),
      email: json['email']?.toString(),
      phone: json['phone']?.toString(),
      image: json['image']?.toString(),
      photo: json['photo']?.toString() ?? json['image']?.toString(),
      gender: json['gender'],
      price: _parseInt(
        json['appoint_price'] ?? json['price'] ?? json['appointment_price'],
      ),
      degree:
          json['degree']?.toString() ??
          json['title']?.toString() ??
          'Specialist',
      title: json['title']?.toString() ?? json['degree']?.toString(),
      about: json['about']?.toString() ?? json['description']?.toString(),
      description: json['description']?.toString() ?? json['about']?.toString(),
      address: json['address']?.toString(),
      experience: _parseInt(json['experience']),
      rating: _parseNum(json['rating']),
      specializationId: _parseInt(json['specialization_id']),
      cityId: _parseInt(json['city_id']),
      governorateId: _parseInt(json['governorate_id']),
      startTime: json['start_time']?.toString(),
      endTime: json['end_time']?.toString(),
      specialization: json['specialization'] is Map
          ? SpecializationBrief.fromJson(
              Map<String, dynamic>.from(json['specialization'] as Map),
            )
          : null,
      city: json['city'] is Map
          ? CityBrief.fromJson(Map<String, dynamic>.from(json['city'] as Map))
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'email': email,
    'phone': phone,
    'image': image,
    'photo': photo,
    'gender': gender,
    'appoint_price': price,
    'degree': degree,
    'title': title,
    'about': about,
    'description': description,
    'address': address,
    'experience': experience,
    'rating': rating,
    'specialization_id': specializationId,
    'city_id': cityId,
    'governorate_id': governorateId,
    'start_time': startTime,
    'end_time': endTime,
    'specialization': specialization?.toJson(),
    'city': city?.toJson(),
  };
}

class SpecializationBrief {
  final int? id;
  final String? name;
  final String? nameAr;
  final String? image;

  SpecializationBrief({this.id, this.name, this.nameAr, this.image});

  factory SpecializationBrief.fromJson(Map<String, dynamic> json) =>
      SpecializationBrief(
        id: _parseInt(json['id']),
        name: json['name']?.toString(),
        nameAr: json['name_ar']?.toString(),
        image: json['image']?.toString(),
      );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'name_ar': nameAr,
    'image': image,
  };
}

class CityBrief {
  final int? id;
  final String? name;
  final int? governorateId;
  final GovernorateBrief? governrate;

  CityBrief({this.id, this.name, this.governorateId, this.governrate});

  factory CityBrief.fromJson(Map<String, dynamic> json) => CityBrief(
    id: _parseInt(json['id']),
    name: json['name']?.toString(),
    governorateId: _parseInt(json['governorate_id']),
    governrate: json['governrate'] is Map
        ? GovernorateBrief.fromJson(
            Map<String, dynamic>.from(json['governrate'] as Map),
          )
        : null,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'governorate_id': governorateId,
    'governrate': governrate?.toJson(),
  };
}

class GovernorateBrief {
  final int? id;
  final String? name;

  GovernorateBrief({this.id, this.name});

  factory GovernorateBrief.fromJson(Map<String, dynamic> json) =>
      GovernorateBrief(
        id: _parseInt(json['id']),
        name: json['name']?.toString(),
      );

  Map<String, dynamic> toJson() => {'id': id, 'name': name};
}
