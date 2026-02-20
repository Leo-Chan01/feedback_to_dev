import 'package:dartz/dartz.dart';
import 'package:feedback_to_vfd/core/utils/failures.dart';
import 'package:feedback_to_vfd/core/utils/usecase.dart';
import 'package:feedback_to_vfd/features/projects/domain/entities/project_entity.dart';
import 'package:feedback_to_vfd/features/projects/domain/repository/projects_repository.dart';

class GetProjectsUsecase
    implements UseCaseWithEitherFailure<List<ProjectEntity>, NoParams> {
  GetProjectsUsecase(this.repository);
  final ProjectsRepository repository;

  @override
  Future<Either<Failure, List<ProjectEntity>>> call(NoParams params) async {
    return repository.getProjects();
  }
}
