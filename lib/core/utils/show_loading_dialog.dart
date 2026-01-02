import 'package:flutter/material.dart';

class ShowLoadingDialog extends StatelessWidget {
  const ShowLoadingDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return const Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Center(child: CircularProgressIndicator()),
    );
  }
}
