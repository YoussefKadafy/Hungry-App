part of '../auth.dart';

class AlreadyHaveAccountWidget extends StatelessWidget {
  const AlreadyHaveAccountWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
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
    );
  }
}
