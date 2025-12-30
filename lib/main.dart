import 'package:flutter/material.dart';
import 'package:hungry/app.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:hungry/core/di/di_helper.dart';
import 'package:hungry/core/translations/codegen_loader.g.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      startLocale: const Locale('en'),
      assetLoader: const CodegenLoader(),
      child: const HungryApp(),
    ),
  );
}
