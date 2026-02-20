import 'package:feedback_to_vfd/core/helpers/extensions/num_extension.dart';
import 'package:feedback_to_vfd/core/utils/ui_component_exports.dart';
import 'package:feedback_to_vfd/shared/configs/theme/colors.dart';
import 'package:feedback_to_vfd/shared/configs/theme/dimens.dart';
import 'package:feedback_to_vfd/shared/configs/theme/strings.dart';

class AppTheme {
  AppTheme._init();
  static final AppTheme instance = AppTheme._init();

  final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSeed(
      brightness: Brightness.dark,
      seedColor: AppColors.yfdPrimary,
    ),
    scaffoldBackgroundColor: AppColors.yfdGrey06,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.yfdGrey10PercentTransparent,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: AppColors.yfdPrimary,
      unselectedItemColor: AppColors.yfdLightGrey06,
      selectedLabelStyle: 12.w900,
      unselectedLabelStyle: 12.w400,
      showSelectedLabels: true,
      showUnselectedLabels: true,
    ),
    textTheme: TextTheme(
      headlineLarge: AppDimens.biggestHeading3.w700,
      headlineMedium: AppDimens.biggestHeading2.w700,
      headlineSmall: AppDimens.biggestHeading.w700,
      bodyLarge: AppDimens.bigHeading.w700,
      bodyMedium: AppDimens.headingTextSize.w600,
      bodySmall: AppDimens.bodyTextSize.w400,
      labelLarge: AppDimens.labelTextSize.regular,
      labelSmall: AppDimens.smallestTextSize.w400,
    ),
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: 14.w400.copyWith(color: AppColors.yfdLightGrey08),
      hintStyle: 14.w400.copyWith(color: AppColors.yfdLightGrey08),
      outlineBorder: BorderSide(color: AppColors.yfdDarkGrey05),
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      errorMaxLines: 2,
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: AppColors.yfdRed01,
          width: 1.spMin,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: AppColors.yfdRed01,
          width: 1.spMin,
        ),
      ),
      errorStyle: 14.w400.copyWith(color: AppColors.yfdRed01),
      iconColor: AppColors.yfdLightGrey08,
      prefixIconColor: AppColors.yfdLightGrey08,
      prefixStyle: TextStyle(color: AppColors.yfdLightGrey08),
      suffixIconColor: AppColors.yfdLightGrey08,
      suffixStyle: TextStyle(color: AppColors.yfdLightGrey08),
    ),
    dialogTheme: DialogThemeData(
      backgroundColor: AppColors.yfdGrey06,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100.spMin),
          ),
        ),
        backgroundColor: WidgetStatePropertyAll(AppColors.yfdPrimary),
        foregroundColor: WidgetStatePropertyAll(AppColors.yfdWhite),
        elevation: const WidgetStatePropertyAll(0),
        alignment: Alignment.center,
        textStyle: WidgetStatePropertyAll(
          TextStyle(
            fontSize: 16.spMin,
            fontWeight: FontWeight.w500,
            fontFamily: AppStrings.yfdFontFamilyName,
          ),
        ),
      ),
    ),
    scrollbarTheme: ScrollbarThemeData(
      thumbColor: WidgetStatePropertyAll(AppColors.yfdBlue01),
      trackColor: WidgetStatePropertyAll(AppColors.yfdGrey05),
      radius: Radius.circular(4.spMin),
    ),
    bottomSheetTheme: BottomSheetThemeData(
      dragHandleColor: AppColors.yfdPrimary,
      dragHandleSize: Size(64.spMin, 5.spMin),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.yfdGrey06,
      centerTitle: false,
      elevation: 0,
      titleTextStyle: 16.w600,
      iconTheme: const IconThemeData(color: Color(0xFFFFFFFF)),
    ),
  );

  final defaultPinTheme = PinTheme(
    width: 46.spMin,
    height: 46.spMin,
    textStyle: TextStyle(
      fontSize: 20.spMin,
      color: AppColors.yfdGrey06,
      fontWeight: FontWeight.w600,
    ),
    decoration: BoxDecoration(
      border: Border.all(color: AppColors.yfdGrey05),
      borderRadius: BorderRadius.circular(8),
    ),
  );

  static bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  static bool _assetExists(String assetPath) {
    try {
      Image.asset(assetPath);
      return true;
    } catch (e) {
      // If an error occurs, the asset does not exist
      return false;
    }
  }

  static String getAsset(BuildContext context, String assetName) {
    final name = assetName.split('/').last;

    final dark = 'assets/svg/dark/$name';
    final light = 'assets/svg/light/$name';
    assert(_assetExists(dark), '$assetName does not exist');
    assert(_assetExists(light), '$assetName does not exist');
    if (isDarkMode(context)) {
      return dark;
    } else {
      return light;
    }
  }
}
