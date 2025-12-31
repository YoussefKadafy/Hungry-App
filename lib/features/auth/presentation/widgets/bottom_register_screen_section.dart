part of '../auth.dart';

class BottomRegisterScreenSection extends StatelessWidget {
  const BottomRegisterScreenSection({
    super.key,
    required this.availableSpace,
    required this.bottomInset,
    required this.confirmPasswordController,
    required this.userNameController,
    required this.emailController,
    required this.passwordController,
    required GlobalKey<FormState> formKey,
  }) : _formKey = formKey;

  final double availableSpace;
  final double bottomInset;
  final TextEditingController confirmPasswordController;
  final TextEditingController userNameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final GlobalKey<FormState> _formKey;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
          color: AppColors.primaryColor,
        ),
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: availableSpace),
            child: IntrinsicHeight(
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, bottomInset),
                child: Column(
                  children: [
                    32.height,
                    RegisterTextFieldsSection(
                      confirmPasswordController: confirmPasswordController,
                      userNameController: userNameController,
                      emailController: emailController,
                      passwordController: passwordController,
                    ),
                    24.height,
                    Padding(
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
                    ),

                    Spacer(),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomText(
                          text: LocaleKeys.alreadyHaveAccount.tr(),
                          color: Colors.white,
                          fontSize: 16,
                        ),
                        8.width,
                        GestureDetector(
                          onTap: () {
                            context.pushReplacementNamed(AppRoutes.login);
                          },
                          child: CustomText(
                            text: LocaleKeys.logIn.tr(),
                            color: AppColors.secondaryColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    24.height,
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
