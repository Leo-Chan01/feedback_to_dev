import 'package:equatable/equatable.dart';

class ProjectEntity extends Equatable {
  const ProjectEntity({
    required this.id,
    required this.name,
    this.description,
    this.status = 'active',
    this.createdBy,
    this.createdAt,
  });

  final String id;
  final String name;
  final String? description;
  final String status;
  final String? createdBy;
  final DateTime? createdAt;

  @override
  List<Object?> get props => [
    id,
    name,
    description,
    status,
    createdBy,
    createdAt,
  ];
}
