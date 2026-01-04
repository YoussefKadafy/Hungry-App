import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hungry/features/home/presentation/cubit/add_to_cart_cubit.dart';
import 'package:hungry/features/home/presentation/cubit/toppins_and_options_cubit.dart';
import 'package:hungry/features/home/presentation/cubit/toppins_and_options_states.dart';
import 'package:hungry/features/home/presentation/widgets/product_details_list_view_item.dart';

class ToppingSection extends StatelessWidget {
  const ToppingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsetsDirectional.only(start: 16.w),
          child: const Text(
            'Toppings',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),

        // ListView.builder للـ toppings
        BlocBuilder<ToppinsAndOptionsCubit, ToppingsAndOptionsStates>(
          builder: (context, state) {
            if (state is ToppingsAndOptionsError) {
              return Center(child: Text(state.message));
            }
            if (state is ToppingsAndOptionsSuccess) {
              final toppings = context.read<ToppinsAndOptionsCubit>().toppings;
              return SizedBox(
                height: 200.h,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: toppings.length,
                  padding: EdgeInsetsDirectional.only(start: 16.w),
                  itemBuilder: (context, index) {
                    final toppingItem = toppings[index];
                    return Align(
                      alignment:
                          Alignment.bottomCenter, // هيخلي الـ item يلزق تحت
                      child: ProductDetailsListViewItem(
                        selectedIds: context.watch<AddToCartCubit>().toppingsId,
                        id: toppingItem.id,
                        title: toppingItem.title,
                        imagePath: toppingItem.image,
                        onAddPressed: () {
                          context.read<AddToCartCubit>().addToppingsId(
                            toppingItem.id,
                          );
                        },
                      ),
                    );
                  },
                ),
              );
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ],
    );
  }
}
