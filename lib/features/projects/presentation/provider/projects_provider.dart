import 'package:feedback_to_vfd/core/error/provider_error_handling_mixin.dart';
import 'package:feedback_to_vfd/core/utils/ui_component_exports.dart';
import 'package:feedback_to_vfd/core/utils/usecase.dart';
import 'package:feedback_to_vfd/features/projects/domain/entities/project_entity.dart';
import 'package:feedback_to_vfd/features/projects/domain/entities/project_member_entity.dart';
import 'package:feedback_to_vfd/features/projects/domain/usecases/assign_project_member_usecase.dart';
import 'package:feedback_to_vfd/features/projects/domain/usecases/create_project_usecase.dart';
import 'package:feedback_to_vfd/features/projects/domain/usecases/get_clients_usecase.dart';
import 'package:feedback_to_vfd/features/projects/domain/usecases/get_project_members_usecase.dart';
import 'package:feedback_to_vfd/features/projects/domain/usecases/get_projects_usecase.dart';
import 'package:feedback_to_vfd/features/users/domain/entities/user_entity.dart';
import 'package:feedback_to_vfd/shared/widgets/global_snackbar.dart';

class ProjectsProvider extends ChangeNotifier with ProviderErrorHandling {
  ProjectsProvider({
    required this.getProjectsUsecase,
    required this.createProjectUsecase,
    required this.assignMemberUsecase,
    required this.getProjectMembersUsecase,
    required this.getClientsUsecase,
  });

  final GetProjectsUsecase getProjectsUsecase;
  final CreateProjectUsecase createProjectUsecase;
  final AssignProjectMemberUsecase assignMemberUsecase;
  final GetProjectMembersUsecase getProjectMembersUsecase;
  final GetClientsUsecase getClientsUsecase;

  List<ProjectEntity> _projects = [];
  List<ProjectEntity> get projects => _projects;

  List<ProjectMemberEntity> _currentProjectMembers = [];
  List<ProjectMemberEntity> get currentProjectMembers => _currentProjectMembers;

  List<UserEntity> _allClients = [];
  List<UserEntity> get allClients => _allClients;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> loadProjects() async {
    _isLoading = true;
    notifyListeners();

    final response = await getProjectsUsecase.call(NoParams());
    response.fold(
      (error) => GlobalSnackBar.showError(error.message),
      (data) => _projects = data,
    );

    _isLoading = false;
    notifyListeners();
  }

  Future<void> createProject(String name, String? description) async {
    _isLoading = true;
    notifyListeners();

    final response = await createProjectUsecase.call(
      CreateProjectParams(name: name, description: description),
    );

    response.fold(
      (error) => GlobalSnackBar.showError(error.message),
      (project) {
        _projects.insert(0, project);
        GlobalSnackBar.showSuccess('Project created successfully');
      },
    );

    _isLoading = false;
    notifyListeners();
  }

  Future<void> loadProjectMembers(String projectId) async {
    _isLoading = true;
    notifyListeners();

    final response = await getProjectMembersUsecase.call(projectId);
    response.fold(
      (error) => GlobalSnackBar.showError(error.message),
      (data) => _currentProjectMembers = data,
    );

    _isLoading = false;
    notifyListeners();
  }

  Future<void> assignMember(
    String projectId,
    String userId,
    String role,
  ) async {
    _isLoading = true;
    notifyListeners();

    final response = await assignMemberUsecase.call(
      AssignMemberParams(projectId: projectId, userId: userId, role: role),
    );

    response.fold(
      (error) => GlobalSnackBar.showError(error.message),
      (_) {
        GlobalSnackBar.showSuccess('Member assigned successfully');
        loadProjectMembers(projectId);
      },
    );

    _isLoading = false;
    notifyListeners();
  }

  Future<void> loadAllClients() async {
    final response = await getClientsUsecase.call(NoParams());
    response.fold(
      (error) => GlobalSnackBar.showError(error.message),
      (data) => _allClients = data,
    );
    notifyListeners();
  }
}
