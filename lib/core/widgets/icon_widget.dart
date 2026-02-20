import 'package:feedback_to_vfd/core/utils/ui_component_exports.dart';
import 'package:feedback_to_vfd/shared/configs/theme/colors.dart';

class IconWidget extends StatelessWidget {
  const IconWidget({
    required this.iconPath,
    this.color,
    this.iconBorderRadius = 10,
    this.borderColor,
    this.iconColor,
    super.key,
  });

  final String iconPath;
  final Color? color;
  final double iconBorderRadius;
  final Color? borderColor;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color ?? AppColors.yfdGrey06,
        borderRadius: BorderRadius.circular(iconBorderRadius),
        border: (borderColor != null)
            ? Border.all(color: borderColor ?? AppColors.yfdLightGrey06)
            : null,
      ),
      child: SvgPicture.asset(
        iconPath,
        colorFilter: ColorFilter.mode(
          iconColor ?? AppColors.yfdLightGrey06,
          BlendMode.srcIn,
        ),
      ),
    );
  }
}
