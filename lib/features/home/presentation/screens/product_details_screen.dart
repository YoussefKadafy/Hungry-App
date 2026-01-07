import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hungry/core/consts/app_assets.dart';
import 'package:hungry/core/utils/sized_box_extension.dart';
import 'package:hungry/features/home/data/model/product_model.dart';
import 'package:hungry/features/home/presentation/cubit/add_to_cart_cubit.dart';
import 'package:hungry/features/home/presentation/cubit/toppins_and_options_cubit.dart';
import 'package:hungry/features/home/presentation/widgets/price_and_adding_to_cart.dart';
import 'package:hungry/features/home/presentation/widgets/product_spice_selector_section.dart';
import 'package:hungry/features/home/presentation/widgets/side_options_section.dart';
import 'package:hungry/features/home/presentation/widgets/toppings_section.dart';
import 'package:lottie/lottie.dart';
import 'package:lottie/lottie.dart';
import 'package:confetti/confetti.dart';
import 'dart:math';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key, required this.product});
  final ProductModel product;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ToppinsAndOptionsCubit>().fetchToppings();
    context.read<ToppinsAndOptionsCubit>().fetchSideOptions();
    context.read<AddToCartCubit>().spiceLevel;
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    final bottomInset = MediaQuery.of(context).viewPadding.bottom;
    double spiceValue = context.watch<AddToCartCubit>().spiceLevel;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      bottomSheet: PriceAndAddingToCart(
        bottomInset: bottomInset,
        product: product,
        sliderValue: spiceValue,
      ),

      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProductSpiceSelectorSection(
              onChanged: (value) {
                context.read<AddToCartCubit>().spiceLevelChanged(value);
              },
              product: product,
              sliderValue: spiceValue,
            ),
            52.height,
            ToppingSection(),
            52.height,
            SideOptionsSection(),

            164.height,
          ],
        ),
      ),
    );
  }
}

void showCongratsOverlay(BuildContext context) {
  // Controller للـ confetti
  final confettiController = ConfettiController(
    duration: const Duration(seconds: 2),
  );

  // إنشاء overlay
  final overlay = OverlayEntry(
    builder: (context) {
      return Stack(
        children: [
          // خلفية شفافة
          Positioned.fill(child: Container(color: Colors.transparent)),

          // Confetti
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
