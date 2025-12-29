import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hungry/core/shared/custom_button.dart';
import 'package:hungry/core/utils/sized_box_extension.dart';

class TotalPriceAndCartWidget extends StatelessWidget {
  final String price;
  final String title;
  final String buttonText;
  final VoidCallback? onPressed;
  final Color? textColor;
  final Widget? iconData;

  const TotalPriceAndCartWidget({
    super.key,
    required this.price,
    this.title = 'Total Price',
    this.buttonText = 'Add to Cart',
    this.onPressed,
    this.textColor,
    this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(end: 16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.only(start: 16.w),
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: textColor ?? Colors.black,
                  ),
                ),
              ),
              8.height,
              Padding(
                padding: EdgeInsetsDirectional.only(start: 16.w),
                child: Text(
                  price,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),

          Align(
            alignment: AlignmentGeometry.topCenter,
            child: CustomButton(
              text: buttonText,
              onTap: onPressed,
              iconData: iconData,
            ),
          ),
        ],
      ),
    );
  }
}
