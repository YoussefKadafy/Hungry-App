import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hungry/core/shared/custom_button.dart';
import 'package:hungry/core/shared/custom_text.dart';
import 'package:hungry/core/utils/sized_box_extension.dart';
import 'package:hungry/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:hungry/features/cart/presentation/widgets/cart_item.dart';
import 'package:hungry/features/cart/presentation/widgets/quantity_button.dart';
import 'package:hungry/features/cart/presentation/widgets/removing_button.dart';

class IcreaseDecreaseAndRemoveSection extends StatelessWidget {
  const IcreaseDecreaseAndRemoveSection({super.key, required this.widget});

  final CartItem widget;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 154.w,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              QtyButton(icon: Icons.remove, onPressed: widget.onDecrease),
              CustomText(
                text: context
                    .read<CartCubit>()
                    .getQuantity(widget.item.itemId!.toInt())
                    .toString(),
                fontSize: 16,
              ),
              QtyButton(icon: Icons.add, onPressed: widget.onIncrease),
            ],
          ),
          41.height,
          widget.isRemoving
              ? RemovingButton()
              : CustomButton(
                  text: 'Remove',
                  width: 154,
                  height: 43,
                  onTap: widget.onRemove,
                ),
        ],
      ),
    );
  }
}
