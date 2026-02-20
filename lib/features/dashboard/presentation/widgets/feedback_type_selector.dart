import 'package:feedback_to_vfd/core/helpers/extensions/num_extension.dart';
import 'package:feedback_to_vfd/core/utils/ui_component_exports.dart';
import 'package:feedback_to_vfd/shared/configs/theme/colors.dart';
import 'package:flutter/material.dart';

class FeedbackTypeSelector extends StatelessWidget {
  const FeedbackTypeSelector({
    required this.onTypeSelected, super.key,
  });

  final void Function(String) onTypeSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'New Feedback',
            style: 16.w600.copyWith(color: AppColors.yfdWhite),
          ),
        ),
        16.vertSpacing,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              _TypeCard(
                icon: Icons.mic_none_outlined,
                label: 'Voice',
                color: AppColors.yfdPrimary,
                onTap: () => onTypeSelected('voice'),
              ),
              12.horizSpacing,
              _TypeCard(
                icon: Icons.videocam_outlined,
                label: 'Video',
                color: AppColors.yfdButtonBlue,
                onTap: () => onTypeSelected('video'),
              ),
              12.horizSpacing,
              _TypeCard(
                icon: Icons.photo_outlined,
                label: 'Gallery',
                color: AppColors.yfdGreenPure,
                onTap: () => onTypeSelected('gallery'),
              ),
              12.horizSpacing,
              _TypeCard(
                icon: Icons.edit_outlined,
                label: 'Text',
                color: AppColors.yfdPrimary,
                onTap: () => onTypeSelected('text'),
              ),
            ],
          ),
        ),
        16.vertSpacing,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.yfdPrimary),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: InkWell(
                onTap: () => onTypeSelected('form'),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'To use my feedback form ',
                      style: 12.w400.copyWith(color: AppColors.yfdDarkGrey03),
                    ),
                    Text(
                      'Click here',
                      style: 12.w600.copyWith(color: AppColors.yfdPrimary),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _TypeCard extends StatelessWidget {
  const _TypeCard({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: AppColors.yfdGrey06,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: AppColors.yfdGrey04,
            ),
          ),
          child: Column(
            children: [
              Icon(
                icon,
                color: color,
                size: 24,
              ),
              8.vertSpacing,
              Text(
                label,
                style: 12.w500.copyWith(color: AppColors.yfdLightGrey08),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
