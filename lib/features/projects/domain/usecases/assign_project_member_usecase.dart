import 'package:dartz/dartz.dart';
import 'package:feedback_to_vfd/core/utils/failures.dart';
import 'package:feedback_to_vfd/core/utils/usecase.dart';
import 'package:feedback_to_vfd/features/projects/domain/repository/projects_repository.dart';

class AssignMemberParams {
  AssignMemberParams({
    required this.projectId,
    required this.userId,
    required this.role,
  });
  final String projectId;
  final String userId;
  final String role;
}

class AssignProjectMemberUsecase
    implements UseCaseWithEitherFailure<Unit, AssignMemberParams> {
  AssignProjectMemberUsecase(this.repository);
  final ProjectsRepository repository;

  @override
  Future<Either<Failure, Unit>> call(AssignMemberParams params) async {
    return repository.assignMember(
      params.projectId,
      params.userId,
      params.role,
    );
  }
}
