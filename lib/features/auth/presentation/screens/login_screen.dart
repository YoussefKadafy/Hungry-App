part of '../auth.dart';

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
              TopLoginScreenSection(
                topLogoSpace: topLogoSpace,
                bottomLogoSpace: bottomLogoSpace,
              ),
              BottomLoginScreenSection(
                availableSpace: availableSpace,
                bottomInset: bottomInset,
                emailController: emailController,
                passwordController: passwordController,
                formKey: _formKey,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
