part of '../auth.dart';

class LoginBlocSection extends StatelessWidget {
  const LoginBlocSection({
    super.key,
    required GlobalKey<FormState> formKey,
    required this.emailController,
    required this.passwordController,
  }) : _formKey = formKey;

  final GlobalKey<FormState> _formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthLoading) {
            showLoadingDialog(context);
          }

          if (state is AuthError) {
            Navigator.pop(context);
            showCustomSnackBar(context, state.message);
          }
          if (state is AuthSuccess) {
            Navigator.pop(context);
            context.pushReplacementNamed(AppRoutes.rootScreen);
          }
        },
        builder: (context, state) {
          return CustomAuthButton(
            text: LocaleKeys.logIn.tr(),
            borderColor: Colors.white,
            textColor: AppColors.black,
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                context.read<AuthCubit>().login(
                  email: emailController.text,
                  password: passwordController.text,
                );
              }
            },
          );
        },
      ),
    );
  }
}
