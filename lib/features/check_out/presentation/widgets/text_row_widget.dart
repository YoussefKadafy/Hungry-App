import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hungry/core/consts/app_colors.dart';

class TextRowWidget extends StatelessWidget {
  const TextRowWidget({
    super.key,
    required this.prefixText,
    required this.suffixText,
    this.textColor = AppColors.textFieldDisabledHintColor,
    this.fontWeight = FontWeight.w500,
    this.fontSize,
  });

  final String prefixText, suffixText;
  final Color textColor;
  final FontWeight fontWeight;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    final double size = fontSize?.sp ?? 18.sp;

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          prefixText,
          style: TextStyle(
            fontSize: size,
            fontWeight: fontWeight,
            color: textColor,
          ),
        ),
        Spacer(),
        Text(
          suffixText,
          style: TextStyle(
            fontSize: size,
            fontWeight: fontWeight,
            color: textColor,
          ),
        ),
      ],
    );
  }
}
