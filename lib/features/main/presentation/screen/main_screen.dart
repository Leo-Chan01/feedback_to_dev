import 'package:feedback_to_vfd/core/utils/ui_component_exports.dart';
import 'package:feedback_to_vfd/shared/configs/theme/colors.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({
    required this.shell, super.key,
  });

  final StatefulNavigationShell shell;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    var isAdmin = false;
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
          currentIndex: widget.shell.currentIndex,
          onTap: (index) {
            widget.shell.goBranch(
              index,
              initialLocation: index == widget.shell.currentIndex,
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
