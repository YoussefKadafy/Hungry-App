import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import 'dart:math';

void showCongrats(BuildContext context) {
  // Controller للـ confetti
  final confettiController = ConfettiController(
    duration: const Duration(seconds: 4),
  );

  // إنشاء overlay
  final overlay = OverlayEntry(
    builder: (context) {
      return Stack(
        children: [
          Positioned.fill(child: Container(color: Colors.transparent)),

          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: confettiController,
              blastDirection: pi / 2, // لأسفل
              emissionFrequency: 0.05,
              numberOfParticles: 20,
              gravity: 0.2,
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
      );
    },
  );

  // إضافة overlay
  Overlay.of(context).insert(overlay);

  // تشغيل confetti
  confettiController.play();

  // إزالة overlay بعد 3 ثواني
  Future.delayed(const Duration(seconds: 3), () {
    confettiController.dispose();
    overlay.remove();
  });
}
