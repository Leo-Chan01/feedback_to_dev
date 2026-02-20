import 'package:feedback_to_vfd/core/utils/ui_component_exports.dart';
import 'package:feedback_to_vfd/core/helpers/extensions/num_extension.dart';
import 'package:feedback_to_vfd/shared/configs/theme/colors.dart';
import 'package:flutter/material.dart';

class StatsGrid extends StatelessWidget {
  const StatsGrid({
    required this.totalFeedback, required this.pending, required this.inProgress, required this.resolved, super.key,
  });

  final int totalFeedback;
  final int pending;
  final int inProgress;
  final int resolved;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      child: GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        crossAxisSpacing: 16.w,
        mainAxisSpacing: 16.h,
        childAspectRatio: 1.5,
        children: [
          _StatsCard(
            label: 'Total Feedback',
            value: totalFeedback.toString(),
            color: AppColors.yfdBlue03.withOpacity(0.1),
            textColor: AppColors.yfdBlue01,
          ),
          _StatsCard(
            label: 'Pending',
            value: pending.toString(),
            color: AppColors.yfdRed05.withOpacity(0.1),
            textColor: AppColors.yfdRed01,
          ),
          _StatsCard(
            label: 'In Progress',
            value: inProgress.toString(),
            color: AppColors.yfdButtonBlue.withOpacity(0.1),
            textColor: AppColors.yfdButtonBlue,
          ),
          _StatsCard(
            label: 'Resolved',
            value: resolved.toString(),
            color: AppColors.yfdGreenPure.withOpacity(0.1),
            textColor: AppColors.yfdGreenPure,
          ),
        ],
      ),
    );
  }
}

class _StatsCard extends StatelessWidget {
  const _StatsCard({
    required this.label,
    required this.value,
    required this.color,
    required this.textColor,
  });

  final String label;
  final String value;
  final Color color;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: textColor.withOpacity(0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            value,
            style: 20.bold.copyWith(color: textColor),
          ),
          4.vertSpacing,
          Text(
            label,
            style: 12.w500.copyWith(color: textColor.withOpacity(0.7)),
          ),
        ],
      ),
    );
  }
}
