import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hungry/core/consts/app_assets.dart';
import 'package:hungry/core/consts/app_colors.dart';
import 'package:hungry/core/shared/custom_text.dart';

class CashOnDeliveryCard extends StatelessWidget {
  const CashOnDeliveryCard({
    super.key,
    required this.selectedCard,
    required this.onChanged,
  });

  final String selectedCard;
  final Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Card(
        margin: EdgeInsets.zero,
        color: AppColors.darkBrown,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 45.r,
                    height: 45.r,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                  ),
                  SvgPicture.asset(
                    AppAssets.dollarIcon,
                    width: 60.r,
                    height: 60.r,
                    fit: BoxFit.cover,
                    color: AppColors.primaryColor,
                  ),
                ],
              ),
              Spacer(),
              CustomText(
                text: 'Cash on Delivery',
                fontSize: 18.sp,
                color: AppColors.white,
              ),
              Spacer(flex: 5),
              Radio<String>(
                value: 'cash',
                activeColor: AppColors.primaryColor,
                groupValue: selectedCard,
                onChanged: (value) {
                  if (value != null) {
                    onChanged(value);
                  }
                },
                fillColor: WidgetStatePropertyAll(AppColors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
