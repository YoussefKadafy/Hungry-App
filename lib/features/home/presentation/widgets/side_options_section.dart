import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hungry/features/home/presentation/cubit/add_to_cart_cubit.dart';
import 'package:hungry/features/home/presentation/cubit/toppins_and_options_cubit.dart';
import 'package:hungry/features/home/presentation/cubit/toppins_and_options_states.dart';
import 'package:hungry/features/home/presentation/widgets/loading_toppings_and_options.dart';
import 'package:hungry/features/home/presentation/widgets/product_details_list_view_item.dart';

class SideOptionsSection extends StatelessWidget {
  const SideOptionsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsetsDirectional.only(start: 16.w),
          child: const Text(
            'Side options',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),

        BlocBuilder<ToppinsAndOptionsCubit, ToppingsAndOptionsStates>(
          builder: (context, state) {
            if (state is ToppingsAndOptionsError) {
              return Center(child: Text(state.message));
            }
            if (state is ToppingsAndOptionsSuccess) {
              final options = context.read<ToppinsAndOptionsCubit>().options;
              final selectedOptionsIds = context
                  .watch<AddToCartCubit>()
                  .optionsId;
              return SizedBox(
                height: 200.h,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: options.length,
                  padding: EdgeInsetsDirectional.only(start: 16.w),
                  clipBehavior: Clip.none,
                  itemBuilder: (context, index) {
                    final sideOptionItem = options[index];
                    return Align(
                      alignment:
                          Alignment.bottomCenter, // هيخلي الـ item يلزق تحت
                      child: ProductDetailsListViewItem(
                        selectedIds: selectedOptionsIds,
                        id: sideOptionItem.id,
                        title: sideOptionItem.title,
                        imagePath: sideOptionItem.image,
                        onAddPressed: () {
                          context.read<AddToCartCubit>().addOptionsId(
                            sideOptionItem.id,
                          );
                        },
                      ),
                    );
                  },
                ),
              );
            }
            return LoadingToppingsAndOptions();
          },
        ),
      ],
    );
  }
}
