import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';

void snackBarDialog(
  BuildContext context, {
  String? message,
  AnimatedSnackBarType? type,
}) {
  return AnimatedSnackBar.material(
    message ?? 'This a snackbar with info type',
    type: type ?? AnimatedSnackBarType.success,
    borderRadius: BorderRadius.circular(16),
    duration: const Duration(seconds: 5),
    mobilePositionSettings: const MobilePositionSettings(
      topOnAppearance: 100,
      topOnDissapear: 40,
      bottomOnAppearance: 100,
      bottomOnDissapear: 20,
      left: 20,
      right: 20,
    ),
  ).show(context);
}
