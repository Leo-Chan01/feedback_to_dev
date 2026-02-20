import 'package:feedback_to_vfd/core/helpers/extensions/num_extension.dart';
import 'package:feedback_to_vfd/core/utils/ui_component_exports.dart';
import 'package:feedback_to_vfd/shared/configs/theme/colors.dart';

class MediaUploadWidget extends StatelessWidget {
  const MediaUploadWidget({
    required this.type, super.key,
  });

  final String type;

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
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                type == 'video' ? 'Upload Video' : 'Add Screenshots',
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
          Container(
            height: 120.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.yfdBackgrundColor,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: AppColors.yfdGrey04,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  type == 'video'
                      ? Icons.movie_outlined
                      : Icons.add_photo_alternate_outlined,
                  color: AppColors.yfdPrimary,
                  size: 40.w,
                ),
                12.vertSpacing,
                Text(
                  'Tap to browse files',
                  style: 12.w500.copyWith(color: AppColors.yfdLightGrey08),
                ),
                4.vertSpacing,
                Text(
                  type == 'video' ? 'Max size: 50MB' : 'PNG, JPG up to 10MB',
                  style: 10.w400.copyWith(color: AppColors.yfdDarkGrey03),
                ),
              ],
            ),
          ),
          24.vertSpacing,
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
                'Upload',
                style: 14.bold.copyWith(color: AppColors.yfdWhite),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
