part of '../auth.dart';

class TopScreenSection extends StatelessWidget {
  const TopScreenSection({
    super.key,
    required this.topLogoSpace,
    required this.bottomLogoSpace,
  });

  final double topLogoSpace;
  final double bottomLogoSpace;

  @override
  Widget build(BuildContext context) {
    return Column(
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
      ],
    );
  }
}
