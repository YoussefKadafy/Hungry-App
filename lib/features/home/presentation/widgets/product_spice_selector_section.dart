import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hungry/core/consts/app_colors.dart';
import 'package:hungry/core/shared/custom_text.dart';
import 'package:hungry/core/utils/sized_box_extension.dart';
import 'package:hungry/features/home/data/model/product_model.dart';

class ProductSpiceSelectorSection extends StatelessWidget {
  const ProductSpiceSelectorSection({
    super.key,
    required this.product,
    required this.sliderValue,
    this.onChanged,
  });
  final ProductModel product;
  final double sliderValue;
  final void Function(double)? onChanged;

  String sliderLabel(double value) {
    if (value <= .3) {
      return 'Mild';
    } else if (value <= .6) {
      return 'Medium';
    } else if (value <= .8) {
      return 'Spicy';
    } else {
      return 'Very Spicy';
    }
  }

  Color sliderActiveColor(double value) {
    if (value <= .3) {
      return Colors.green;
    } else if (value <= .6) {
      return Colors.lime;
    } else if (value <= .8) {
      return Colors.deepOrange;
    } else {
      return Colors.red.shade600;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(end: 16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Hero(
            tag: product.id,
            child: CachedNetworkImage(
              width: 217.w,
              height: 297.h,
              imageUrl: product.imageUrl,
              fit: BoxFit.fill,
              placeholder: (context, url) => Center(
                child: CircularProgressIndicator(color: AppColors.primaryColor),
              ),
            ),
          ),
          Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 162.w,
                    child: CustomText(
                      text: product.description,
                      fontSize: 16,
                      textAlign: TextAlign.start,
                    ),
                  ),
                ],
              ),
              24.height,
              CustomText(
                text: 'Spicy',
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              8.height,
              SizedBox(
                width: 162.w,
                child: SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    thumbColor: sliderActiveColor(sliderValue),
                    activeTrackColor: sliderActiveColor(sliderValue),
                    inactiveTrackColor: Colors.grey,
                    thumbShape: const RoundSliderThumbShape(
                      enabledThumbRadius: 10,
                      elevation: 0,
                    ),
                    overlayShape: const RoundSliderOverlayShape(
                      overlayRadius: 20,
                    ),
                    showValueIndicator: ShowValueIndicator.onDrag,
                  ),
                  child: Slider(
                    padding: EdgeInsets.zero,
                    value: sliderValue,
                    onChanged: onChanged,
                    activeColor: sliderActiveColor(sliderValue),
                    inactiveColor: Colors.grey,
                    min: 0,
                    max: .9,
                    label: sliderLabel(sliderValue),
                  ),
                ),
              ),
              16.height,
              SizedBox(
                width: 162.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text('🥶'), Text('🌶️')],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
