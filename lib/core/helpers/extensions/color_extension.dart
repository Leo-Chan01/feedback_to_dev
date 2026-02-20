import 'package:feedback_to_vfd/shared/configs/theme.dart';
import 'package:feedback_to_vfd/shared/configs/theme/colors.dart';
import 'package:flutter/material.dart';

extension ColorExtension on Color {
  Color of(
    BuildContext context, {
    Color? dark,
  }) {
    final contrast = AppColors.contrastColor(this);
    if (AppTheme.isDarkMode(context)) {
      return dark ?? contrast;
    }
    return this;
  }
}
