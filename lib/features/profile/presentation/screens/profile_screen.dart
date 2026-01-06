part of '../../../auth/presentation/auth.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late TextEditingController _emailController;
  late TextEditingController _nameController;
  late TextEditingController _addressController;
  UserModel? userModel;
  File? imageFile;
  final ImagePicker picker = ImagePicker();

  Future<void> pickImage() async {
    final XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );

    if (image != null) {
      setState(() {
        imageFile = File(image.path);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    context.read<ProfileCubit>().getProfile();

    _emailController = TextEditingController();
    _nameController = TextEditingController();
    _addressController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _nameController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: BlocConsumer<ProfileCubit, ProfileStates>(
        listener: (context, state) {
          if (state is ProfileSuccess) {
            _addressController.text =
                state.userModel.address ?? 'Enter your address ';
            _nameController.text = state.userModel.name;
            _emailController.text = state.userModel.email;
            userModel = state.userModel;
          }
        },
        builder: (context, state) {
          if (state is ProfileError) {
            return Center(child: CustomText(text: state.message, fontSize: 24));
          }

          return Skeletonizer(
            enabled: state is ProfileLoading,
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
                                Icon(
                                  Icons.edit_square,
                                  color: AppColors.primaryColor,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          padding: 16.paddingAll,
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: AppColors.white,
                              width: 1.5,
                            ),
                          ),
                          child: Row(
                            children: [
                              CustomText(
                                text: LocaleKeys.logOut.tr(),
                                fontSize: 18,
                                color: AppColors.white,
                              ),
                              10.width,
                              Icon(
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
                onRefresh: () async {},
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
                              border: Border.all(
                                color: AppColors.white,
                                width: 3,
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(60),
                              child: imageFile != null
                                  ? Image(
                                      image: FileImage(imageFile!),
                                      fit: BoxFit.fill,
                                    )
                                  : CachedNetworkImage(
                                      imageUrl: userModel?.image ?? '',
                                      fit: BoxFit.fill,
                                      placeholder: (context, url) => Center(
                                        child: CircularProgressIndicator(
                                          color: AppColors.primaryColor,
                                        ),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          Icon(
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
                            visaNumber: userModel?.visa ?? '',
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
          );
        },
      ),
    );
  }
}
