import 'package:dartz/dartz.dart';
import 'package:feedback_to_vfd/core/utils/failures.dart';
import 'package:feedback_to_vfd/features/users/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserEntity>> logUserIn(String accessId);
  Future<Either<Failure, UserEntity>> getUserData(String accessId);
  Future<Either<Failure, UserEntity?>> initializeAuth();
  Future<void> logout();
}
