import 'package:dartz/dartz.dart';
import 'package:feedback_to_vfd/core/utils/failures.dart';
import 'package:feedback_to_vfd/features/projects/data/data_sources/projects_api_service.dart';
import 'package:feedback_to_vfd/features/projects/domain/entities/project_entity.dart';
import 'package:feedback_to_vfd/features/projects/domain/entities/project_member_entity.dart';
import 'package:feedback_to_vfd/features/projects/domain/repository/projects_repository.dart';
import 'package:feedback_to_vfd/features/users/domain/entities/user_entity.dart';

class ProjectsRepositoryImpl implements ProjectsRepository {
  ProjectsRepositoryImpl(this.apiService);
  final ProjectsApiService apiService;

  @override
  Future<Either<Failure, List<ProjectEntity>>> getProjects() async {
    try {
      final projects = await apiService.fetchProjects();
      return Right(projects);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ProjectEntity>> createProject(
    String name,
    String? description,
  ) async {
    try {
      final project = await apiService.createProject(name, description);
      return Right(project);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> assignMember(
    String projectId,
    String userId,
    String role,
  ) async {
    try {
      await apiService.assignMember(projectId, userId, role);
      return const Right(unit);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ProjectMemberEntity>>> getProjectMembers(
    String projectId,
  ) async {
    try {
      final members = await apiService.fetchProjectMembers(projectId);
      return Right(members);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<UserEntity>>> getClients() async {
    try {
      final clients = await apiService.fetchAllClients();
      return Right(clients);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
