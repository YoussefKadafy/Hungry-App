import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hungry/core/consts/app_colors.dart';
import 'package:hungry/core/utils/sized_box_extension.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.height = 70,
    this.width = 200,
    required this.text,
    this.onTap,
    this.iconData,
    this.textColor,
    this.backgroundColor,
  });
  final double width, height;
  final String text;
  final void Function()? onTap;
  final Widget? iconData;
  final Color? textColor, backgroundColor;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),

      child: Container(
        height: height.h,
        width: width.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          color: backgroundColor ?? AppColors.primaryColor,
        ),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              text,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: textColor ?? Colors.white,
              ),
            ),
            8.width,
            iconData ?? const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
