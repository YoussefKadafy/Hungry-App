import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import 'dart:math';

void showCongrats(BuildContext context) {
  final confettiController = ConfettiController(
    duration: const Duration(seconds: 3),
  );

  final fadeController = AnimationController(
    vsync: Navigator.of(context),
    duration: const Duration(milliseconds: 800),
  );

  final fadeAnimation = Tween<double>(
    begin: 1.0,
    end: 0.0,
  ).animate(fadeController);

  late OverlayEntry overlay;

  overlay = OverlayEntry(
    builder: (context) {
      return FadeTransition(
        opacity: fadeAnimation,
        child: Stack(
          children: [
            Positioned.fill(child: Container(color: Colors.transparent)),
            Align(
              alignment: Alignment.topCenter,
              child: ConfettiWidget(
                confettiController: confettiController,
                blastDirection: pi / 2,
                emissionFrequency: 0.05,
                numberOfParticles: 20,
                gravity: 0.25,
                shouldLoop: false,
                colors: const [
                  Colors.red,
                  Colors.blue,
                  Colors.green,
                  Colors.yellow,
                  Colors.orange,
                  Colors.purple,
                ],
              ),
            ),
          ],
        ),
      );
    },
  );

  Overlay.of(context).insert(overlay);

  confettiController.play();

  // نبدأ الـ fade out بعد ما الـ confetti يخلص
  Future.delayed(const Duration(seconds: 2), () {
    fadeController.forward();
  });

  // إزالة نهائية
  Future.delayed(const Duration(seconds: 3), () {
    confettiController.dispose();
    fadeController.dispose();
    overlay.remove();
  });
}
