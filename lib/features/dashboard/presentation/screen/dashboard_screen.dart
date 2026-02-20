import 'package:feedback_to_vfd/core/helpers/extensions/num_extension.dart';
import 'package:feedback_to_vfd/core/utils/ui_component_exports.dart';
import 'package:feedback_to_vfd/features/dashboard/presentation/screen/feedback_form_screen.dart';
import 'package:feedback_to_vfd/features/dashboard/presentation/widgets/feedback_summary_list.dart';
import 'package:feedback_to_vfd/features/dashboard/presentation/widgets/feedback_type_selector.dart';
import 'package:feedback_to_vfd/features/dashboard/presentation/widgets/media_upload_widget.dart';
import 'package:feedback_to_vfd/features/dashboard/presentation/widgets/project_filter.dart';
import 'package:feedback_to_vfd/features/dashboard/presentation/widgets/stats_grid.dart';
import 'package:feedback_to_vfd/features/dashboard/presentation/widgets/text_feedback_widget.dart';
import 'package:feedback_to_vfd/features/dashboard/presentation/widgets/voice_feedback_widget.dart';
import 'package:feedback_to_vfd/features/dashboard/presentation/widgets/welcome_header.dart';
import 'package:feedback_to_vfd/features/users/presentation/provider/auth_provider.dart';
import 'package:feedback_to_vfd/shared/configs/theme/colors.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  static const String path = '/dashboard';
  static const String name = 'Dashboard';

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String selectedProject = 'All Projects';
  String? activeFeedbackType;

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) {
        final user = authProvider.currentUser;
        final isAdmin = user?.role == 'admin';

        return Scaffold(
          backgroundColor: AppColors.yfdBackgrundColor,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  WelcomeHeader(userName: user?.name ?? 'User'),
                  if (isAdmin)
                    const StatsGrid(
                      totalFeedback: 124,
                      pending: 45,
                      inProgress: 12,
                      resolved: 67,
                    ),

                  if (!isAdmin) ...[
                    20.vertSpacing,
                    FeedbackTypeSelector(
                      onTypeSelected: (type) {
                        if (type == 'form') {
                          context.goNamed(FeedbackFormScreen.name);
                        } else {
                          setState(() {
                            activeFeedbackType = type;
                          });
                        }
                      },
                    ),
                    if (activeFeedbackType != null) ...[
                      24.vertSpacing,
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: activeFeedbackType == 'voice'
                            ? const VoiceFeedbackWidget()
                            : activeFeedbackType == 'text'
                            ? const TextFeedbackWidget()
                            : MediaUploadWidget(type: activeFeedbackType!),
                      ),
                    ],
                  ],

                  24.vertSpacing,
                  ProjectFilter(
                    projects: isAdmin
                        ? const [
                            'All Projects',
                            'VFD Bank App',
                            'VBridge Web',
                            'Feedback Portal',
                          ]
                        : const ['VFD Bank App'],
                    selectedProject: selectedProject,
                    onProjectSelected: (project) {
                      setState(() {
                        selectedProject = project;
                      });
                    },
                  ),

                  24.vertSpacing,
                  FeedbackSummaryList(
                    feedbacks: [
                      FeedbackItem(
                        title: 'Login button not responding',
                        projectName: 'VFD Bank App',
                        date: '2 hours ago',
                        statusLabel: 'Pending',
                        statusColor: AppColors.yfdRedPure,
                        icon: Icons.error_outline,
                      ),
                      if (isAdmin) ...[
                        FeedbackItem(
                          title: 'Update profile picture fails',
                          projectName: 'VBridge Web',
                          date: 'Yesterday',
                          statusLabel: 'In Progress',
                          statusColor: AppColors.yfdButtonBlue,
                          icon: Icons.sync,
                        ),
                        FeedbackItem(
                          title: 'Dark mode contrast issues',
                          projectName: 'Feedback Portal',
                          date: 'Feb 18, 2026',
                          statusLabel: 'Resolved',
                          statusColor: AppColors.yfdGreenPure,
                          icon: Icons.check_circle_outline,
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
