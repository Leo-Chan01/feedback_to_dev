import 'package:feedback_to_vfd/features/projects/data/models/project_member_model.dart';
import 'package:feedback_to_vfd/features/projects/data/models/project_model.dart';
import 'package:feedback_to_vfd/features/users/data/model/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class ProjectsApiService {
  Future<List<ProjectModel>> fetchProjects();
  Future<ProjectModel> createProject(String name, String? description);
  Future<void> assignMember(String projectId, String userId, String role);
  Future<List<ProjectMemberModel>> fetchProjectMembers(String projectId);
  Future<List<UserModel>> fetchAllClients();
}

class ProjectsApiServiceImpl implements ProjectsApiService {
  ProjectsApiServiceImpl(this.supabase);
  final SupabaseClient supabase;

  @override
  Future<List<ProjectModel>> fetchProjects() async {
    final response = await supabase
        .from('client_projects')
        .select('*')
        .order('created_at', ascending: false);

    return (response as List)
        .map((json) => ProjectModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<ProjectModel> createProject(String name, String? description) async {
    final response = await supabase
        .from('client_projects')
        .insert({
          'name': name,
          'description': description,
          'created_by': supabase.auth.currentUser?.id,
        })
        .select()
        .single();

    final project = ProjectModel.fromJson(response);
    await assignMember(project.id, supabase.auth.currentUser!.id, 'manager');

    return project;
  }

  @override
  Future<void> assignMember(
    String projectId,
    String userId,
    String role,
  ) async {
    await supabase.from('project_members').upsert({
      'project_id': projectId,
      'user_id': userId,
      'role': role,
    });
  }

  @override
  Future<List<ProjectMemberModel>> fetchProjectMembers(String projectId) async {
    final response = await supabase
        .from('project_members')
        .select('*, users(*)')
        .eq('project_id', projectId);

    return (response as List)
        .map(
          (json) => ProjectMemberModel.fromJson(json as Map<String, dynamic>),
        )
        .toList();
  }

  @override
  Future<List<UserModel>> fetchAllClients() async {
    final response = await supabase
        .from('users')
        .select('*')
        .eq('role', 'client');

    return (response as List)
        .map((json) => UserModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}
