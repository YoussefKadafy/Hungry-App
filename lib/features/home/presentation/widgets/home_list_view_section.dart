import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hungry/features/home/data/model/category_model.dart';
import 'package:hungry/features/home/presentation/widgets/custom_list_view.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomeListViewSection extends StatefulWidget {
  const HomeListViewSection({
    super.key,
    required this.categories,
    required this.isLoading,
  });

  final List<CategoryModel> categories;
  final bool isLoading;

  @override
  State<HomeListViewSection> createState() => _HomeListViewSectionState();
}

int selectedIndex = 0;

class _HomeListViewSectionState extends State<HomeListViewSection> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36.h,
      child: Skeletonizer(
        enabled: widget.isLoading,
        child: ListView.builder(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: widget.isLoading ? 5 : widget.categories.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsetsDirectional.only(end: 8.0),
              child: widget.isLoading
                  ? _CategorySkeleton()
                  : CustomListViewItem(
                      isSelected: selectedIndex == index,
                      onPressed: () {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                      text: widget.categories[index].name,
                    ),
            );
          },
        ),
      ),
    );
  }
}

class _CategorySkeleton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80.w,
      height: 36.h,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
}
