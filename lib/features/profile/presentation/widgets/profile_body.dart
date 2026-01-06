import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hungry/core/shared/custom_payment_card.dart';
import 'package:hungry/core/utils/sized_box_extension.dart';
import 'package:hungry/features/auth/data/model/user_model.dart';
import 'package:hungry/features/auth/presentation/auth.dart';
import 'package:hungry/features/profile/presentation/widgets/photo_section.dart';

class ProfileBody extends StatelessWidget {
  const ProfileBody({
    super.key,
    required this.imageFile,
    required this.userModel,
    required TextEditingController nameController,
    required TextEditingController emailController,
    required TextEditingController addressController,
    this.imagePicker,
  }) : _nameController = nameController,
       _emailController = emailController,
       _addressController = addressController;

  final File? imageFile;
  final UserModel? userModel;
  final TextEditingController _nameController;
  final TextEditingController _emailController;
  final TextEditingController _addressController;
  final void Function()? imagePicker;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        20.height,
        PhotoSection(
          imageFile: imageFile,
          userModel: userModel,
          onPressed: imagePicker,
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
              visaNumber: userModel?.visa ?? '',
              selectedCard: 'visa',
              onChanged: (value) {},
            ),
          ),
        ),
        36.height,
      ],
    );
  }
}
