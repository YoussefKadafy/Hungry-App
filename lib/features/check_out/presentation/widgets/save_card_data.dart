import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hungry/core/consts/app_colors.dart';

class SaveCardData extends StatelessWidget {
  const SaveCardData({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          fillColor: WidgetStatePropertyAll(AppColors.primaryColor),
          value: true,
          onChanged: (value) {},
        ),
        Text(
          'Save card details for future payments',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.textFieldDisabledHintColor,
          ),
        ),
      ],
    );
  }
}
