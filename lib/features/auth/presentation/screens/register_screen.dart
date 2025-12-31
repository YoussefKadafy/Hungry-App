part of '../auth.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final TextEditingController confirmPasswordController;
  late final TextEditingController userNameController;

  bool _tapWasOnEditable = false;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    userNameController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    userNameController.dispose();
    super.dispose();
  }

  bool _isTapOnEditable(BuildContext context, TapDownDetails details) {
    final hit = HitTestResult();

    var position = details.globalPosition;
    WidgetsBinding.instance.hitTestInView(
      hit,
      position,
      WidgetsBinding.instance.platformDispatcher.implicitView!.viewId,
    );
    for (final entry in hit.path) {
      final target = entry.target;
      final t = target.runtimeType.toString();
      if (t.contains('RenderEditable') || t.contains('EditableText')) {
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final topLogoSpace = screenHeight / 7;
    final bottomLogoSpace = screenHeight / 7;
    final usedSpace = topLogoSpace + bottomLogoSpace + 84.h;
    final availableSpace = screenHeight - usedSpace;
    final bottomInset = MediaQuery.of(context).viewPadding.bottom;

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTapDown: (details) {
        // capture whether the tap was on an editable widget
        _tapWasOnEditable = _isTapOnEditable(context, details);
      },
      onTap: () {
        // only unfocus if user tapped outside editable area
        if (!_tapWasOnEditable) {
          final currentFocus = FocusScope.of(context);
          if (currentFocus.hasFocus && currentFocus.focusedChild != null) {
            currentFocus.unfocus();
          }
        }
        // reset flag
        _tapWasOnEditable = false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: AppColors.white,
        body: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: topLogoSpace),
              SvgPicture.asset(
                AppAssets.logo,
                colorFilter: ColorFilter.mode(
                  AppColors.primaryColor,
                  BlendMode.srcIn,
                ),
              ),
              24.height,
              Wrap(
                children: [
                  CustomText(
                    fontSize: 18,
                    text: LocaleKeys.welcomeToOurApp.tr(),
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.bold,
                    textAlign: TextAlign.center,
                  ),
                  CustomText(text: ' , ', fontSize: 18),
                  CustomText(
                    fontSize: 18,
                    text: LocaleKeys.signUp.tr(),
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.bold,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              SizedBox(height: topLogoSpace),
              Expanded(
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
                                confirmPasswordController:
                                    confirmPasswordController,
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
                                      showCustomSnackBar(
                                        context,
                                        state.message,
                                      );
                                    }
                                    if (state is AuthSuccess) {
                                      context.pushReplacementNamed(
                                        AppRoutes.rootScreen,
                                      );
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
                                      context.pushReplacementNamed(
                                        AppRoutes.login,
                                      );
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
