part of '../auth.dart';

class TopRegisterScreenSection extends StatelessWidget {
  const TopRegisterScreenSection({
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
        SizedBox(height: bottomLogoSpace),
      ],
    );
  }
}
