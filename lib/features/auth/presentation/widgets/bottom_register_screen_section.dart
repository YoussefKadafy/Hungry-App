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
                    RegisterBlocSection(
                      formKey: _formKey,
                      userNameController: userNameController,
                      emailController: emailController,
                      passwordController: passwordController,
                    ),

                    Spacer(),

                    AlreadyHaveAccountWidget(),
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
