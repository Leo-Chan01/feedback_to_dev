import 'package:feedback_to_vfd/features/users/data/data_sources/users_api_service.dart';
import 'package:feedback_to_vfd/features/users/data/repository/auth_repository_impl.dart';
import 'package:feedback_to_vfd/features/users/domain/repostitory/auth_repository.dart';
import 'package:feedback_to_vfd/features/users/domain/usecases/user_login_usecase.dart';
import 'package:feedback_to_vfd/features/users/presentation/provider/auth_provider.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

GetIt sl = GetIt.instance;

Future<void> getDependencies() async {
  sl
    ..registerLazySingleton<SupabaseClient>(
      () => Supabase.instance.client,
    )
    // Data Sources
    ..registerLazySingleton<UsersApiService>(
      () => UsersApiServiceImpl(sl()),
    )
    // Repositories
    ..registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(
        remoteDataSource: sl(),
        supabase: sl(),
      ),
    )
    // Use Cases
    ..registerLazySingleton(
      () => UserLoginUsecase(sl()),
    )
    // Providers
    ..registerLazySingleton(
      () => AuthProvider(loginUserUsecase: sl()),
    );
}
