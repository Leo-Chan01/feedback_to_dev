import 'package:dartz/dartz.dart';
import 'package:feedback_to_vfd/core/utils/failures.dart';
import 'package:feedback_to_vfd/core/utils/usecase.dart';
import 'package:feedback_to_vfd/features/projects/domain/entities/project_member_entity.dart';
import 'package:feedback_to_vfd/features/projects/domain/repository/projects_repository.dart';

class GetProjectMembersUsecase
    implements UseCaseWithEitherFailure<List<ProjectMemberEntity>, String> {
  GetProjectMembersUsecase(this.repository);
  final ProjectsRepository repository;

  @override
  Future<Either<Failure, List<ProjectMemberEntity>>> call(
    String projectId,
  ) async {
    return repository.getProjectMembers(projectId);
  }
}
