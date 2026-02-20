import 'package:feedback_to_vfd/core/utils/ui_component_exports.dart';
import 'package:feedback_to_vfd/features/projects/domain/entities/project_entity.dart';
import 'package:feedback_to_vfd/features/projects/presentation/provider/projects_provider.dart';
import 'package:feedback_to_vfd/features/projects/presentation/widgets/assign_member_dialog.dart';
import 'package:feedback_to_vfd/features/users/presentation/provider/auth_provider.dart';
import 'package:provider/provider.dart';

class ProjectDetailScreen extends StatefulWidget {
  const ProjectDetailScreen({required this.project, super.key});
  final ProjectEntity project;

  @override
  State<ProjectDetailScreen> createState() => _ProjectDetailScreenState();
}

class _ProjectDetailScreenState extends State<ProjectDetailScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProjectsProvider>().loadProjectMembers(widget.project.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final isAdmin = context.read<AuthProvider>().currentUser?.role == 'admin';

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.project.name),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoCard(context),
            24.vertSpacing,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Members',
                  style: context.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (isAdmin)
                  TextButton.icon(
                    onPressed: () => _showAssignMemberDialog(context),
                    icon: const Icon(Icons.add),
                    label: const Text('Assign'),
                  ),
              ],
            ),
            8.vertSpacing,
            _buildMembersList(),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Description',
              style: context.textTheme.bodySmall?.copyWith(color: Colors.grey),
            ),
            8.vertSpacing,
            Text(
              widget.project.description ?? 'No description provided.',
              style: context.textTheme.bodyLarge,
            ),
            16.vertSpacing,
            Row(
              children: [
                _buildChip('Status', widget.project.status.toUpperCase()),
                16.horizSpacing,
                _buildChip('Created At', _formatDate(widget.project.createdAt)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChip(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildMembersList() {
    return Consumer<ProjectsProvider>(
      builder: (context, provider, _) {
        if (provider.isLoading && provider.currentProjectMembers.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        if (provider.currentProjectMembers.isEmpty) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Center(child: Text('No members assigned yet')),
          );
        }

        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: provider.currentProjectMembers.length,
          itemBuilder: (context, index) {
            final member = provider.currentProjectMembers[index];
            return Card(
              margin: const EdgeInsets.only(bottom: 8),
              child: ListTile(
                leading: CircleAvatar(
                  child: Text(
                    member.userName?.isNotEmpty == true
                        ? member.userName![0]
                        : '?',
                  ),
                ),
                title: Text(member.userName ?? member.userId),
                subtitle: Text(member.userEmail ?? ''),
                trailing: Chip(
                  label: Text(
                    member.role.toUpperCase(),
                    style: const TextStyle(fontSize: 10),
                  ),
                  backgroundColor: _getRoleColor(member.role).withOpacity(0.1),
                  side: BorderSide(color: _getRoleColor(member.role)),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Color _getRoleColor(String role) {
    switch (role.toLowerCase()) {
      case 'manager':
        return Colors.blue;
      case 'viewer':
        return Colors.green;
      default:
        return Colors.orange;
    }
  }

  String _formatDate(DateTime? date) {
    if (date == null) return 'N/A';
    return '${date.day}/${date.month}/${date.year}';
  }

  void _showAssignMemberDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (context) => AssignMemberDialog(projectId: widget.project.id),
    );
  }
}
