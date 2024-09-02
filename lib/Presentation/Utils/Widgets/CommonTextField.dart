import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CommonTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? label;
  final String? hintText;
  final TextInputType? inputType;
  final int? maxLines;
  final int? maxLength;
  final bool isRequired;
  final bool isOnlyDigit;
  final bool? enabled;
  final bool readOnly;
  final TextInputAction? textInputAction;
  final void Function(String)? onEditComplete;
  final double? height;
  final dynamic prefixIcon;
  final bool? filled;
  final dynamic fillColor;

  const CommonTextField({
    this.controller,
    this.label,
    this.hintText,
    this.inputType,
    this.maxLines,
    this.maxLength,
    this.isRequired = true,
    this.isOnlyDigit = false,
    this.enabled,
    this.textInputAction,
    this.onEditComplete,
    this.height,
    this.readOnly = false,
    Key? key,
    this.prefixIcon,
    this.filled,
    this.fillColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onEditComplete,
      textInputAction: textInputAction,
      keyboardType: inputType,
      controller: controller,
      // cursorColor: ColorConstant.maingreen,
      enabled: enabled,
      style: TextStyle(fontSize: Adaptive.sp(16)),
      readOnly: readOnly,
      inputFormatters: [
        // Use FilteringTextInputFormatter.digitsOnly to allow only digits
        isOnlyDigit
            ? FilteringTextInputFormatter.digitsOnly
            : FilteringTextInputFormatter.allow(RegExp(r'.*')),
      ],
      validator: isRequired
          ? (value) {
              if (value == null || value.isEmpty) {
                return 'Please fill this field';
              }
              return null;
            }
          : null,
      decoration: InputDecoration(
          filled: filled,
          fillColor: fillColor,
          prefixIcon: prefixIcon,
          counterText: "",
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey.shade400,
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 8, vertical: 7),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7),
            borderSide: BorderSide(color: Colors.grey.shade400),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7),
            // borderSide: const BorderSide(color: ColorConstant.maingreen),
          ),
          label: label != null
              ? RichText(
                  text: TextSpan(
                      text: label!,
                      style: TextStyle(
                          color: Colors.black, fontSize: Adaptive.sp(16)),
                      children: [
                        TextSpan(
                            text: isRequired ? ' *' : "",
                            style: TextStyle(
                              color: Colors.red,
                            ))
                      ]),
                )
              : null,
          hintText: hintText,
          hintStyle: TextStyle(fontSize: Adaptive.sp(16))),
      maxLines: maxLines ?? 1,
      maxLength: maxLength,
      autocorrect: false,
    );
  }
}
