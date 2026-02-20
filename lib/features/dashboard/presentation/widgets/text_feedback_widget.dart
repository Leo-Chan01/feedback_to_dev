import 'package:feedback_to_vfd/core/helpers/extensions/num_extension.dart';
import 'package:feedback_to_vfd/core/utils/ui_component_exports.dart';
import 'package:feedback_to_vfd/shared/configs/theme/colors.dart';

class TextFeedbackWidget extends StatefulWidget {
  const TextFeedbackWidget({super.key});

  @override
  State<TextFeedbackWidget> createState() => _TextFeedbackWidgetState();
}

class _TextFeedbackWidgetState extends State<TextFeedbackWidget> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.yfdGrey06,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: AppColors.yfdGrey04,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Text Feedback',
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
          16.vertSpacing,
          TextField(
            controller: _controller,
            maxLines: 4,
            style: 14.w400.copyWith(color: AppColors.yfdWhite),
            decoration: InputDecoration(
              hintText: 'What would you like to tell us?',
              hintStyle: 14.w400.copyWith(color: AppColors.yfdLightGrey10),
              filled: true,
              fillColor: AppColors.yfdBackgrundColor,
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
          20.vertSpacing,
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.yfdPrimary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
                padding: EdgeInsets.symmetric(vertical: 16.h),
                elevation: 0,
              ),
              child: Text(
                'Submit',
                style: 14.bold.copyWith(color: AppColors.yfdWhite),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
