import 'package:flutter/material.dart';

void showLoadingDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => const Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Center(child: CircularProgressIndicator()),
    ),
  );
}
