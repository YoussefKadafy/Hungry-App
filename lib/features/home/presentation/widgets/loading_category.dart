import 'package:flutter/material.dart';
import 'package:hungry/features/home/presentation/widgets/category_skelton.dart';

class LoadingCategory extends StatelessWidget {
  const LoadingCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      itemCount: 10,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsetsDirectional.only(end: 8.0),
          child: CategorySkeleton(),
        );
      },
    );
  }
}
