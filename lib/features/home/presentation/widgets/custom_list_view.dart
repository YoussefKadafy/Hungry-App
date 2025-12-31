import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hungry/core/consts/app_colors.dart';
import 'package:hungry/core/shared/custom_text.dart';
import 'package:hungry/features/home/presentation/cubit/category_cubit.dart';

class CustomListViewItem extends StatelessWidget {
  const CustomListViewItem({
    super.key,
    required this.text,
    required this.isSelected,
    required this.index,
  });
  final String text;
  final int index;
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        context.read<CategoryCubit>().selectCategory(index);
      },
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
