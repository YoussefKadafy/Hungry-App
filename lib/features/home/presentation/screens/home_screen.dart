import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hungry/core/routing/app_routes.dart';
import 'package:hungry/core/shared/custom_text.dart';
import 'package:hungry/core/utils/sized_box_extension.dart';
import 'package:hungry/features/home/presentation/cubit/category_cubit.dart';
import 'package:hungry/features/home/presentation/cubit/get_products_cubit.dart';
import 'package:hungry/features/home/presentation/cubit/praducts_state.dart';
import 'package:hungry/features/home/presentation/widgets/grid_view_item.dart';
import 'package:hungry/features/home/presentation/widgets/heading_widget.dart';
import 'package:hungry/features/home/presentation/widgets/home_data.dart';
import 'package:hungry/features/home/presentation/widgets/home_list_view_section.dart';
import 'package:hungry/features/home/presentation/widgets/search_field_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: 16.paddingAll,
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(child: 17.height),
                SliverToBoxAdapter(
                  child: HeadingWidget(
                    userName: 'userName' ?? '',
                    image: 'image' ?? '',
                  ),
                ),
                SliverToBoxAdapter(child: 17.height),

                SliverToBoxAdapter(
                  child: SearchFieldWidget(onChanged: (value) {}),
                ),
                SliverToBoxAdapter(child: 17.height),
                SliverToBoxAdapter(child: HomeCategoryListViewSection()),
                SliverToBoxAdapter(child: 17.height),

                HomeData(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
