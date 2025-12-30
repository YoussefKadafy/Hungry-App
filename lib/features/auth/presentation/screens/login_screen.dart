// login_screen.dart
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hungry/core/consts/app_assets.dart';
import 'package:hungry/core/consts/app_colors.dart';
import 'package:hungry/core/routing/app_routes.dart';
import 'package:hungry/core/shared/custom_snack_bar.dart';
import 'package:hungry/features/auth/data/repo/auth_repo.dart';
import 'package:hungry/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:hungry/features/auth/presentation/cubit/auth_states.dart';
import 'package:hungry/features/auth/presentation/widgets/custom_auth_button.dart';
import 'package:hungry/core/shared/custom_text.dart';
import 'package:hungry/core/translations/locale_keys.g.dart';
import 'package:hungry/core/utils/sized_box_extension.dart';
import 'package:hungry/features/auth/presentation/widgets/login_text_fields_section.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late final TextEditingController emailController;
  late final TextEditingController passwordController;

  bool _tapWasOnEditable = false;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
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
        _tapWasOnEditable = _isTapOnEditable(context, details);
      },
      onTap: () {
        if (!_tapWasOnEditable) {
          final currentFocus = FocusScope.of(context);
          if (currentFocus.hasFocus && currentFocus.focusedChild != null) {
            currentFocus.unfocus();
          }
        }
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: CustomText(
                  text:
                      '${LocaleKeys.WelcomeBack.tr()}, ${LocaleKeys.loginToContinue.tr()}',
                  textAlign: TextAlign.center,
                  color: AppColors.primaryColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: bottomLogoSpace),
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
                              LoginTextFieldsSection(
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
                                      text: state is AuthLoading
                                          ? 'Logging in...'
                                          : LocaleKeys.logIn.tr(),
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
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: CustomAuthButton(
                                  backgroundColor: Colors.transparent,
                                  borderColor: Colors.white,
                                  textColor: AppColors.white,
                                  text: LocaleKeys.continueAsAGuest.tr(),
                                  onPressed: () {
                                    context.pushReplacementNamed(
                                      AppRoutes.rootScreen,
                                    );
                                  },
                                ),
                              ),

                              Spacer(),

                              SafeArea(
                                bottom: true,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CustomText(
                                      text: LocaleKeys.dontHaveAccount.tr(),
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                    8.width,
                                    GestureDetector(
                                      onTap: () {
                                        context.pushReplacementNamed(
                                          AppRoutes.register,
                                        );
                                      },
                                      child: CustomText(
                                        text: LocaleKeys.signUp.tr(),
                                        color: AppColors.secondaryColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
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
