import 'package:dartz/dartz.dart';
import 'package:feedback_to_vfd/core/utils/failures.dart';
import 'package:feedback_to_vfd/features/projects/domain/entities/project_entity.dart';
import 'package:feedback_to_vfd/features/projects/domain/entities/project_member_entity.dart';
import 'package:feedback_to_vfd/features/users/domain/entities/user_entity.dart';

abstract class ProjectsRepository {
  Future<Either<Failure, List<ProjectEntity>>> getProjects();
  Future<Either<Failure, ProjectEntity>> createProject(
    String name,
    String? description,
  );
  Future<Either<Failure, Unit>> assignMember(
    String projectId,
    String userId,
    String role,
  );
  Future<Either<Failure, List<ProjectMemberEntity>>> getProjectMembers(
    String projectId,
  );
  Future<Either<Failure, List<UserEntity>>> getClients();
}
