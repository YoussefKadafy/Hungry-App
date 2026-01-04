import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hungry/core/shared/custom_text.dart';
import 'package:hungry/features/home/presentation/cubit/category_cubit.dart';
import 'package:hungry/features/home/presentation/cubit/category_state.dart';
import 'package:hungry/features/home/presentation/widgets/Loading_category.dart';
import 'package:hungry/features/home/presentation/widgets/custom_list_view.dart';

class HomeCategoryListViewSection extends StatelessWidget {
  const HomeCategoryListViewSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36.h,
      child: BlocBuilder<CategoryCubit, CategoryState>(
        builder: (context, state) {
          if (state is CategoryError) {
            return Center(child: CustomText(text: state.message, fontSize: 24));
          }
          if (state is CategorySuccess) {
            return ListView.builder(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: state.categories.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsetsDirectional.only(end: 8.0),
                  child: CustomListViewItem(
                    index: index,
                    isSelected: state.selectedIndex == index,

                    text: state.categories[index].name,
                  ),
                );
              },
            );
          }
          return LoadingCategory();
        },
      ),
    );
  }
}
