import 'package:flutter/material.dart';
import 'package:hungry/core/consts/app_assets.dart';
import 'package:hungry/core/consts/app_colors.dart';
import 'package:hungry/core/shared/custom_text.dart';
import 'package:hungry/core/utils/sized_box_extension.dart';
import 'package:lottie/lottie.dart';

class EmptyStateWidget extends StatelessWidget {
  const EmptyStateWidget({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          88.height,
          CustomText(text: text, fontSize: 24, color: AppColors.primaryColor),
          Expanded(child: LottieBuilder.asset(AppAssets.lottieEmpty)),
          24.height,
        ],
      ),
    );
  }
}
