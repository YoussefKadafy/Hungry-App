part of '../auth.dart';

class DontHaveAccountWidget extends StatelessWidget {
  const DontHaveAccountWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
              context.pushReplacementNamed(AppRoutes.register);
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
    );
  }
}
