import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class GridSkeleton extends StatelessWidget {
  final int itemCount;

  const GridSkeleton({Key? key, this.itemCount = 9}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 1,
        crossAxisSpacing: 1,
        childAspectRatio: 0.7,
      ),
      itemCount: itemCount,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[800]!,
          highlightColor: Colors.grey[600]!,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[900],
            ),
          ),
        );
      },
    );
  }
}
