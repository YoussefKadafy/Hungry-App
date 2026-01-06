part of '../../../auth/presentation/auth.dart';

class ProfileTextFieldSection extends StatelessWidget {
  const ProfileTextFieldSection({
    super.key,
    required TextEditingController nameController,
    required TextEditingController emailController,
    required TextEditingController addressController,
  }) : _nameController = nameController,
       _emailController = emailController,
       _addressController = addressController;

  final TextEditingController _emailController;
  final TextEditingController _addressController;
  final TextEditingController _nameController;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: 16.paddingHorizontal,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomProfileTextField(
            controller: _nameController,
            labelText: 'Name',
            textColor: AppColors.black,
          ),
          25.height,
          CustomProfileTextField(
            controller: _emailController,
            labelText: 'Email',
            textColor: AppColors.black,
          ),

          25.height,

          CustomProfileTextField(
            controller: _addressController,
            labelText: 'Address',
            textColor: AppColors.black,
          ),
          34.height,
          Divider(thickness: 1.5, color: AppColors.black),
        ],
      ),
    );
  }
}
