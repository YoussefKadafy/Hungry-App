part of '../auth.dart';

class ContineuAsGuestWidget extends StatelessWidget {
  const ContineuAsGuestWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: CustomAuthButton(
        backgroundColor: Colors.transparent,
        borderColor: Colors.white,
        textColor: AppColors.white,
        text: LocaleKeys.continueAsAGuest.tr(),
        onPressed: () {
          context.pushReplacementNamed(AppRoutes.rootScreen);
        },
      ),
    );
  }
}
