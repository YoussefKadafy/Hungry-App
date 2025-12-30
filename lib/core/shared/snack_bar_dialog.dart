import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';

void snackBarDialog(
  BuildContext context, {
  String? message,
  AnimatedSnackBarType? type,
  String? title,
}) {
  return AnimatedSnackBar.material(
    message ?? 'This a snackbar with info type',
    type: type ?? AnimatedSnackBarType.success,
    borderRadius: BorderRadius.circular(16),

    mobilePositionSettings: const MobilePositionSettings(
      topOnAppearance: 100,
      topOnDissapear: 50,
      bottomOnAppearance: 100,
      bottomOnDissapear: 50,
      left: 20,
      right: 20,
    ),
  ).show(context);
}
