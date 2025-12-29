import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hungry/core/consts/app_colors.dart';
import 'package:hungry/core/shared/custom_text_field.dart';
import 'package:hungry/core/translations/locale_keys.g.dart';
import 'package:hungry/core/utils/sized_box_extension.dart';

class LoginTextFieldsSection extends StatefulWidget {
  const LoginTextFieldsSection({
    super.key,
    required this.emailController,
    required this.passwordController,
  });
  final TextEditingController emailController;
  final TextEditingController passwordController;
  @override
  State<LoginTextFieldsSection> createState() => _LoginTextFieldsSectionState();
}

class _LoginTextFieldsSectionState extends State<LoginTextFieldsSection> {
  bool isPasswordVisible = true;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          CustomTextField(
            controller: widget.emailController,
            labelText: LocaleKeys.email.tr(),
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return LocaleKeys.emailIsRequired.tr();
              }
              if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                return LocaleKeys.enterValidEmail.tr();
              }
              return null;
            },
          ),
          16.height,
          CustomTextField(
            controller: widget.passwordController,
            labelText: LocaleKeys.password.tr(),
            obscureText: isPasswordVisible,
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  isPasswordVisible = !isPasswordVisible;
                });
              },
              icon: Icon(
                isPasswordVisible ? Icons.visibility_off : Icons.visibility,
                color: AppColors.white,
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return LocaleKeys.passwordIsRequired.tr();
              }
              if (value.length < 6) {
                return LocaleKeys.enterValidPassword.tr();
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}
