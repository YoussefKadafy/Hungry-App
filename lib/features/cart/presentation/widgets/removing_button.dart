import 'package:flutter/material.dart';
import 'package:hungry/core/consts/app_colors.dart';

class RemovingButton extends StatelessWidget {
  const RemovingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 154,
      height: 43,
      decoration: BoxDecoration(
        color: AppColors.lightGrey,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.primaryColor),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Removing',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryColor,
            ),
          ),
          SizedBox(width: 10),
          SizedBox(
            width: 18,
            height: 18,
            child: CircularProgressIndicator(
              strokeWidth: 2.2,
              color: AppColors.primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
