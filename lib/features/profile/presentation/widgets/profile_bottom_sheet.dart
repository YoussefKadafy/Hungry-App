import 'dart:io';

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hungry/core/consts/app_colors.dart';
import 'package:hungry/core/routing/app_routes.dart';
import 'package:hungry/core/shared/custom_snack_bar.dart';
import 'package:hungry/core/shared/custom_text.dart';
import 'package:hungry/core/shared/snack_bar_dialog.dart';
import 'package:hungry/core/translations/locale_keys.g.dart';
import 'package:hungry/core/utils/show_loading_dialog.dart';
import 'package:hungry/core/utils/sized_box_extension.dart';
import 'package:hungry/features/auth/presentation/cubit/logout_cubit.dart';
import 'package:hungry/features/auth/presentation/cubit/logout_states.dart';
import 'package:hungry/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:hungry/features/profile/presentation/cubit/update_profile_cubit.dart';
import 'package:hungry/features/profile/presentation/cubit/update_profile_states.dart';

class ProfileBottomSheet extends StatelessWidget {
  const ProfileBottomSheet({
    super.key,
    required TextEditingController nameController,
    required TextEditingController addressController,
    required TextEditingController emailController,
    required this.imageFile,
  }) : _nameController = nameController,
       _addressController = addressController,
       _emailController = emailController;

  final TextEditingController _nameController;
  final TextEditingController _addressController;
  final TextEditingController _emailController;
  final File? imageFile;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.r),
          topRight: Radius.circular(16.r),
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0x26000000),
            blurRadius: 10,
            spreadRadius: 0,
            offset: const Offset(0, -4), // 👈 شادو من فوق
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            BlocListener<UpdateProfileCubit, UpdateProfileStates>(
              listener: (context, state) {
                if (state is UpdateProfileLoading) {
                  showLoadingDialog(context);
                }

                if (state is UpdateProfileSuccess) {
                  Navigator.pop(context);
                  context.read<ProfileCubit>().getProfile();
                }
              },
              child: GestureDetector(
                onTap: () {
                  context.read<UpdateProfileCubit>().updateProfile(
                    name: _nameController.text,
                    address: _addressController.text,
                    email: _emailController.text,
                    image: imageFile?.path,
                  );
                },
                child: Container(
                  padding: 16.paddingAll,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: AppColors.primaryColor,
                      width: 1.5,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        text: LocaleKeys.editeProfile.tr(),
                        fontSize: 18,
                        color: AppColors.primaryColor,
                      ),
                      10.width,
                      Icon(Icons.edit_square, color: AppColors.primaryColor),
                    ],
                  ),
                ),
              ),
            ),
            BlocListener<LogoutCubit, LogoutState>(
              listener: (context, state) {
                if (state is LogoutSuccess) {
                  context.pushReplacementNamed(AppRoutes.login);
                  snackBarDialog(
                    context,
                    message: state.message,
                    type: AnimatedSnackBarType.success,
                  );
                }
                if (state is LogoutError) {
                  Navigator.pop(context);
                  showCustomSnackBar(context, state.error);
                }
                if (state is LogoutLoading) {
                  showLoadingDialog(context);
                }
              },
              child: GestureDetector(
                onTap: () {
                  context.read<LogoutCubit>().logout();
                },
                child: Container(
                  padding: 16.paddingAll,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.red, width: 1.5),
                  ),
                  child: Row(
                    children: [
                      CustomText(
                        text: LocaleKeys.logOut.tr(),
                        fontSize: 18,
                        color: AppColors.red,
                      ),
                      10.width,
                      Icon(Icons.logout_outlined, color: AppColors.red),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
