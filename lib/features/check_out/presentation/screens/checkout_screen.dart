import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hungry/core/consts/app_colors.dart';
import 'package:hungry/core/shared/custom_dialog.dart';
import 'package:hungry/core/shared/custom_payment_card.dart';
import 'package:hungry/core/shared/custom_text.dart';
import 'package:hungry/core/shared/total_price_and_cart_widget.dart';
import 'package:hungry/core/utils/show_Dialog.dart';
import 'package:hungry/core/utils/sized_box_extension.dart';
import 'package:hungry/features/cart/data/models/add_to_cart_model.dart';
import 'package:hungry/features/cart/data/repos/cart_repo.dart';
import 'package:hungry/features/check_out/data/model/order_calculator_model.dart';
import 'package:hungry/features/check_out/presentation/widgets/cash_on_delivery_card.dart';
import 'package:hungry/features/check_out/presentation/widgets/order_details_section.dart';
import 'package:hungry/features/check_out/presentation/widgets/save_card_data.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({
    super.key,
    required this.totalPrice,
    required this.cartRequestModel,
  });
  final String totalPrice;
  final CartRequestModel cartRequestModel;
  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  String selectedCard = 'cash';
  double get orderPrice => double.tryParse(widget.totalPrice) ?? 0.0;
  double get totalPrice => OrderCalculator.calculateTotal(orderPrice);
  bool isOrderSaved = false;
  CartRepo cartRepo = CartRepo();

  Future<void> saveOrder(CartRequestModel request) async {
    try {
      isOrderSaved = true;
      setState(() {});
      final response = await cartRepo.saveOrder(request);

      if (!mounted) return;
      snackBarDialog(
        context,
        message: 'Order saved to history\n$response 🎉🥳',
        type: AnimatedSnackBarType.success,
        title: 'Success',
      );

      isOrderSaved = false;
      setState(() {});
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
      isOrderSaved = false;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SafeArea(
        child: SizedBox(
          height: 100.h,
          child: TotalPriceAndCartWidget(
            onPressed: () {
              showSuccessDialog(
                context,
                confirmPressed: () {
                  saveOrder(widget.cartRequestModel);
                  Navigator.pop(context);
                },
                title: 'Do you want to save this order at order history?',
              );
            },
            price: totalPrice.toStringAsFixed(2),
            buttonText: 'Pay Now',
            textColor: AppColors.textFieldDisabledHintColor,
          ),
        ),
      ),
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: CustomText(
                text: 'Order Summery',
                fontSize: 24.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            20.height,
            OrderDetailsSection(totalPrice: totalPrice, orderPrice: orderPrice),
            20.height,
            Padding(
              padding: 16.paddingHorizontal,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(text: 'Payment Method', fontSize: 24.sp),
                  22.height,
                  InkWell(
                    borderRadius: BorderRadius.circular(12.r),
                    onTap: () => setState(() {
                      selectedCard = 'cash';
                    }),
                    child: CashOnDeliveryCard(
                      selectedCard: selectedCard,
                      onChanged: (value) {
                        setState(() {
                          selectedCard = value;
                        });
                      },
                    ),
                  ),
                  16.height,
                  InkWell(
                    borderRadius: BorderRadius.circular(12.r),
                    onTap: () => setState(() {
                      selectedCard = 'visa';
                    }),
                    child: CustomPaymentCard(
                      selectedCard: selectedCard,
                      onChanged: (value) {
                        setState(() {
                          selectedCard = value;
                        });
                      },
                    ),
                  ),
                  16.height,
                  SaveCardData(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
