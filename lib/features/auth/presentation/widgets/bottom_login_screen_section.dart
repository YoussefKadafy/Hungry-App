part of '../auth.dart';

class BottomLoginScreenSection extends StatelessWidget {
  const BottomLoginScreenSection({
    super.key,
    required this.availableSpace,
    required this.bottomInset,
    required this.emailController,
    required this.passwordController,
    required GlobalKey<FormState> formKey,
  }) : _formKey = formKey;

  final double availableSpace;
  final double bottomInset;
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
                    LoginTextFieldsSection(
                      emailController: emailController,
                      passwordController: passwordController,
                    ),
                    24.height,
                    LoginBlocSection(
                      formKey: _formKey,
                      emailController: emailController,
                      passwordController: passwordController,
                    ),
                    ContineuAsGuestWidget(),

                    Spacer(),

                    DontHaveAccountWidget(),
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
