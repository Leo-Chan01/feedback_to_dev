import 'package:feedback_to_vfd/core/helpers/extensions/num_extension.dart';
import 'package:feedback_to_vfd/core/utils/ui_component_exports.dart';
import 'package:feedback_to_vfd/shared/configs/theme/colors.dart';

class FeedbackSummaryList extends StatelessWidget {
  const FeedbackSummaryList({
    required this.feedbacks,
    super.key,
  });

  final List<FeedbackItem> feedbacks;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recent Feedback',
                style: 16.w600.copyWith(color: AppColors.yfdWhite),
              ),
              Text(
                'See All',
                style: 12.w500.copyWith(color: AppColors.yfdPrimary),
              ),
            ],
          ),
        ),
        16.vertSpacing,
        ListView.separated(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: feedbacks.length,
          separatorBuilder: (context, index) => 12.vertSpacing,
          itemBuilder: (context, index) {
            final feedback = feedbacks[index];
            return Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: AppColors.yfdGrey06,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: AppColors.yfdGrey04,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 40.w,
                    height: 40.w,
                    decoration: BoxDecoration(
                      color: feedback.statusColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Icon(
                      feedback.icon,
                      color: feedback.statusColor,
                      size: 20.w,
                    ),
                  ),
                  16.horizSpacing,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          feedback.title,
                          style: 14.w600.copyWith(color: AppColors.yfdWhite),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        4.vertSpacing,
                        Text(
                          feedback.projectName,
                          style: 12.w400.copyWith(
                            color: AppColors.yfdDarkGrey03,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        feedback.date,
                        style: 10.w400.copyWith(color: AppColors.yfdDarkGrey03),
                      ),
                      4.vertSpacing,
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 4.h,
                        ),
                        decoration: BoxDecoration(
                          color: feedback.statusColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                        child: Text(
                          feedback.statusLabel,
                          style: 10.w600.copyWith(color: feedback.statusColor),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}

class FeedbackItem {

  FeedbackItem({
    required this.title,
    required this.projectName,
    required this.date,
    required this.statusLabel,
    required this.statusColor,
    required this.icon,
  });
  final String title;
  final String projectName;
  final String date;
  final String statusLabel;
  final Color statusColor;
  final IconData icon;
}
