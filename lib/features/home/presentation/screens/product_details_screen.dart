import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hungry/core/shared/snack_bar_dialog.dart';
import 'package:hungry/core/shared/custom_snack_bar.dart';
import 'package:hungry/core/utils/cart_notifier.dart';
import 'package:hungry/core/utils/sized_box_extension.dart';
import 'package:hungry/features/cart/data/models/add_to_cart_model.dart';
import 'package:hungry/features/cart/data/repos/add_to_cart_repo.dart';
import 'package:hungry/features/home/data/model/product_model.dart';
import 'package:hungry/features/home/data/model/toppings_model.dart';
import 'package:hungry/features/home/data/repo/home_repo.dart';
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
  List<ToppingsModel> toppingsList = [];
  List<ToppingsModel> sideOptionsList = [];
  double sliderValue = .1;
  List<int> selectedToppings = [];
  List<int> selectedSideOptions = [];
  bool isLoading = true;
  bool isAddedToCartLoading = false;

  @override
  void initState() {
    super.initState();
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
      bottomSheet: Container(
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
        child: TotalPriceAndCartWidget(
          iconData: isAddedToCartLoading
              ? Center(child: CircularProgressIndicator(color: Colors.white))
              : Icon(Icons.add_shopping_cart, color: Colors.white),
          onPressed: () async {
            final cartItems = CartItemModel(
              productId: product.id,
              quantity: 1,
              toppings: selectedToppings,
              sideOptions: selectedSideOptions,
              spicy: sliderValue,
            );
            final request = CartRequestModel(items: [cartItems]);
          },
          price: '\$ ${product.price}',
          title: 'Total Price',
        ),
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
            isLoading
                ? CircularProgressIndicator()
                : SizedBox(
                    height: 200.h,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: toppingsList.length,
                      padding: EdgeInsetsDirectional.only(start: 16.w),
                      itemBuilder: (context, index) {
                        final toppingItem = toppingsList[index];
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
                  ),
            52.height,
            Padding(
              padding: EdgeInsetsDirectional.only(start: 16.w),
              child: const Text(
                'Side options',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),

            isLoading
                ? CircularProgressIndicator()
                : SizedBox(
                    height: 200.h,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: sideOptionsList.length,
                      padding: EdgeInsetsDirectional.only(start: 16.w),
                      clipBehavior: Clip.none,
                      itemBuilder: (context, index) {
                        final sideOptionItem = sideOptionsList[index];
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
                  ),

            164.height,
          ],
        ),
      ),
    );
  }
}
