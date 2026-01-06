import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hungry/core/consts/app_colors.dart';
import 'package:hungry/core/shared/custom_button.dart';
import 'package:hungry/core/shared/custom_text.dart';
import 'package:hungry/core/utils/sized_box_extension.dart';
import 'package:hungry/features/orderHistory/data/model/datum.dart';

class OrderHistoryItem extends StatelessWidget {
  const OrderHistoryItem({super.key, required this.order});
  final Datum order;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.white,
      child: Padding(
        padding: EdgeInsets.only(
          top: 16.h,
          left: 32.w,
          right: 16.w,
          bottom: 31.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 111.w,
                  child: Image.network(
                    order.productImage ?? "",
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(Icons.error);
                    },
                  ),
                ),
                12.width,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText(
                      text:
                          'Created at : ${order.createdAt?.split(' ').last ?? ''}',
                      fontSize: 16,
                    ),
                    CustomText(text: 'Status : ${order.status}', fontSize: 16),
                    CustomText(
                      text: 'Price : \$${order.totalPrice}',
                      fontSize: 18,
                    ),
                  ],
                ),
              ],
            ),
            16.height,
            CustomButton(
              text: 'Reorder Now',
              height: 43,
              width: double.infinity,
            ),
          ],
        ),
      ),
    );
  }
}
