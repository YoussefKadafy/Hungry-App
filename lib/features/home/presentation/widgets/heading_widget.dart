import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hungry/core/consts/app_colors.dart';
import 'package:hungry/core/shared/custom_text.dart';
import 'package:hungry/core/translations/locale_keys.g.dart';
import 'package:hungry/core/utils/sized_box_extension.dart';
import 'package:hungry/features/home/presentation/widgets/welcomming_shimmer_for_heading_home.dart';
import 'package:hungry/features/profile/presentation/cubit/get_profile_states.dart';
import 'package:hungry/features/profile/presentation/cubit/profile_cubit.dart';

class HeadingWidget extends StatefulWidget {
  const HeadingWidget({super.key});

  @override
  State<HeadingWidget> createState() => _HeadingWidgetState();
}

class _HeadingWidgetState extends State<HeadingWidget> {
  @override
  void initState() {
    super.initState();
    context.read<ProfileCubit>().getProfile();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileStates>(
      builder: (context, state) {
        if (state is ProfileError) {
          return Center(child: CustomText(text: state.message, fontSize: 24));
        }

        if (state is ProfileSuccess) {
          final firstName = state.userModel.name.split(' ')[0];
          final image = state.userModel.image;

          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: "${LocaleKeys.welcome.tr()},",
                    fontSize: 18,
                    color: AppColors.grey,
                  ),
                  5.height,
                  CustomText(
                    text:
                        'Are you Hungry $firstName ? \nYou\'ve come to the right place',
                    fontSize: 18,
                    color: AppColors.darkPrimaryColor,
                  ),
                ],
              ),
              CircleAvatar(
                radius: 35.r,
                child: ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: image ?? '',

                    fit: BoxFit.cover,
                    width: 70,
                    height: 70,
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
            ],
          );
        }

        return WelcomingShimmerForHeadingHome();
      },
    );
  }
}
