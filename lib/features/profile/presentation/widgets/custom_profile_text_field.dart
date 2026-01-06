import 'package:flutter/material.dart';
import 'package:hungry/core/consts/app_colors.dart';

class CustomProfileTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String? labelText;
  final TextInputType keyboardType;
  final bool obscureText;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool readOnly;
  final bool autofocus;
  final int maxLines;
  final double borderRadius;
  final Color? textColor;

  const CustomProfileTextField({
    super.key,
    this.controller,
    this.hintText,
    this.labelText,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.validator,
    this.onChanged,
    this.onTap,
    this.prefixIcon,
    this.suffixIcon,
    this.readOnly = false,
    this.autofocus = false,
    this.maxLines = 1,
    this.borderRadius = 8,
    this.textColor,
  });

  @override
  State<CustomProfileTextField> createState() => _CustomProfileTextFieldState();
}

class _CustomProfileTextFieldState extends State<CustomProfileTextField> {
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    // Listen to focus changes
    _focusNode.addListener(() {
      setState(() {}); // Rebuild to update label color
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  InputBorder _buildBorder(Color color, {double width = 1}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(widget.borderRadius),
      borderSide: BorderSide(color: color, width: width),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isFocused = _focusNode.hasFocus;

    return TextFormField(
      focusNode: _focusNode,
      cursorColor: AppColors.black,
      style: const TextStyle(color: AppColors.black),
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      obscureText: widget.obscureText,
      validator: widget.validator,
      onChanged: widget.onChanged,
      onTap: widget.onTap,
      readOnly: widget.readOnly,
      autofocus: widget.autofocus,
      maxLines: widget.maxLines,
      decoration: InputDecoration(
        hintText: widget.hintText,
        labelText: widget.labelText,
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.suffixIcon,

        labelStyle: TextStyle(
          color: isFocused ? AppColors.primaryColor : AppColors.grey,
        ),

        hintStyle: TextStyle(color: widget.textColor ?? AppColors.white),

        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),

        border: _buildBorder(AppColors.textFieldBorderColor),
        enabledBorder: _buildBorder(AppColors.black),
        focusedBorder: _buildBorder(AppColors.black, width: 2),
        disabledBorder: _buildBorder(AppColors.textFieldDisabledHintColor),
        errorBorder: _buildBorder(Colors.red),
        focusedErrorBorder: _buildBorder(Colors.red, width: 2),
      ),
    );
  }
}
