//NECESSARY TO IGNORE
// ignore_for_file: avoid_types_as_parameter_names, one_member_abstracts

import 'package:dartz/dartz.dart';
import 'package:feedback_to_vfd/core/utils/failures.dart';

/// Base Usecase class for all use cases that return a result of (Type) and take input of (Params) with a Request of Type
abstract class UseCase<Type, Params> {
  Future<Type> call(Params params);
}

/// Use case for operations that don't need parameters
abstract class UseCaseNoParams<Type> {
  Future<Either<Failure, Type>> call();
}

/// Usecase for operations that return a result of (Type) and take input of (Params) with a request of Either<Failure, Type>
abstract class UseCaseWithEitherFailure<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class NoParams {}
