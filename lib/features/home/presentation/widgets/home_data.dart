import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hungry/core/routing/app_routes.dart';
import 'package:hungry/core/shared/custom_text.dart';
import 'package:hungry/features/home/presentation/cubit/get_products_cubit.dart';
import 'package:hungry/features/home/presentation/cubit/praducts_state.dart';
import 'package:hungry/features/home/presentation/widgets/grid_view_item.dart';
import 'package:hungry/features/home/presentation/widgets/loading_home_data.dart';

class HomeData extends StatelessWidget {
  const HomeData({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetProductsCubit, ProductState>(
      builder: (context, state) {
        if (state is ProductError) {
          return Center(child: CustomText(text: state.message, fontSize: 24));
        }
        if (state is ProductSuccess) {
          return SliverGrid.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.68,
            ),
            itemCount: state.productModel.length,

            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => context.pushNamed(
                  AppRoutes.productDetails,
                  extra: state.productModel[index],
                ),
                child: GridViewItem(product: state.productModel[index]),
              );
            },
          );
        }
        return LoadingHomeData();
      },
    );
  }
}
