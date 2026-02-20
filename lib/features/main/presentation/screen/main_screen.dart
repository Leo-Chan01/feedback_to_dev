import 'package:feedback_to_vfd/core/utils/ui_component_exports.dart';
import 'package:feedback_to_vfd/features/users/presentation/provider/auth_provider.dart';
import 'package:feedback_to_vfd/shared/configs/theme/colors.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({
    required this.shell,
    super.key,
  });

  final StatefulNavigationShell shell;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    final isAdmin = context.read<AuthProvider>().currentUser?.role == 'admin';

    // Map UI indices to Branch indices
    // 0: Dashboard -> 0
    // 1: Projects -> 1
    // 2: Feedback -> 2 (Client only)
    // 3: Profile -> 3 (Client index 3, Admin index 2)

    int uiIndexToBranchIndex(int index) {
      if (isAdmin) {
        if (index == 2) return 3; // Profile
      }
      return index;
    }

    int branchIndexToUiIndex(int index) {
      if (isAdmin) {
        if (index == 3) return 2; // Profile
        if (index == 2) return 0; // Fallback or handle appropriately
      }
      return index;
    }

    return Scaffold(
      body: widget.shell,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppColors.yfdBackgrundColor,
          border: Border(
            top: BorderSide(
              color: AppColors.yfdGrey04,
            ),
          ),
        ),
        child: BottomNavigationBar(
          currentIndex: branchIndexToUiIndex(widget.shell.currentIndex),
          onTap: (index) {
            widget.shell.goBranch(
              uiIndexToBranchIndex(index),
              initialLocation:
                  uiIndexToBranchIndex(index) == widget.shell.currentIndex,
            );
          },
          backgroundColor: AppColors.yfdBackgrundColor,
          selectedItemColor: AppColors.yfdPrimary,
          unselectedItemColor: AppColors.yfdDarkGrey03,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          items: [
            const BottomNavigationBarItem(
              icon: Icon(Icons.dashboard_outlined),
              activeIcon: Icon(Icons.dashboard),
              label: 'Dashboard',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.folder_outlined),
              activeIcon: Icon(Icons.folder),
              label: 'Projects',
            ),
            if (!isAdmin)
              const BottomNavigationBarItem(
                icon: Icon(Icons.add_circle_outline),
                activeIcon: Icon(Icons.add_circle),
                label: 'Feedback',
              ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              activeIcon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
