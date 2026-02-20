import 'package:feedback_to_vfd/features/users/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.accessId,
    required super.name,
    required super.email,
    required super.role,
    required super.isActive,
    required super.accessToken,
    required super.refreshToken,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String?,
      accessId: json['access_id'] as String?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      role: json['role'] as String?,
      isActive: json['is_active'] as bool?,
      accessToken: json['access_token'] as String?,
      refreshToken: json['refresh_token'] as String?,
    );
  }

  @override
  UserModel copyWith({
    String? id,
    String? accessId,
    String? name,
    String? email,
    String? role,
    bool? isActive,
    String? accessToken,
    String? refreshToken,
  }) {
    return UserModel(
      id: id ?? this.id,
      accessId: accessId ?? this.accessId,
      name: name ?? this.name,
      email: email ?? this.email,
      role: role ?? this.role,
      isActive: isActive ?? this.isActive,
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'access_id': accessId,
      'name': name,
      'email': email,
      'role': role,
      'is_active': isActive,
      'access_token': accessToken,
      'refresh_token': refreshToken,
    };
  }
}
