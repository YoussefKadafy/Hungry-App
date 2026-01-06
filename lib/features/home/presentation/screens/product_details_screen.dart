import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hungry/core/utils/sized_box_extension.dart';
import 'package:hungry/features/home/data/model/product_model.dart';
import 'package:hungry/features/home/presentation/cubit/add_to_cart_cubit.dart';
import 'package:hungry/features/home/presentation/cubit/toppins_and_options_cubit.dart';
import 'package:hungry/features/home/presentation/widgets/price_and_adding_to_cart.dart';
import 'package:hungry/features/home/presentation/widgets/product_spice_selector_section.dart';
import 'package:hungry/features/home/presentation/widgets/side_options_section.dart';
import 'package:hungry/features/home/presentation/widgets/toppings_section.dart';

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
