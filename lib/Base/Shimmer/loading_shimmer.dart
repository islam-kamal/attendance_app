import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingPlaceHolder extends StatelessWidget {
  final double? cellShimmerHeight;
  final double? cellShimmerWidth;
  final int? shimmerCount;
  final ShimmerType shimmerType;
  final EdgeInsets? padding;

  const LoadingPlaceHolder({
    Key? key,
    this.cellShimmerHeight,
    this.cellShimmerWidth,
    this.shimmerCount,
    this.padding,
    required this.shimmerType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 10),
      child: (shimmerType == ShimmerType.list)
          ? ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return ShimmerBase(
            cellShimmerHeight: cellShimmerHeight,
            cellShimmerWidth: cellShimmerWidth,
          );
        },
        separatorBuilder: (context, index) => const SizedBox(height: 10),
        itemCount: shimmerCount ?? 0,
      )
          : GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return ShimmerBase(
            cellShimmerHeight: cellShimmerHeight,
            cellShimmerWidth: cellShimmerWidth,
          );
        },
        itemCount: shimmerCount ?? 0,
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: cellShimmerWidth ?? 300.0,
          crossAxisSpacing: 15.0,
          mainAxisSpacing: 15.0,
          childAspectRatio: 16/9,
          mainAxisExtent: cellShimmerHeight ?? 70,
        ),
      ),
    );
  }
}


class ShimmerBase extends StatelessWidget {
  const ShimmerBase({
    Key? key,
    required this.cellShimmerHeight,
    required this.cellShimmerWidth,
  }) : super(key: key);

  final double? cellShimmerHeight;
  final double? cellShimmerWidth;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: const Color(0xffEBECF1).withOpacity(.4),
      highlightColor: const Color(0xffEBECF1).withOpacity(.5),
      enabled: true,
      child: Container(
        height: cellShimmerHeight ?? 0,
        width: cellShimmerWidth ?? 0,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
          color: Colors.white,
        ),
      ),
    );
  }
}

enum ShimmerType {
  grid,
  list,
}
