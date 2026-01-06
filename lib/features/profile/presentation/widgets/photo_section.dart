import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hungry/core/consts/app_colors.dart';
import 'package:hungry/features/auth/data/model/user_model.dart';
import 'package:skeletonizer/skeletonizer.dart';

class PhotoSection extends StatelessWidget {
  const PhotoSection({
    super.key,
    required this.imageFile,
    required this.userModel,
    this.onPressed,
  });

  final File? imageFile;
  final UserModel? userModel;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.white, width: 3),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(60),
            child: imageFile != null
                ? Image(image: FileImage(imageFile!), fit: BoxFit.fill)
                : CachedNetworkImage(
                    imageUrl: userModel?.image ?? '',
                    fit: BoxFit.fill,
                    placeholder: (context, url) => Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primaryColor,
                      ),
                    ),
                    errorWidget: (context, url, error) =>
                        Icon(Icons.person, size: 60, color: AppColors.grey),
                  ),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Skeleton.ignore(
            child: Stack(
              children: [
                IconButton(
                  onPressed: onPressed,
                  icon: Material(
                    color: Colors.transparent,
                    shape: const CircleBorder(),
                    elevation: 6,
                    shadowColor: Color(0x80000000),

                    child: Icon(
                      CupertinoIcons.photo_camera_solid,
                      color: AppColors.white,
                      blendMode: BlendMode.srcOver,
                      size: 26,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
