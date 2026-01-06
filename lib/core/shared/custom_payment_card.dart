import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hungry/core/consts/app_assets.dart';
import 'package:hungry/core/consts/app_colors.dart';
import 'package:hungry/core/shared/custom_text.dart';
import 'package:hungry/core/utils/sized_box_extension.dart';

class CustomPaymentCard extends StatelessWidget {
  const CustomPaymentCard({
    super.key,
    required this.selectedCard,
    required this.onChanged,
    this.visaNumber,
  });
  final String? visaNumber;
  final String selectedCard;
  final Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Card(
        margin: EdgeInsets.zero,
        color: AppColors.visaColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SvgPicture.asset(
                AppAssets.visaIcon,
                width: 60.r,
                height: 60.r,
                fit: BoxFit.cover,
              ),
              Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: 'Debit card',
                    fontSize: 14.sp,
                    color: AppColors.black,
                    fontWeight: FontWeight.w500,
                  ),
                  10.height,
                  CustomText(
                    text: visaNumber ?? 'There is no Visa yet',
                    fontSize: 14.sp,
                    color: AppColors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
              Spacer(flex: 5),
              Radio<String>(
                value: 'visa',
                activeColor: AppColors.primaryColor,
                groupValue: selectedCard,
                onChanged: (value) {
                  if (value != null) {
                    onChanged(value);
                  }
                },
                fillColor: WidgetStatePropertyAll(AppColors.primaryColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
