import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:feedback_to_vfd/core/error/error_handler.dart';
import 'package:feedback_to_vfd/core/utils/failures.dart';
import 'package:feedback_to_vfd/features/users/data/data_sources/users_api_service.dart';
import 'package:feedback_to_vfd/features/users/data/model/user_model.dart';
import 'package:feedback_to_vfd/features/users/domain/entities/user_entity.dart';
import 'package:feedback_to_vfd/features/users/domain/repostitory/auth_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({required this.remoteDataSource, required this.supabase});

  final UsersApiService remoteDataSource;
  final SupabaseClient supabase;
  @override
  Future<Either<Failure, UserEntity>> getUserData(String accessId) async {
    try {
      final user = supabase.auth.currentUser;
      if (user == null) {
        return Left(ServerFailure(message: 'User not logged in'));
      }
      return Right(
        UserModel(
          id: user.id,
          email: user.email,
          accessId: accessId,
          name: user.userMetadata?['name'] as String? ?? '',
          role: user.role ?? '',
          isActive: true,
          accessToken: supabase.auth.currentSession?.accessToken ?? '',
          refreshToken: supabase.auth.currentSession?.refreshToken ?? '',
        ),
      );
    } catch (e) {
      return Left(ServerFailure(message: 'Failed to get user data: $e'));
    }
  }

  @override
  Future<Either<Failure, UserModel>> logUserIn(String accessId) async {
    try {
      final responseData = await remoteDataSource.logUserIn(accessId);

      final sessionData = responseData['session'] as Map<String, dynamic>;
      final userData = responseData['user'] as Map<String, dynamic>;

      await supabase.auth.setSession(
        sessionData['refresh_token'] as String,
      );

      final userModel = UserModel.fromJson(userData).copyWith(
        accessId: accessId,
        accessToken: sessionData['access_token'] as String?,
        refreshToken: sessionData['refresh_token'] as String?,
      );

      log('User logged in successfully');

      return Right(userModel);
    } catch (e) {
      log('Failed to login $e');
      return Left(
        ServerFailure(
          message: ErrorHandler.getUserFriendlyMessage(
            AuthFailure(message: e.toString()),
          ),
        ),
      );
    }
  }
}
