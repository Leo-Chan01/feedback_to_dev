import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  const UserEntity({
    required this.id,
    required this.accessId,
    required this.name,
    required this.email,
    required this.role,
    required this.isActive,
    required this.accessToken,
    required this.refreshToken,
  });

  final String? id;
  final String? accessId;
  final String? name;
  final String? email;
  final String? role;
  final bool? isActive;
  final String? accessToken;
  final String? refreshToken;

  UserEntity copyWith({
    String? id,
    String? accessId,
    String? name,
    String? email,
    String? role,
    bool? isActive,
    String? accessToken,
    String? refreshToken,
  }) {
    return UserEntity(
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

  @override
  List<Object?> get props => [
    id,
    accessId,
    name,
    email,
    role,
    isActive,
  ];
}
