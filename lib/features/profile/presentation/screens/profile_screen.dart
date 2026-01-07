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
              backgroundColor: AppColors.white,
              bottomSheet: ProfileBottomSheet(
                nameController: _nameController,
                addressController: _addressController,
                emailController: _emailController,
                imageFile: imageFile,
              ),
              appBar: AppBar(
                elevation: 0,
                scrolledUnderElevation: 0,
                leading: GestureDetector(
                  onTap: () {},
                  child: Icon(Icons.arrow_back, color: AppColors.primaryColor),
                ),
                backgroundColor: AppColors.white,
                actions: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.settings, color: AppColors.primaryColor),
                  ),
                ],
              ),
              body: RefreshIndicator(
                onRefresh: () async {
                  context.read<ProfileCubit>().getProfile();
                },
                color: AppColors.lightPrimaryColor,
                backgroundColor: AppColors.white,
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(
                    parent: BouncingScrollPhysics(),
                  ),
                  scrollDirection: Axis.vertical,
                  child: ProfileBody(
                    imagePicker: pickImage,
                    imageFile: imageFile,
                    userModel: userModel,
                    nameController: _nameController,
                    emailController: _emailController,
                    addressController: _addressController,
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
