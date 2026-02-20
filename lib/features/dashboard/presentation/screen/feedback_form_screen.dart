import 'package:feedback_to_vfd/core/helpers/extensions/num_extension.dart';
import 'package:feedback_to_vfd/core/utils/ui_component_exports.dart';
import 'package:feedback_to_vfd/features/dashboard/presentation/widgets/media_upload_widget.dart';
import 'package:feedback_to_vfd/features/dashboard/presentation/widgets/voice_feedback_widget.dart';
import 'package:feedback_to_vfd/shared/configs/theme/colors.dart';

class FeedbackFormScreen extends StatefulWidget {
  const FeedbackFormScreen({super.key});

  static const String path = '/feedback';
  static const String name = 'UnifiedFeedback';

  @override
  State<FeedbackFormScreen> createState() => _FeedbackFormScreenState();
}

class _FeedbackFormScreenState extends State<FeedbackFormScreen> {
  final TextEditingController _descriptionController = TextEditingController();
  String selectedProject = 'VFD Bank App';
  bool showVoiceSection = false;
  bool showMediaSection = false;

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.yfdBackgrundColor,
      appBar: AppBar(
        title: Text(
          'Tell me what happened',
          style: 18.w600.copyWith(color: AppColors.yfdWhite),
        ),
        backgroundColor: AppColors.yfdBackgrundColor,
        elevation: 0,
        centerTitle: false,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Project',
                style: 14.w500.copyWith(color: AppColors.yfdDarkGrey03),
              ),
              8.vertSpacing,
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                decoration: BoxDecoration(
                  color: AppColors.yfdGrey06,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: AppColors.yfdGrey04),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: selectedProject,
                    dropdownColor: AppColors.yfdGrey06,
                    icon: Icon(
                      Icons.keyboard_arrow_down,
                      color: AppColors.yfdDarkGrey03,
                    ),
                    isExpanded: true,
                    items: ['VFD Bank App', 'VBridge Web', 'Feedback Portal']
                        .map(
                          (e) => DropdownMenuItem(
                            value: e,
                            child: Text(
                              e,
                              style: 14.w500.copyWith(
                                color: AppColors.yfdWhite,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (val) {
                      setState(() {
                        selectedProject = val!;
                      });
                    },
                  ),
                ),
              ),
              24.vertSpacing,
              Text(
                'Description',
                style: 14.w500.copyWith(color: AppColors.yfdDarkGrey03),
              ),
              8.vertSpacing,
              TextField(
                controller: _descriptionController,
                maxLines: 4,
                style: 14.w400.copyWith(color: AppColors.yfdWhite),
                decoration: InputDecoration(
                  hintText: 'Describe the issue or feedback...',
                  hintStyle: 14.w400.copyWith(color: AppColors.yfdLightGrey10),
                  filled: true,
                  fillColor: AppColors.yfdGrey06,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide(color: AppColors.yfdGrey04),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide(color: AppColors.yfdGrey04),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide(color: AppColors.yfdPrimary),
                  ),
                ),
              ),
              24.vertSpacing,
              Text(
                'Add Attachments',
                style: 14.w500.copyWith(color: AppColors.yfdDarkGrey03),
              ),
              12.vertSpacing,
              Row(
                children: [
                  _AttachmentToggle(
                    icon: Icons.mic_none_outlined,
                    label: 'Voice',
                    isActive: showVoiceSection,
                    onTap: () =>
                        setState(() => showVoiceSection = !showVoiceSection),
                  ),
                  12.horizSpacing,
                  _AttachmentToggle(
                    icon: Icons.photo_outlined,
                    label: 'Media',
                    isActive: showMediaSection,
                    onTap: () =>
                        setState(() => showMediaSection = !showMediaSection),
                  ),
                ],
              ),
              if (showVoiceSection) ...[
                20.vertSpacing,
                const VoiceFeedbackWidget(),
              ],
              if (showMediaSection) ...[
                20.vertSpacing,
                const MediaUploadWidget(type: 'gallery'),
              ],
              40.vertSpacing,
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.yfdPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 18.h),
                    elevation: 0,
                  ),
                  child: Text(
                    'Submit Feedback',
                    style: 16.bold.copyWith(color: AppColors.yfdWhite),
                  ),
                ),
              ),
              20.vertSpacing,
            ],
          ),
        ),
      ),
    );
  }
}

class _AttachmentToggle extends StatelessWidget {
  const _AttachmentToggle({
    required this.icon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: isActive
              ? AppColors.yfdPrimary.withValues(alpha: 0.1)
              : AppColors.yfdGrey06,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(
            color: isActive ? AppColors.yfdPrimary : AppColors.yfdGrey04,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isActive ? AppColors.yfdPrimary : AppColors.yfdDarkGrey03,
              size: 20.w,
            ),
            8.horizSpacing,
            Text(
              label,
              style: 12.w500.copyWith(
                color: isActive
                    ? AppColors.yfdPrimary
                    : AppColors.yfdLightGrey08,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
