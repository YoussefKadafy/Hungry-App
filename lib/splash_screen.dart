import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hungry/core/consts/app_assets.dart';
import 'package:hungry/core/consts/app_colors.dart';
import 'package:hungry/core/routing/app_routes.dart';
import 'package:hungry/core/utils/pref_helper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _logoController;
  late AnimationController _imageController;
  late AnimationController _scaleController;

  late Animation<double> _logoFadeAnimation;
  late Animation<Offset> _logoSlideAnimation;
  late Animation<double> _logoScaleAnimation;

  late Animation<double> _imageFadeAnimation;
  late Animation<Offset> _imageSlideAnimation;

  late Animation<double> _backgroundScaleAnimation;

  Future<void> trafficPoliceOfficer() async {
    final token = await PrefHelper.getToken();
    if (token != null && token.isNotEmpty) {
      if (mounted) {
        context.pushReplacementNamed(AppRoutes.rootScreen);
      }
    } else {
      if (mounted) {
        context.pushReplacementNamed(AppRoutes.login);
      }
    }
  }

  @override
  void initState() {
    super.initState();

    // Logo animations controller
    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    // Image animations controller
    _imageController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    // Background scale controller
    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    // Logo fade animation (0 to 1)
    _logoFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _logoController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
      ),
    );

    // Logo slide from top
    _logoSlideAnimation =
        Tween<Offset>(begin: const Offset(0, -0.5), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _logoController,
            curve: const Interval(0.0, 0.7, curve: Curves.easeOutCubic),
          ),
        );

    // Logo scale animation (bounce effect)
    _logoScaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _logoController,
        curve: const Interval(0.0, 0.7, curve: Curves.elasticOut),
      ),
    );

    // Image fade animation
    _imageFadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _imageController, curve: Curves.easeIn));

    // Image slide from bottom
    _imageSlideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
          CurvedAnimation(parent: _imageController, curve: Curves.easeOutCubic),
        );

    // Background subtle scale animation
    _backgroundScaleAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.easeInOut),
    );

    // Start animations sequence
    _startAnimations();
    // Navigate after delay
  }

  void _startAnimations() async {
    // Start background subtle scale
    _scaleController.forward();

    // Start logo animation
    await _logoController.forward();

    // Start image animation
    await _imageController.forward();

    // انتظر شويه بعد كل الأنيميشنز (اختياري)
    await Future.delayed(const Duration(milliseconds: 400));

    // ثم تنقل على حسب التوكن
    trafficPoliceOfficer();
  }

  @override
  void dispose() {
    _logoController.dispose();
    _imageController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: AnimatedBuilder(
            animation: _scaleController,
            builder: (context, child) {
              return Transform.scale(
                scale: _backgroundScaleAnimation.value,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Spacer(),
                    // Animated Logo
                    SlideTransition(
                      position: _logoSlideAnimation,
                      child: FadeTransition(
                        opacity: _logoFadeAnimation,
                        child: ScaleTransition(
                          scale: _logoScaleAnimation,
                          child: SvgPicture.asset(
                            AppAssets.logo,
                            width: 258.w,
                            height: 60.h,
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    // Animated Splash Image
                    SlideTransition(
                      position: _imageSlideAnimation,
                      child: FadeTransition(
                        opacity: _imageFadeAnimation,
                        child: Image.asset(
                          AppAssets.splashImage,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
