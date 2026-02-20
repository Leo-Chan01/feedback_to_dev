import 'dart:ui';

import 'package:feedback_to_vfd/core/helpers/handlers/share_type_enums.dart';
import 'package:feedback_to_vfd/core/utils/ui_component_exports.dart';
import 'package:feedback_to_vfd/shared/configs/app_enum.dart';
import 'package:feedback_to_vfd/shared/configs/theme/colors.dart';
import 'package:feedback_to_vfd/shared/widgets/global_snackbar.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';

Future<DialogActionEnum> showyfdBottomSheet(
  BuildContext appContext, {
  required Widget child,
}) async {
  return showModalBottomSheet<DialogActionEnum>(
    context: appContext,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return child;
    },
  ).then((value) => value ?? DialogActionEnum.none);
}

Future<DialogActionEnum> showyfdDialog(
  BuildContext appContext, {
  required Widget child,
  Color? backgroundColor,
  bool shouldBlur = false,
  bool backgroundDismiss = true,
}) async {
  backgroundColor ??= AppColors.yfdLightGrey11;
  return showDialog<DialogActionEnum>(
    context: appContext,
    barrierDismissible: backgroundDismiss,
    builder: (context) {
      if (shouldBlur) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Dialog(
            backgroundColor: backgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: child,
          ),
        );
      }
      return Dialog(
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: child,
      );
    },
  ).then((value) => value ?? DialogActionEnum.none);
}

Future<void> shareContent(
  BuildContext context,
  ContentShareType shareType, {
  String? content,
  String? subject,
  XFile? file,
}) async {
  final sharePlusInstance = SharePlus.instance;
  switch (shareType) {
    case ContentShareType.text:
      if (content != null) {
        // await sharePlusInstance.share(content, subject: subject);
        await sharePlusInstance.share(
          ShareParams(text: content, title: subject, subject: subject),
        );
      }
    case ContentShareType.regularLink:
      if (content != null) {
        await sharePlusInstance.share(
          ShareParams(text: content, title: subject, subject: subject),
        );
      }
    case ContentShareType.file:
      if (file != null) {
        await sharePlusInstance.share(
          ShareParams(
            subject: file.name,
            files: [file],
            previewThumbnail: file,
          ),
        );
      }
    case ContentShareType.videoFile:
      if (file != null) {
        await sharePlusInstance.share(
          ShareParams(
            subject: file.name,
            files: [file],
            previewThumbnail: file,
          ),
        );
      }

    case ContentShareType.audioFile:
      if (file != null) {
        await sharePlusInstance.share(
          ShareParams(
            subject: file.name,
            files: [file],
            previewThumbnail: file,
          ),
        );
      }
    case ContentShareType.referralLink:
      if (content != null) {
        await sharePlusInstance.share(
          ShareParams(text: content, title: subject, subject: subject),
        );
      }
    case ContentShareType.videoLink:
      if (content != null) {
        await sharePlusInstance.share(
          ShareParams(text: content, title: subject, subject: subject),
        );
      }
    case ContentShareType.none:
      // No action needed for none type
      break;
  }
}

Future<void> copyContent(BuildContext context, String content) async {
  await Clipboard.setData(ClipboardData(text: content));
  if (!context.mounted) return;
  GlobalSnackBar.showSuccess('Copied to Clipboard Successfully');
}
