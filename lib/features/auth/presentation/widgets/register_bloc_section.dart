part of '../auth.dart';

class RegisterBlocSection extends StatelessWidget {
  const RegisterBlocSection({
    super.key,
    required GlobalKey<FormState> formKey,
    required this.userNameController,
    required this.emailController,
    required this.passwordController,
  }) : _formKey = formKey;

  final GlobalKey<FormState> _formKey;
  final TextEditingController userNameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthError) {
            showCustomSnackBar(context, state.message);
          }
          if (state is AuthSuccess) {
            context.pushReplacementNamed(AppRoutes.rootScreen);
          }
        },
        builder: (context, state) {
          return CustomAuthButton(
            textColor: AppColors.black,
            borderColor: AppColors.white,
            text: LocaleKeys.signUp.tr(),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                context.read<AuthCubit>().register(
                  name: userNameController.text,
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
