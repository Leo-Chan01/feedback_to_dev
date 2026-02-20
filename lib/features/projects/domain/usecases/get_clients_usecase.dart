import 'package:dartz/dartz.dart';
import 'package:feedback_to_vfd/core/utils/failures.dart';
import 'package:feedback_to_vfd/core/utils/usecase.dart';
import 'package:feedback_to_vfd/features/projects/domain/repository/projects_repository.dart';
import 'package:feedback_to_vfd/features/users/domain/entities/user_entity.dart';

class GetClientsUsecase
    implements UseCaseWithEitherFailure<List<UserEntity>, NoParams> {
  GetClientsUsecase(this.repository);
  final ProjectsRepository repository;

  @override
  Future<Either<Failure, List<UserEntity>>> call(NoParams params) async {
    return repository.getClients();
  }
}
