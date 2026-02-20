import 'package:equatable/equatable.dart';

class ProjectMemberEntity extends Equatable {
  const ProjectMemberEntity({
    required this.id,
    required this.projectId,
    required this.userId,
    this.role = 'member',
    this.joinedAt,
    this.userName,
    this.userEmail,
  });

  final String id;
  final String projectId;
  final String userId;
  final String role;
  final DateTime? joinedAt;

  final String? userName;
  final String? userEmail;

  @override
  List<Object?> get props => [
    id,
    projectId,
    userId,
    role,
    joinedAt,
    userName,
    userEmail,
  ];
}
