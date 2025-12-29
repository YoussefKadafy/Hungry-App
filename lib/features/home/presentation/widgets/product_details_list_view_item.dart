import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hungry/core/consts/app_assets.dart';
import 'package:hungry/core/consts/app_colors.dart';
import 'package:hungry/core/utils/sized_box_extension.dart';

class ProductDetailsListViewItem extends StatelessWidget {
  final String title;
  final String imagePath;
  final VoidCallback? onAddPressed;
  final List<int> selectedIds;
  final int id;

  const ProductDetailsListViewItem({
    super.key,
    this.title = 'Lettuce',
    this.imagePath = AppAssets.testImage,
    this.onAddPressed,
    required this.selectedIds,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    bool isSelected = selectedIds.contains(id);
    return Padding(
      padding: EdgeInsetsDirectional.only(end: 16.w, bottom: 16.h, top: 16.h),
      child: Container(
        width: 140.w,
        height: 160.h,

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          color: AppColors.darkBrown,
          boxShadow: [
            BoxShadow(
              color: AppColors.lightGrey,
              blurRadius: 22,
              spreadRadius: .1,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // Image Container
            Positioned(
              top: -16.h,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.all(8.w),
                width: 140.w,
                height: 106.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  color: isSelected
                      ? AppColors.lightPrimaryColor
                      : Colors.white,
                ),
                child: ClipRRect(
                  clipBehavior: Clip.none,
                  borderRadius: BorderRadius.circular(8.r),
                  child: Image.network(imagePath, fit: BoxFit.scaleDown),
                ),
              ),
            ),

            // Bottom Content
            Positioned(
              bottom: 12.h,
              left: 12.w,
              right: 12.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Title
                  Expanded(
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),

                  8.width,

                  // Add Button
                  Container(
                    width: 34.w,
                    height: 34.h,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.primaryColor
                          : AppColors.red,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      onPressed: onAddPressed,
                      padding: EdgeInsets.zero,
                      icon: Icon(
                        isSelected ? Icons.check : Icons.add,
                        color: Colors.white,
                        size: 20.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
