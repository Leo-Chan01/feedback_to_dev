// ignore_for_file: avoid_bool_literals_in_conditional_expressions, omit_local_variable_types, prefer_final_locals, lines_longer_than_80_chars

import 'package:feedback_to_vfd/core/helpers/extensions/num_extension.dart';
import 'package:feedback_to_vfd/shared/configs/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class YFDTextInput extends StatefulWidget {
  const YFDTextInput({
    super.key,
    this.controller,
    this.titleTextStyle,
    this.text,
    this.focusNode,
    this.keyboardType,
    this.onValidated,
    this.textInputAction,
    this.hasValidated,
    this.readOnly = false,
    this.autofocus = false,
    this.obscuringCharacter = '•',
    this.obscureText = false,
    this.enableSuggestions = true,
    this.maxLines = 1,
    this.minLines,
    this.isPinput = false,
    this.isPhone = false,
    this.expands = false,
    this.maxLength,
    this.onChanged,
    this.onEditingComplete,
    this.onSubmitted,
    this.enabled,
    this.onTap,
    this.onTapOutside,
    this.prefixIcon,
    this.hintText,
    this.labelText,
    this.suffixIcon,
    this.titleRight,
    this.validator,
    this.textCapitalization = TextCapitalization.none,
    this.autovalidateMode,
    this.hintStyle,
    this.style,
    this.fillColor,
    this.isFiat = false,
    this.useDefaultContentPadding = false,
    this.inputBorder,
    this.inputFormatters,
    this.floatingLabelBehavior = FloatingLabelBehavior.always,
  });

  const YFDTextInput.buyFiat({
    required this.hasValidated,
    super.key,
    this.controller,
    this.text,
    this.focusNode,
    this.keyboardType,
    this.textInputAction,
    this.onValidated,
    this.readOnly = false,
    this.autofocus = false,
    this.isPhone = false,
    this.isPinput = false,
    this.obscuringCharacter = '•',
    this.obscureText = false,
    this.enableSuggestions = true,
    this.maxLines = 1,
    this.minLines,
    this.expands = false,
    this.maxLength,
    this.onChanged,
    this.onEditingComplete,
    this.onSubmitted,
    this.enabled,
    this.onTap,
    this.onTapOutside,
    this.prefixIcon,
    this.hintText,
    this.labelText,
    this.suffixIcon,
    this.titleRight,
    this.validator,
    this.textCapitalization = TextCapitalization.none,
    this.autovalidateMode,
    this.hintStyle,
    this.style,
    this.fillColor,
    this.isFiat = true,
    this.useDefaultContentPadding = false,
    this.inputBorder,
    this.inputFormatters,
    this.titleTextStyle,
    this.floatingLabelBehavior = FloatingLabelBehavior.always,
  });

  const YFDTextInput.phone({
    required this.hasValidated,
    super.key,
    this.controller,
    this.text,
    this.focusNode,
    this.keyboardType,
    this.textInputAction,
    this.onValidated,
    this.readOnly = false,
    this.autofocus = false,
    this.isPinput = false,
    this.obscuringCharacter = '•',
    this.obscureText = false,
    this.enableSuggestions = true,
    this.maxLines = 1,
    this.minLines,
    this.expands = false,
    this.maxLength,
    this.onChanged,
    this.onEditingComplete,
    this.onSubmitted,
    this.enabled,
    this.onTap,
    this.titleTextStyle,
    this.onTapOutside,
    this.prefixIcon,
    this.hintText,
    this.labelText,
    this.suffixIcon,
    this.titleRight,
    this.validator,
    this.textCapitalization = TextCapitalization.none,
    this.autovalidateMode,
    this.hintStyle,
    this.style,
    this.fillColor,
    this.isFiat = true,
    this.isPhone = true,
    this.useDefaultContentPadding = false,
    this.inputBorder,
    this.inputFormatters,
    this.floatingLabelBehavior = FloatingLabelBehavior.always,
  });

  const YFDTextInput.pin({
    super.key,
    this.controller,
    this.focusNode,
    this.keyboardType,
    this.textInputAction,
    this.readOnly = false,
    this.autofocus = false,
    this.isPinput = true,
    this.obscuringCharacter = '•',
    this.obscureText = false,
    this.enableSuggestions = true,
    this.maxLines = 1,
    this.minLines,
    this.text,
    this.titleTextStyle,
    this.expands = false,
    this.maxLength,
    this.onChanged,
    this.onEditingComplete,
    this.onSubmitted,
    this.enabled,
    this.onTap,
    this.onTapOutside,
    this.prefixIcon,
    this.hintText,
    this.labelText,
    this.isFiat = false,
    this.isPhone = false,
    this.suffixIcon,
    this.titleRight,
    this.onValidated,
    this.validator,
    this.textCapitalization = TextCapitalization.none,
    this.autovalidateMode,
    this.hintStyle,
    this.style,
    this.hasValidated,
    this.fillColor,
    this.useDefaultContentPadding = false,
    this.inputBorder,
    this.inputFormatters,
    this.floatingLabelBehavior = FloatingLabelBehavior.always,
  });

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextStyle? titleTextStyle;
  final bool readOnly;
  final bool isPinput;
  final bool? hasValidated;
  final FloatingLabelBehavior floatingLabelBehavior;
  final bool autofocus;
  final String obscuringCharacter;
  final String? text;
  final bool obscureText;
  final bool enableSuggestions;
  final int? maxLines;
  final int? minLines;
  final bool expands;
  final int? maxLength;
  final void Function(String)? onChanged;
  final void Function()? onEditingComplete;
  final void Function(String)? onSubmitted;
  final void Function()? onValidated;
  final bool? enabled;
  final void Function()? onTap;
  final void Function(PointerDownEvent)? onTapOutside;
  final Widget? prefixIcon;
  final String? hintText;
  final String? labelText;
  final Widget? suffixIcon;
  final Widget? titleRight;
  final String? Function(String?)? validator;
  final TextCapitalization textCapitalization;
  final AutovalidateMode? autovalidateMode;
  final TextStyle? hintStyle;
  final TextStyle? style;
  final Color? fillColor;
  final bool useDefaultContentPadding;
  final bool isFiat;
  final bool isPhone;
  final InputBorder? inputBorder;
  final List<TextInputFormatter>? inputFormatters;

  @override
  State<YFDTextInput> createState() => _YFDTextInputState();
}

class _YFDTextInputState extends State<YFDTextInput> {
  @override
  Widget build(BuildContext context) {
    if (widget.isFiat) {
      bool showError =
          widget.hasValidated == true &&
          widget.validator?.call(widget.controller?.text) != null;
      bool showPhoneError =
          widget.hasValidated == true &&
          widget.validator?.call(widget.controller?.text) != null &&
          widget.isPhone;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.text != null) ...[
            Text(
              widget.text!,
              style:
                  widget.titleTextStyle ??
                  16.w600.copyWith(
                    color: showError
                        ? AppColors.yfdRed01
                        : AppColors.yfdGrey03,
                  ),
            ),
            const SizedBox(height: 2),
          ],
          Row(
            children: [
              if (widget.isPhone) ...[
                Expanded(
                  child: Theme(
                    data: ThemeData(),
                    child: TextFormField(
                      readOnly: true,
                      controller: widget.controller,
                      keyboardType: widget.keyboardType,
                      inputFormatters: widget.inputFormatters,
                      cursorErrorColor: AppColors.yfdRed01,
                      onChanged: widget.onChanged,
                      onTap: widget.onTap,
                      onTapOutside: widget.onTapOutside,
                      decoration: InputDecoration(
                        fillColor: AppColors.yfdRedFill,
                        filled: showError ? true : false,
                        errorStyle: 12.w500.copyWith(
                          color: AppColors.yfdRed01,
                        ),
                        suffixIcon: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // SvgPicture.asset(
                            //   AppSvg.nigerianFlag,
                            // ),
                            5.horizSpacing,
                            Text(
                              '+234',
                              style: 16.w400.copyWith(
                                color: AppColors.yfdGrey06,
                              ),
                            ),
                          ],
                        ),
                        error: showPhoneError ? const SizedBox.shrink() : null,
                        suffix: 16.horizSpacing,
                        prefix: 16.horizSpacing,
                        contentPadding: EdgeInsets.zero,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColors.yfdGrey05,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColors.yfdRed01,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColors.yfdRed01,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                ),
                6.horizSpacing,
              ],
              Expanded(
                flex: 3,
                child: Theme(
                  data: ThemeData(),
                  child: TextFormField(
                    readOnly: widget.readOnly,
                    controller: widget.controller,
                    focusNode: widget.focusNode,
                    onTap: widget.onTap,
                    onTapOutside: widget.onTapOutside,
                    keyboardType: widget.keyboardType,
                    inputFormatters: widget.inputFormatters,
                    cursorErrorColor: AppColors.yfdRed01,
                    onChanged: widget.onChanged,
                    maxLength: widget.maxLength,
                    maxLines: widget.maxLines,
                    minLines: widget.minLines,
                    decoration: InputDecoration(
                      hintText: widget.hintText,
                      fillColor: AppColors.yfdRedFill,
                      filled: showError ? true : false,
                      errorStyle: 12.w500.copyWith(
                        color: AppColors.yfdRed01,
                      ),
                      suffixIcon: widget.suffixIcon,
                      suffix: 16.horizSpacing,
                      prefix: 16.horizSpacing,
                      contentPadding: EdgeInsets.symmetric(
                        vertical: (widget.maxLines ?? 1) > 1 ? 10 : 0,
                      ),
                      enabledBorder: showPhoneError
                          ? OutlineInputBorder(
                              borderSide: BorderSide(
                                color: showPhoneError
                                    ? AppColors.yfdRed01
                                    : AppColors.yfdGrey05,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            )
                          : null,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: showPhoneError
                              ? AppColors.yfdRed01
                              : AppColors.yfdGrey05,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: showPhoneError
                              ? AppColors.yfdRed01
                              : const Color(0xFF000000),
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.yfdRed01,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.yfdRed01,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      error: showPhoneError ? const SizedBox.shrink() : null,
                    ),
                    autovalidateMode: widget.hasValidated == true
                        ? AutovalidateMode.onUserInteraction
                        : AutovalidateMode.disabled,
                    validator: showPhoneError ? null : widget.validator,
                  ),
                ),
              ),
            ],
          ),
          if (showPhoneError)
            Text(
              widget.validator?.call(widget.controller?.text) ?? '',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: AppColors.yfdRed01,
              ),
            ),
        ],
      );
    }
    return TextFormField(
      inputFormatters: widget.inputFormatters,
      controller: widget.controller,
      focusNode: widget.focusNode,
      textCapitalization: widget.textCapitalization,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      readOnly: widget.readOnly,
      autofocus: widget.autofocus,
      obscuringCharacter: '*',
      obscureText: widget.obscureText,
      enableSuggestions: widget.enableSuggestions,
      maxLength: widget.maxLength,
      maxLines: widget.maxLines,
      minLines: widget.minLines,
      expands: widget.expands,
      onChanged: widget.onChanged,
      onEditingComplete: widget.onEditingComplete,
      onTap: widget.onTap,
      onTapOutside: widget.onTapOutside,
      autovalidateMode: widget.autovalidateMode,
      onFieldSubmitted: widget.onSubmitted,
      enabled: widget.enabled,
      decoration: InputDecoration(
        errorMaxLines: 2,
        floatingLabelBehavior: widget.floatingLabelBehavior,
        fillColor: widget.fillColor,
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.suffixIcon,
        hintText: widget.hintText,
        labelText: widget.labelText,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            width: 1.2,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            width: 1.2,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            width: 1.2,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
