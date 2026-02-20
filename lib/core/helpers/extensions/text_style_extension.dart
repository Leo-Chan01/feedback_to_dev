import 'package:feedback_to_vfd/shared/configs/theme.dart';
import 'package:feedback_to_vfd/shared/configs/theme/colors.dart';
import 'package:flutter/material.dart';

extension TextStyleExtension on TextStyle {
  TextStyle get underline {
    return copyWith(decoration: TextDecoration.underline);
  }

  TextStyle get shadow {
    return copyWith(
      shadows: [
        const BoxShadow(
          offset: Offset(1, 1),
          blurRadius: 10,
        ),
      ],
    );
  }

  TextStyle of(
    BuildContext context, {
    required Color light,
    Color? dark,
  }) {
    if (AppTheme.isDarkMode(context)) {
      final contrast = AppColors.contrastColor(light);
      return copyWith(
        color: dark ?? contrast,
      );
    }
    return copyWith(color: light);
  }
}
