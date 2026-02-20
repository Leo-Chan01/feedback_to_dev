import 'package:feedback_to_vfd/core/utils/ui_component_exports.dart';
import 'package:feedback_to_vfd/core/helpers/extensions/num_extension.dart';
import 'package:feedback_to_vfd/shared/configs/theme/colors.dart';

class WelcomeHeader extends StatelessWidget {
  const WelcomeHeader({
    required this.userName, super.key,
  });

  final String userName;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: AppColors.yfdBackgrundColor,
        border: Border(
          bottom: BorderSide(
            color: AppColors.yfdGrey04,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome back,',
                style: 14.w400.copyWith(color: AppColors.yfdDarkGrey03),
              ),
              4.vertSpacing,
              Text(
                userName,
                style: 24.w700.copyWith(color: AppColors.yfdWhite),
              ),
            ],
          ),
          Container(
            width: 48.w,
            height: 48.w,
            decoration: BoxDecoration(
              color: AppColors.yfdPrimary,
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.yfdWhite.withOpacity(0.2),
                width: 2,
              ),
            ),
            child: Center(
              child: Text(
                userName.isNotEmpty ? userName[0].toUpperCase() : 'U',
                style: 20.bold.copyWith(color: AppColors.yfdWhite),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
