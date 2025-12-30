import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hungry/core/consts/app_colors.dart';
import 'package:hungry/core/shared/custom_text.dart';
import 'package:hungry/core/translations/locale_keys.g.dart';
import 'package:hungry/core/utils/sized_box_extension.dart';

class HeadingWidget extends StatelessWidget {
  const HeadingWidget({super.key, required this.userName, required this.image});
  final String userName, image;

  @override
  Widget build(BuildContext context) {
    final firstName = userName.split(' ').first;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: "${LocaleKeys.welcome.tr()},",
              fontSize: 18,
              color: AppColors.grey,
            ),
            5.height,
            CustomText(
              text:
                  'Are you Hungry $firstName ? \nYou\'ve come to the right place',
              fontSize: 18,
              color: AppColors.darkPrimaryColor,
            ),
          ],
        ),
        CircleAvatar(
          radius: 35.r,
          child: ClipOval(
            child: Image.network(
              image,
              fit: BoxFit.cover,
              width: 70,
              height: 70,
              errorBuilder: (context, error, stackTrace) {
                return CircleAvatar(
                  radius: 35.r,

                  backgroundColor: AppColors.grey.withOpacity(.5),
                  child: Icon(Icons.person, size: 40.r, color: AppColors.white),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
