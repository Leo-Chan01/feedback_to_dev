import 'package:feedback_to_vfd/core/utils/ui_component_exports.dart';
import 'package:feedback_to_vfd/features/projects/presentation/provider/projects_provider.dart';
import 'package:feedback_to_vfd/features/users/domain/entities/user_entity.dart';
import 'package:provider/provider.dart';

class AssignMemberDialog extends StatefulWidget {
  const AssignMemberDialog({required this.projectId, super.key});
  final String projectId;

  @override
  State<AssignMemberDialog> createState() => _AssignMemberDialogState();
}

class _AssignMemberDialogState extends State<AssignMemberDialog> {
  UserEntity? _selectedUser;
  String _selectedRole = 'member';
  final List<String> _roles = ['member', 'manager', 'viewer'];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProjectsProvider>().loadAllClients();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Assign Member'),
      content: Consumer<ProjectsProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading && provider.allClients.isEmpty) {
            return const SizedBox(
              height: 100,
              child: Center(child: CircularProgressIndicator()),
            );
          }

          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Select Client'),
              8.vertSpacing,
              DropdownButtonFormField<UserEntity>(
                value: _selectedUser,
                items: provider.allClients.map((user) {
                  return DropdownMenuItem(
                    value: user,
                    child: Text(user.name ?? user.email ?? 'Unknown'),
                  );
                }).toList(),
                onChanged: (value) => setState(() => _selectedUser = value),
                decoration: const InputDecoration(border: OutlineInputBorder()),
              ),
              16.vertSpacing,
              const Text('Select Role'),
              8.vertSpacing,
              DropdownButtonFormField<String>(
                value: _selectedRole,
                items: _roles.map((role) {
                  return DropdownMenuItem(
                    value: role,
                    child: Text(role.toUpperCase()),
                  );
                }).toList(),
                onChanged: (value) => setState(() => _selectedRole = value!),
                decoration: const InputDecoration(border: OutlineInputBorder()),
              ),
            ],
          );
        },
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _selectedUser == null
              ? null
              : () async {
                  await context.read<ProjectsProvider>().assignMember(
                    widget.projectId,
                    _selectedUser!.id!,
                    _selectedRole,
                  );
                  if (mounted) Navigator.pop(context);
                },
          child: const Text('Assign'),
        ),
      ],
    );
  }
}
