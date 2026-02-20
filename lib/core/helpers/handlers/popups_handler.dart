import 'package:feedback_to_vfd/core/helpers/extensions/num_extension.dart';
import 'package:feedback_to_vfd/core/utils/ui_component_exports.dart';
import 'package:feedback_to_vfd/shared/configs/theme/colors.dart';

Future<void> yfdPopupDialog(
  BuildContext context,
  String? title,
  Widget? body, {
  bool titleIsWidget = false,
  Widget titleWidget = const SizedBox.shrink(),
}) async {
  await showDialog<void>(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: AppColors.yfdSecondaryDark,
        title: titleIsWidget
            ? titleWidget
            : Text(
                title ?? 'Alert',
                style: 16.w500,
              ),
        content: body,
      );
    },
  );
}
