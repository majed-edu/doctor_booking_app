class UserModel {
  final int? id;
  final String? name;
  final String? email;
  final String? phone;
  final dynamic gender;
  final String? type;
  final String? createdAt;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.gender,
    this.type,
    this.createdAt,
  });

  String get displayGender {
    final g = gender?.toString();
    if (g == '0') return 'Male';
    if (g == '1') return 'Female';
    return 'Not Specified';
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      email: json['email'] as String?,
      phone: json['phone']?.toString(),
      gender: json['gender'],
      type: json['type'] as String?,
      createdAt: json['created_at'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'phone': phone,
        'gender': gender,
        'type': type,
        'created_at': createdAt,
      };
}

class UserProfileResponseModel {
  final String? message;
  final bool? status;
  final int? code;
  final UserModel? data;

  UserProfileResponseModel({
    this.message,
    this.status,
    this.code,
    this.data,
  });

  factory UserProfileResponseModel.fromJson(Map<String, dynamic> json) {
    return UserProfileResponseModel(
      message: json['message'] as String?,
      status: json['status'] as bool?,
      code: (json['code'] as num?)?.toInt(),
      data: json['data'] is Map<String, dynamic>
          ? UserModel.fromJson(json['data'] as Map<String, dynamic>)
          : null,
    );
  }
}

class UpdateProfileRequestBody {
  final String name;
  final String email;
  final String phone;
  final dynamic gender;

  UpdateProfileRequestBody({
    required this.name,
    required this.email,
    required this.phone,
    required this.gender,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'phone': phone,
        'gender': gender,
      };
}
