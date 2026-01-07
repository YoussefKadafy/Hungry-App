import 'package:flutter/material.dart';
import 'package:hungry/core/consts/app_assets.dart';
import 'package:lottie/lottie.dart';

class LoadingStateWidget extends StatelessWidget {
  const LoadingStateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 120,
        width: 120,
        child: Center(
          child: LottieBuilder.asset(
            AppAssets.lottieLoader,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
