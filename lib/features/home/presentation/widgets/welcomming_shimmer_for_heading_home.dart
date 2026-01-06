import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hungry/core/consts/app_colors.dart';
import 'package:hungry/core/utils/sized_box_extension.dart';
import 'package:shimmer/shimmer.dart';

class WelcomingShimmerForHeadingHome extends StatelessWidget {
  const WelcomingShimmerForHeadingHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Left Column (Text skeletons)
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // First line skeleton
            Shimmer.fromColors(
              baseColor: Color(0xFF9E9E9E),
              highlightColor: Color(0xFF9E9E9E),
              child: Container(
                width: 120.w,
                height: 18.h,
                decoration: BoxDecoration(
                  color: AppColors.grey,
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
            ),
            5.height,
            // Second line skeleton (2 lines)
            Shimmer.fromColors(
              baseColor: Color(0xFF9E9E9E),
              highlightColor: Color(0xFF9E9E9E),
              child: Container(
                width: 200.w,
                height: 36.h,
                decoration: BoxDecoration(
                  color: AppColors.grey,
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
            ),
          ],
        ),

        // Right CircleAvatar skeleton
        Shimmer.fromColors(
          baseColor: Color(0xFF9E9E9E),
          highlightColor: Color(0xFF9E9E9E),
          child: CircleAvatar(radius: 35.r, backgroundColor: AppColors.grey),
        ),
      ],
    );
  }
}
