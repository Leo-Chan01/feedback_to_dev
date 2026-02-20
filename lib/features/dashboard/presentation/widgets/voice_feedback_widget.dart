import 'package:feedback_to_vfd/core/helpers/extensions/num_extension.dart';
import 'package:feedback_to_vfd/core/utils/ui_component_exports.dart';
import 'package:feedback_to_vfd/shared/configs/theme/colors.dart';

class VoiceFeedbackWidget extends StatelessWidget {
  const VoiceFeedbackWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.yfdGrey06,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.yfdGrey04,
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Voice Feedback',
                style: 14.w600.copyWith(color: AppColors.yfdWhite),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.close,
                  color: AppColors.yfdDarkGrey03,
                  size: 20.w,
                ),
              ),
            ],
          ),
          20.vertSpacing,

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: AppColors.yfdRedPure.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.mic, color: AppColors.yfdRedPure, size: 32.w),
              ),
            ],
          ),
          12.vertSpacing,
          Text(
            'Tap to record',
            style: 12.w400.copyWith(color: AppColors.yfdDarkGrey03),
          ),
        ],
      ),
    );
  }
}
