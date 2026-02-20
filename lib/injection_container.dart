import 'package:feedback_to_vfd/features/users/data/data_sources/users_api_service.dart';
import 'package:feedback_to_vfd/features/users/data/repository/auth_repository_impl.dart';
import 'package:feedback_to_vfd/features/users/domain/repostitory/auth_repository.dart';
import 'package:feedback_to_vfd/features/users/domain/usecases/user_login_usecase.dart';
import 'package:feedback_to_vfd/features/users/presentation/provider/auth_provider.dart';
import 'package:feedback_to_vfd/features/projects/data/data_sources/projects_api_service.dart';
import 'package:feedback_to_vfd/features/projects/data/repository/projects_repository_impl.dart';
import 'package:feedback_to_vfd/features/projects/domain/repository/projects_repository.dart';
import 'package:feedback_to_vfd/features/projects/domain/usecases/assign_project_member_usecase.dart';
import 'package:feedback_to_vfd/features/projects/domain/usecases/create_project_usecase.dart';
import 'package:feedback_to_vfd/features/projects/domain/usecases/get_clients_usecase.dart';
import 'package:feedback_to_vfd/features/projects/domain/usecases/get_project_members_usecase.dart';
import 'package:feedback_to_vfd/features/projects/domain/usecases/get_projects_usecase.dart';
import 'package:feedback_to_vfd/features/projects/presentation/provider/projects_provider.dart';
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
    ..registerLazySingleton<ProjectsApiService>(
      () => ProjectsApiServiceImpl(sl()),
    )
    // Repositories
    ..registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(
        remoteDataSource: sl(),
        supabase: sl(),
      ),
    )
    ..registerLazySingleton<ProjectsRepository>(
      () => ProjectsRepositoryImpl(sl()),
    )
    // Use Cases
    ..registerLazySingleton(
      () => UserLoginUsecase(sl()),
    )
    ..registerLazySingleton(
      () => GetProjectsUsecase(sl()),
    )
    ..registerLazySingleton(
      () => CreateProjectUsecase(sl()),
    )
    ..registerLazySingleton(
      () => AssignProjectMemberUsecase(sl()),
    )
    ..registerLazySingleton(
      () => GetProjectMembersUsecase(sl()),
    )
    ..registerLazySingleton(
      () => GetClientsUsecase(sl()),
    )
    // Providers
    ..registerLazySingleton(
      () => AuthProvider(loginUserUsecase: sl()),
    )
    ..registerLazySingleton(
      () => ProjectsProvider(
        getProjectsUsecase: sl(),
        createProjectUsecase: sl(),
        assignMemberUsecase: sl(),
        getProjectMembersUsecase: sl(),
        getClientsUsecase: sl(),
      ),
    );
}
