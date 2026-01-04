import 'package:flutter/material.dart';
import 'package:hungry/features/home/presentation/widgets/grid_view_item.dart';

class LoadingHomeData extends StatelessWidget {
  const LoadingHomeData({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverGrid.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.68,
      ),
      itemCount: 6,
      itemBuilder: (context, index) => GridShimmerItem(),
    );
  }
}
