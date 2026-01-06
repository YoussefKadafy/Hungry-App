import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hungry/core/consts/app_colors.dart';
import 'package:hungry/core/utils/sized_box_extension.dart';
import 'package:hungry/features/check_out/presentation/widgets/text_row_widget.dart';

class OrderDetailsSection extends StatelessWidget {
  const OrderDetailsSection({
    super.key,
    required this.totalPrice,
    required this.orderPrice,
  });
  final double orderPrice;
  final double totalPrice;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: 36.paddingHorizontal,
          child: Column(
            children: [
              TextRowWidget(
                prefixText: 'Order',
                suffixText: '\$ ${orderPrice.toStringAsFixed(2)}',
              ),
              10.height,
              TextRowWidget(prefixText: 'Taxes', suffixText: '\$ 1.5'),
              10.height,
              TextRowWidget(prefixText: 'Delivery Fee', suffixText: '\$ 4.00'),
              8.5.height,
            ],
          ),
        ),
        Padding(
          padding: 16.paddingHorizontal,
          child: const Divider(color: AppColors.darkBrown, thickness: 1.5),
        ),
        Padding(
          padding: 16.paddingHorizontal,
          child: Column(
            children: [
              24.5.height,
              TextRowWidget(
                prefixText: 'Total',
                suffixText: '\$ ${totalPrice.toStringAsFixed(2)}',
                fontWeight: FontWeight.bold,
                textColor: AppColors.black,
                fontSize: 32.sp,
              ),
              20.height,
              TextRowWidget(
                prefixText: 'Estimated delivery time:',
                suffixText: '15 - 30 mins',
                fontWeight: FontWeight.bold,
                textColor: AppColors.black,
                fontSize: 18.sp,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
