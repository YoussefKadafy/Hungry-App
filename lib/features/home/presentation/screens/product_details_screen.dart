import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hungry/core/shared/custom_snack_bar.dart';
import 'package:hungry/core/shared/snack_bar_dialog.dart';
import 'package:hungry/core/utils/show_loading_dialog.dart';
import 'package:hungry/core/utils/sized_box_extension.dart';
import 'package:hungry/features/cart/data/models/add_to_cart_model.dart';
import 'package:hungry/features/home/data/model/product_model.dart';
import 'package:hungry/features/home/presentation/cubit/add_to_cart_cubit.dart';
import 'package:hungry/features/home/presentation/cubit/add_to_cart_state.dart';
import 'package:hungry/features/home/presentation/cubit/toppins_and_options_cubit.dart';
import 'package:hungry/features/home/presentation/cubit/toppins_and_options_states.dart';
import 'package:hungry/features/home/presentation/widgets/product_details_list_view_item.dart';
import 'package:hungry/features/home/presentation/widgets/product_spice_selector_section.dart';
import 'package:hungry/core/shared/total_price_and_cart_widget.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key, required this.product});
  final ProductModel product;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  double sliderValue = .1;
  List<int> selectedToppings = [];
  List<int> selectedSideOptions = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    context.read<ToppinsAndOptionsCubit>().fetchToppings();
    context.read<ToppinsAndOptionsCubit>().fetchSideOptions();
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    final bottomInset = MediaQuery.of(context).viewPadding.bottom;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      bottomSheet: PriceAndAddingToCart(
        bottomInset: bottomInset,
        product: product,
        selectedToppings: selectedToppings,
        selectedSideOptions: selectedSideOptions,
        sliderValue: sliderValue,
      ),

      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProductSpiceSelectorSection(
              onChanged: (value) {
                setState(() {
                  sliderValue = value;
                });
              },
              product: product,
              sliderValue: sliderValue,
            ),
            52.height,
            Padding(
              padding: EdgeInsetsDirectional.only(start: 16.w),
              child: const Text(
                'Toppings',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),

            // ListView.builder للـ toppings
            BlocBuilder<ToppinsAndOptionsCubit, ToppingsAndOptionsStates>(
              builder: (context, state) {
                if (state is ToppingsAndOptionsError) {
                  return Center(child: Text(state.message));
                }
                if (state is ToppingsAndOptionsSuccess) {
                  final toppings = context
                      .read<ToppinsAndOptionsCubit>()
                      .toppings;
                  return SizedBox(
                    height: 200.h,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: toppings.length,
                      padding: EdgeInsetsDirectional.only(start: 16.w),
                      itemBuilder: (context, index) {
                        final toppingItem = toppings[index];
                        return Align(
                          alignment:
                              Alignment.bottomCenter, // هيخلي الـ item يلزق تحت
                          child: ProductDetailsListViewItem(
                            selectedIds: selectedToppings,
                            id: toppingItem.id,
                            title: toppingItem.title,
                            imagePath: toppingItem.image,
                            onAddPressed: () {
                              setState(() {
                                if (selectedToppings.contains(toppingItem.id)) {
                                  selectedToppings.remove(toppingItem.id);
                                } else {
                                  selectedToppings.add(toppingItem.id);
                                }
                              });
                            },
                          ),
                        );
                      },
                    ),
                  );
                }
                return Center(child: CircularProgressIndicator());
              },
            ),
            52.height,
            Padding(
              padding: EdgeInsetsDirectional.only(start: 16.w),
              child: const Text(
                'Side options',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),

            BlocBuilder<ToppinsAndOptionsCubit, ToppingsAndOptionsStates>(
              builder: (context, state) {
                if (state is ToppingsAndOptionsError) {
                  return Center(child: Text(state.message));
                }
                if (state is ToppingsAndOptionsSuccess) {
                  final options = context
                      .read<ToppinsAndOptionsCubit>()
                      .options;
                  return SizedBox(
                    height: 200.h,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: options.length,
                      padding: EdgeInsetsDirectional.only(start: 16.w),
                      clipBehavior: Clip.none,
                      itemBuilder: (context, index) {
                        final sideOptionItem = options[index];
                        return Align(
                          alignment:
                              Alignment.bottomCenter, // هيخلي الـ item يلزق تحت
                          child: ProductDetailsListViewItem(
                            selectedIds: selectedSideOptions,
                            id: sideOptionItem.id,
                            title: sideOptionItem.title,
                            imagePath: sideOptionItem.image,
                            onAddPressed: () {
                              setState(() {
                                if (selectedSideOptions.contains(
                                  sideOptionItem.id,
                                )) {
                                  selectedSideOptions.remove(sideOptionItem.id);
                                } else {
                                  selectedSideOptions.add(sideOptionItem.id);
                                }
                              });
                            },
                          ),
                        );
                      },
                    ),
                  );
                }
                return Center(child: CircularProgressIndicator());
              },
            ),

            164.height,
          ],
        ),
      ),
    );
  }
}

class PriceAndAddingToCart extends StatelessWidget {
  const PriceAndAddingToCart({
    super.key,
    required this.bottomInset,
    required this.product,
    required this.selectedToppings,
    required this.selectedSideOptions,
    required this.sliderValue,
  });

  final double bottomInset;
  final ProductModel product;
  final List<int> selectedToppings;
  final List<int> selectedSideOptions;
  final double sliderValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.r),
          topRight: Radius.circular(16.r),
        ),
        boxShadow: [
          BoxShadow(color: Colors.grey, blurRadius: 20, offset: Offset(0, 9)),
        ],
      ),
      height: 110.h + bottomInset,
      padding: EdgeInsets.fromLTRB(16, 16, 16, 16 + bottomInset),
      child: BlocListener<AddToCartCubit, AddToCartState>(
        listener: (context, state) {
          if (state is AddToCartError) {
            snackBarDialog(
              context,
              message: state.message,
              type: AnimatedSnackBarType.error,
            );
          }
          if (state is AddToCartLoading) {
            showLoadingDialog(context);
          }
          if (state is AddToCartSuccess) {
            Navigator.pop(context);
            snackBarDialog(
              context,
              message: state.addToCartResponseModel.message,
              type: AnimatedSnackBarType.success,
            );
          }
        },
        child: TotalPriceAndCartWidget(
          iconData: Icon(Icons.add_shopping_cart, color: Colors.white),
          onPressed: () async {
            final cartItems = CartItemModel(
              productId: product.id,
              quantity: 1,
              toppings: selectedToppings,
              sideOptions: selectedSideOptions,
              spicy: sliderValue,
            );
            final request = CartRequestModel(items: [cartItems]);
            context.read<AddToCartCubit>().addToCart(request);
          },
          price: '\$ ${product.price}',
          title: 'Total Price',
        ),
      ),
    );
  }
}
