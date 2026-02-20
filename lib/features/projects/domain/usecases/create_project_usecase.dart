import 'package:dartz/dartz.dart';
import 'package:feedback_to_vfd/core/utils/failures.dart';
import 'package:feedback_to_vfd/core/utils/usecase.dart';
import 'package:feedback_to_vfd/features/projects/domain/entities/project_entity.dart';
import 'package:feedback_to_vfd/features/projects/domain/repository/projects_repository.dart';

class CreateProjectParams {
  CreateProjectParams({required this.name, this.description});
  final String name;
  final String? description;
}

class CreateProjectUsecase
    implements UseCaseWithEitherFailure<ProjectEntity, CreateProjectParams> {
  CreateProjectUsecase(this.repository);
  final ProjectsRepository repository;

  @override
  Future<Either<Failure, ProjectEntity>> call(
    CreateProjectParams params,
  ) async {
    return repository.createProject(params.name, params.description);
  }
}
