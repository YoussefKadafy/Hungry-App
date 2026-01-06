import 'package:flutter/material.dart';
import 'package:hungry/core/utils/sized_box_extension.dart';
import 'package:hungry/features/home/presentation/widgets/heading_widget.dart';
import 'package:hungry/features/home/presentation/widgets/home_data.dart';
import 'package:hungry/features/home/presentation/widgets/home_category_list_view_section.dart';
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
                SliverToBoxAdapter(child: HeadingWidget()),
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
