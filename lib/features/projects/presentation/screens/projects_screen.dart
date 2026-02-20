import 'package:feedback_to_vfd/core/utils/ui_component_exports.dart';
import 'package:feedback_to_vfd/features/projects/domain/entities/project_entity.dart';
import 'package:feedback_to_vfd/features/projects/presentation/provider/projects_provider.dart';
import 'package:feedback_to_vfd/features/projects/presentation/screens/project_detail_screen.dart';
import 'package:feedback_to_vfd/features/projects/presentation/widgets/add_project_dialog.dart';
import 'package:feedback_to_vfd/features/users/presentation/provider/auth_provider.dart';
import 'package:provider/provider.dart';

class ProjectsScreen extends StatefulWidget {
  const ProjectsScreen({super.key});

  @override
  State<ProjectsScreen> createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends State<ProjectsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProjectsProvider>().loadProjects();
    });
  }

  @override
  Widget build(BuildContext context) {
    final isAdmin = context.read<AuthProvider>().currentUser?.role == 'admin';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Projects'),
      ),
      body: Consumer<ProjectsProvider>(
        builder: (context, projectsProvider, _) {
          if (projectsProvider.isLoading && projectsProvider.projects.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (projectsProvider.projects.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.folder_open, size: 64, color: Colors.grey),
                  16.vertSpacing,
                  const Text('No projects found'),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () => projectsProvider.loadProjects(),
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: projectsProvider.projects.length,
              itemBuilder: (context, index) {
                final project = projectsProvider.projects[index];
                return _ProjectCard(project: project);
              },
            ),
          );
        },
      ),
      floatingActionButton: isAdmin
          ? FloatingActionButton.extended(
              onPressed: () => _showAddProjectDialog(context),
              label: const Text('Add Project'),
              icon: const Icon(Icons.add),
            )
          : null,
    );
  }

  void _showAddProjectDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (context) => const AddProjectDialog(),
    );
  }
}

class _ProjectCard extends StatelessWidget {
  const _ProjectCard({required this.project});
  final ProjectEntity project;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        title: Text(
          project.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          project.description ?? 'No description',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (context) => ProjectDetailScreen(project: project),
            ),
          );
        },
      ),
    );
  }
}
