import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class LoadingToppingsAndOptions extends StatelessWidget {
  const LoadingToppingsAndOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 240.h,
      child: ListView.builder(
        itemCount: 4,
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.only(left: 16.w),
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) => Padding(
          padding: EdgeInsetsDirectional.only(
            end: 16.w,
            bottom: 16.h,
            top: 16.h,
          ),
          child: const OptionShimmerItem(width: 140, imageHeight: 100),
        ),
      ),
    );
  }
}

class OptionShimmerItem extends StatelessWidget {
  const OptionShimmerItem({
    super.key,
    this.width = 140,
    this.imageHeight = 100,
  });

  final double width;
  final double imageHeight;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width.w,
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Material(
          elevation: 2,
          borderRadius: BorderRadius.circular(12.r),
          child: Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: Colors.white,

              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image placeholder
                Container(
                  height: imageHeight.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),

                12.verticalSpace,

                // Title
                Container(height: 14.h, width: 80.w, color: Colors.grey),

                8.verticalSpace,

                // Subtitle / price
                Container(height: 12.h, width: 50.w, color: Colors.grey),

                8.verticalSpace,
                // Add button placeholder
                Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    height: 24.h,
                    width: 24.h,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
