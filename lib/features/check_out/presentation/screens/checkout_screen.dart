import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hungry/core/consts/app_colors.dart';
import 'package:hungry/core/shared/custom_payment_card.dart';
import 'package:hungry/core/shared/custom_text.dart';
import 'package:hungry/core/shared/snack_bar_dialog.dart';
import 'package:hungry/core/shared/total_price_and_cart_widget.dart';
import 'package:hungry/core/utils/show_dialog.dart';
import 'package:hungry/core/utils/show_loading_dialog.dart';
import 'package:hungry/core/utils/sized_box_extension.dart';
import 'package:hungry/features/cart/data/models/add_to_cart_model.dart';
import 'package:hungry/features/cart/presentation/cubit/save_orders_cubit.dart';
import 'package:hungry/features/cart/presentation/cubit/save_orders_states.dart';
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
                  context.read<SaveOrdersCubit>().saveOrder(
                    widget.cartRequestModel,
                  );
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
        child: BlocListener<SaveOrdersCubit, SaveOrderStates>(
          listener: (context, state) {
            if (state is SaveOrderSuccess) {
              Navigator.of(context, rootNavigator: true).pop();
              snackBarDialog(
                context,
                message: state.message,
                type: AnimatedSnackBarType.success,
              );
            }
            if (state is SaveOrderError) {
              Navigator.of(context, rootNavigator: true).pop();
              snackBarDialog(
                context,
                message: state.message,
                type: AnimatedSnackBarType.error,
              );
            }
            if (state is SaveOrderLoading) {
              showLoadingDialog(context);
            }
          },
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
              OrderDetailsSection(
                totalPrice: totalPrice,
                orderPrice: orderPrice,
              ),
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
      ),
    );
  }
}
