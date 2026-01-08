import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hungry/core/consts/app_colors.dart';
import 'package:hungry/core/utils/sized_box_extension.dart';
import 'package:hungry/features/cart/data/models/cart_model/item.dart';
import 'package:hungry/features/cart/presentation/widgets/floating_bubbles.dart';
import 'package:hungry/features/cart/presentation/widgets/icrease_decrease_and_remove_section.dart';

class CartItem extends StatefulWidget {
  const CartItem({
    super.key,
    required this.item,
    required this.onIncrease,
    required this.onDecrease,
    required this.onRemove,
    required this.isRemoving,
  });
  final bool isRemoving;
  final Item item;
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;
  final void Function() onRemove;

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);
    _animation = Tween<double>(
      begin: 0,
      end: -5,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String spicyLevel() {
    double value = widget.item.spicy ?? 0.1;
    if (value <= .3) return 'Mild';
    if (value <= .6) return 'Medium';
    if (value <= .8) return 'Spicy';
    return 'Very Spicy';
  }

  Color textColorSelector() {
    double value = widget.item.spicy ?? 0.1;
    if (value <= .3) return AppColors.lightPrimaryColor;
    if (value <= .6) return Colors.amber;
    if (value <= .8) return Colors.deepOrange;
    return Colors.red.shade600;
  }

  @override
  Widget build(BuildContext context) {
    final displayName = (widget.item.name ?? '').split(' ').take(5).join(' ');
    final allImages = [
      if (widget.item.toppings != null)
        ...widget.item.toppings!.map((e) => e.image ?? ''),
      if (widget.item.sideOptions != null)
        ...widget.item.sideOptions!.map((e) => e.image ?? ''),
    ];
    final hasBubbles = allImages.isNotEmpty;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Card(
          color: AppColors.white,
          child: Padding(
            padding: EdgeInsets.only(
              top: 16.h,
              left: 32.w,
              right: 16.w,
              bottom: hasBubbles ? 50.h : 16.h,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 111.w,
                        child: CachedNetworkImage(
                          imageUrl: widget.item.image ?? '',
                          fit: BoxFit.cover,
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                          placeholder: (context, url) => const Center(
                            child: CircularProgressIndicator(
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ),
                      ),
                      8.height,
                      Text(
                        displayName,
                        maxLines: 2,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      8.height,
                      Text(
                        spicyLevel(),
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: textColorSelector(),
                        ),
                      ),
                    ],
                  ),
                ),
                IcreaseDecreaseAndRemoveSection(widget: widget),
              ],
            ),
          ),
        ),
        // Floating bubbles at the bottom of the card
        FloatingBubbles(animation: _animation, allImages: allImages),
      ],
    );
  }
}
