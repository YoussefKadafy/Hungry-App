import 'package:flutter/material.dart';
import 'package:hungry/core/consts/app_colors.dart';
import 'package:hungry/core/shared/custom_text.dart';

class CustomListViewItem extends StatelessWidget {
  const CustomListViewItem({
    super.key,
    required this.onPressed,
    required this.text,
    required this.isSelected,
  });
  final void Function() onPressed;
  final String text;
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        backgroundColor: isSelected
            ? AppColors.primaryColor
            : AppColors.lightGrey,

        side: BorderSide(
          color: isSelected ? AppColors.primaryColor : AppColors.lightGrey,
        ),
      ),
      child: CustomText(
        text: text,
        fontSize: 16,

        color: isSelected ? AppColors.white : AppColors.black,
      ),
    );
  }
}
