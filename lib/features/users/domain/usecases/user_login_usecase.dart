import 'package:dartz/dartz.dart';
import 'package:feedback_to_vfd/core/utils/failures.dart';
import 'package:feedback_to_vfd/core/utils/usecase.dart';
import 'package:feedback_to_vfd/features/users/domain/entities/user_entity.dart';
import 'package:feedback_to_vfd/features/users/domain/repostitory/auth_repository.dart';

class UserLoginUsecase extends UseCaseWithEitherFailure<UserEntity, String> {
  UserLoginUsecase(this._repository);

  final AuthRepository _repository;
  @override
  Future<Either<Failure, UserEntity>> call(String accessId) async {
    return _repository.logUserIn(accessId);
  }
}
