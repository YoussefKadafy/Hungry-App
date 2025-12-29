import 'package:flutter/material.dart';

/// Show a red floating SnackBar with custom padding & margin.
/// Usage: showCustomSnackBar(context, 'My message');
void showCustomSnackBar(
  BuildContext context,
  String message, {
  Duration duration = const Duration(seconds: 3),
  EdgeInsetsGeometry? padding,
  EdgeInsetsGeometry? margin,
  VoidCallback? onClose,
  SnackBarAction? action,
}) {
  final snack = SnackBar(
    behavior: SnackBarBehavior.floating,
    margin:
        margin ?? const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
    padding: padding ?? const EdgeInsets.all(16.0),
    elevation: 8,
    backgroundColor: Colors.red,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    duration: duration,
    content: Row(
      children: [
        Expanded(
          child: Text(
            message,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        if (onClose != null)
          GestureDetector(
            onTap: onClose,
            child: const Padding(
              padding: EdgeInsets.only(left: 12.0),
              child: Icon(Icons.close, color: Colors.white, size: 20),
            ),
          ),
      ],
    ),
    action: action,
  );

  // hide current then show new
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(snack);
}
