import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hungry/core/consts/app_assets.dart';
import 'package:hungry/core/consts/app_colors.dart';
import 'package:hungry/core/routing/app_routes.dart';
import 'package:hungry/core/shared/custom_payment_card.dart';
import 'package:hungry/core/shared/custom_text.dart';
import 'package:hungry/core/translations/locale_keys.g.dart';
import 'package:hungry/core/utils/sized_box_extension.dart';
import 'package:hungry/features/auth/data/model/user_model.dart';
import 'package:hungry/features/auth/data/repo/auth_repo.dart';
import 'package:hungry/features/auth/presentation/widgets/profile_text_field_section.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late TextEditingController _emailController;
  late TextEditingController _nameController;
  late TextEditingController _addressController;
  bool isLoading = false;
  UserModel? model;
  bool isLoggingOut = false;
  bool isEditingProfile = false;
  AuthRepo repo = AuthRepo();
  File? imageFile;
  final ImagePicker picker = ImagePicker();

  Future<void> pickImage() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        imageFile = File(image.path);
      });
    }
  }

  Future<void> editProfile() async {
    try {
      setState(() {
        isEditingProfile = true;
      });
      final user = await repo.editUserData(
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        address: _addressController.text.trim(),

        image: imageFile?.path,
      );
      if (user != null) {
        model = user;
        _emailController.text = model?.email ?? '';
        _addressController.text = model?.address ?? '123 Main St, Anytown, USA';
        _nameController.text = model?.name ?? '';
      }
      setState(() {
        isEditingProfile = false;
      });
    } catch (e) {
      String msg = 'Failed to update profile: ';
      if (e is DioException) {
        // Prefer message from response if available, otherwise generic
        final resp = e.response?.data;
        if (resp is Map && resp['message'] != null) {
          msg = resp['message'].toString();
        } else {
          msg = 'Server error, please try again later.'; // user-friendly
        }
      } else {
        msg = 'Unexpected error: ${e.toString()}';
      }
      if (mounted) {
        setState(() {
          isEditingProfile = false;
        });
        log(msg);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(msg)));
      }
    }
  }

  Future<void> getProfileData() async {
    try {
      setState(() {
        isLoading = true;
      });

      final user = await repo.getProfile();
      if (user != null) {
        model = user;
        _emailController.text = model?.email ?? '';
        _addressController.text = model?.address ?? '123 Main St, Anytown, USA';
        _nameController.text = model?.name ?? '';
      }
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      String msg;
      if (e is DioException) {
        final resp = e.response?.data;
        if (resp is Map && resp['message'] != null) {
          msg = resp['message'].toString();
        } else {
          msg = 'Server error, please try again later.';
        }
      } else {
        msg = 'Unexpected error: ${e.toString()}';
      }
      if (mounted) {
        setState(() {
          isLoading = false;
        });
        log(msg);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(msg)));
      }
    }
  }

  Future<void> logout() async {
    try {
      setState(() {
        isLoggingOut = true;
      });
      await repo.logout();
      if (mounted) {
        setState(() {
          isLoggingOut = false;
        });
        context.pushReplacementNamed(AppRoutes.login);
      }
    } catch (e) {
      String msg;
      if (e is DioException) {
        final resp = e.response?.data;
        if (resp is Map && resp['message'] != null) {
          msg = resp['message'].toString();
        } else {
          msg = 'Server error, please try again later.';
        }
      } else {
        msg = 'Unexpected error: ${e.toString()}';
      }
      if (mounted) {
        setState(() {
          isLoggingOut = false;
        });
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(msg)));
      }
    }
  }

  @override
  void initState() {
    super.initState();

    _emailController = TextEditingController();
    _nameController = TextEditingController();
    _addressController = TextEditingController();

    getProfileData();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Skeletonizer(
        enabled: isLoading,
        child: Scaffold(
          backgroundColor: AppColors.primaryColor,
          bottomSheet: Container(
            height: 100,
            color: AppColors.white,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: editProfile,
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
                          isEditingProfile
                              ? SizedBox(
                                  height: 24.h,
                                  width: 24.w,
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      color: AppColors.primaryColor,
                                    ),
                                  ),
                                )
                              : Icon(
                                  Icons.edit_square,
                                  color: AppColors.primaryColor,
                                ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: logout,
                    child: Container(
                      padding: 16.paddingAll,
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: AppColors.white, width: 1.5),
                      ),
                      child: Row(
                        children: [
                          CustomText(
                            text: LocaleKeys.logOut.tr(),
                            fontSize: 18,
                            color: AppColors.white,
                          ),
                          10.width,
                          isLoggingOut
                              ? SizedBox(
                                  height: 24.h,
                                  width: 24.w,
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      color: AppColors.white,
                                    ),
                                  ),
                                )
                              : Icon(
                                  Icons.logout_outlined,
                                  color: AppColors.white,
                                ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          appBar: AppBar(
            elevation: 0,
            scrolledUnderElevation: 0,
            leading: GestureDetector(
              onTap: () {},
              child: Icon(Icons.arrow_back, color: AppColors.white),
            ),
            backgroundColor: AppColors.primaryColor,
            actions: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.settings, color: AppColors.white),
              ),
            ],
          ),
          body: RefreshIndicator(
            onRefresh: () async {
              await getProfileData();
            },
            color: AppColors.lightPrimaryColor,
            backgroundColor: AppColors.white,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(
                parent: BouncingScrollPhysics(),
              ),
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  20.height,
                  Stack(
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
                              ? Image(
                                  image: FileImage(imageFile!),
                                  fit: BoxFit.fill,
                                )
                              : CachedNetworkImage(
                                  imageUrl: model?.image ?? '',
                                  fit: BoxFit.fill,
                                  placeholder: (context, url) => Center(
                                    child: CircularProgressIndicator(
                                      color: AppColors.primaryColor,
                                    ),
                                  ),
                                  errorWidget: (context, url, error) => Icon(
                                    Icons.person,
                                    size: 60,
                                    color: AppColors.grey,
                                  ),
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
                                onPressed: pickImage,
                                icon: Icon(
                                  CupertinoIcons.photo_camera_solid,
                                  color: AppColors.white,
                                  blendMode: BlendMode.srcOver,
                                  size: 26,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  38.height,
                  ProfileTextFieldSection(
                    nameController: _nameController,
                    emailController: _emailController,
                    addressController: _addressController,
                  ),
                  36.height,
                  SafeArea(
                    bottom: true,
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: 16.w,
                        right: 16.w,
                        bottom:
                            116, // Account for bottom sheet (100) + extra padding (16)
                      ),
                      child: CustomPaymentCard(
                        visaNumber: model?.visa,
                        selectedCard: 'visa',
                        onChanged: (value) {},
                      ),
                    ),
                  ),
                  36.height,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
