import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
              baseColor: const Color(0xFFBDBDBD), // Gray 400
              highlightColor: const Color(0xFFE0E0E0), // Gray 300
              child: Container(
                width: 120.w,
                height: 18.h,
                decoration: BoxDecoration(
                  color: const Color(0xFFBDBDBD),
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
            ),
            5.height,
            // Second line skeleton (2 lines)
            Shimmer.fromColors(
              baseColor: const Color(0xFFBDBDBD),
              highlightColor: const Color(0xFFE0E0E0),
              child: Container(
                width: 200.w,
                height: 36.h,
                decoration: BoxDecoration(
                  color: const Color(0xFFBDBDBD),
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
            ),
          ],
        ),

        // Right CircleAvatar skeleton
        Shimmer.fromColors(
          baseColor: const Color(0xFFBDBDBD),
          highlightColor: const Color(0xFFE0E0E0),
          child: CircleAvatar(
            radius: 35.r,
            backgroundColor: const Color(0xFFBDBDBD),
          ),
        ),
      ],
    );
  }
}
