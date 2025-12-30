import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hungry/core/routing/app_routes.dart';
import 'package:hungry/core/utils/sized_box_extension.dart';
import 'package:hungry/features/auth/data/repo/auth_repo.dart';
import 'package:hungry/features/home/data/model/category_model.dart';
import 'package:hungry/features/home/data/model/product_model.dart';
import 'package:hungry/features/home/data/repo/home_repo.dart';
import 'package:hungry/features/home/presentation/widgets/grid_view_item.dart';
import 'package:hungry/features/home/presentation/widgets/heading_widget.dart';
import 'package:hungry/features/home/presentation/widgets/home_list_view_section.dart';
import 'package:hungry/features/home/presentation/widgets/search_field_widget.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<CategoryModel> categories = [];
  HomeRepo repo = HomeRepo();
  bool isLoading = true;

  bool isFetchingUserData = false;
  String? userName, image;
  List<ProductModel> productsList = [];
  List<ProductModel> allProducts = [];

  Future<void> fetchCategories() async {
    final fetchedCategories = await repo.fetchCategories();
    categories.addAll(fetchedCategories);
    setState(() {
      isLoading = false;
    });
  }

  Future<void> fetchAllProducts() async {
    final products = await repo.fetchAllProducts();
    productsList.addAll(products);
    allProducts.addAll(products);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetchCategories();
    fetchAllProducts();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Skeletonizer(
        enabled: isLoading && productsList.isEmpty && isFetchingUserData,
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
                      userName: userName ?? '',
                      image: image ?? '',
                    ),
                  ),
                  SliverToBoxAdapter(child: 17.height),

                  SliverToBoxAdapter(
                    child: SearchFieldWidget(
                      onChanged: (value) {
                        setState(() {
                          if (value.isEmpty) {
                            productsList = allProducts;
                          } else {
                            productsList = allProducts
                                .where(
                                  (product) => product.name
                                      .toLowerCase()
                                      .contains(value.toLowerCase()),
                                )
                                .toList();
                          }
                        });
                      },
                    ),
                  ),
                  SliverToBoxAdapter(child: 17.height),
                  SliverToBoxAdapter(
                    child: HomeListViewSection(
                      categories: categories,
                      isLoading: isLoading,
                    ),
                  ),
                  SliverToBoxAdapter(child: 17.height),

                  SliverGrid.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio: 0.68,
                        ),
                    itemCount: productsList.isEmpty ? 6 : productsList.length,

                    itemBuilder: (context, index) {
                      if (productsList.isEmpty) {
                        return const GridShimmerItem();
                      }
                      final product = productsList[index];
                      return GestureDetector(
                        onTap: () => context.pushNamed(
                          AppRoutes.productDetails,
                          extra: product,
                        ),
                        child: GridViewItem(product: product),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
