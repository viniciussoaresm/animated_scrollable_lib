import 'package:flutter/material.dart';

typedef HeaderBuilder =
    Widget Function(BuildContext context, double shrinkOffset, double percent);

class AnimatedHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double maxHeight;
  final double minHeight;
  final HeaderBuilder builder;

  AnimatedHeaderDelegate({
    required this.maxHeight,
    required this.minHeight,
    required this.builder,
  });

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final double range = maxHeight - minHeight;
    final double percent = range > 0
        ? (maxHeight - shrinkOffset - minHeight) / range
        : 0.0;

    final double clampedPercent = percent.clamp(0.0, 1.0);

    return ClipRect(
      child: OverflowBox(
        minHeight: minHeight,
        maxHeight: maxHeight,
        // Mudança crucial: topCenter faz o header parecer fixo no topo
        alignment: Alignment.topCenter,
        child: SizedBox(
          height: maxHeight,
          width: double.infinity,
          child: builder(context, shrinkOffset, clampedPercent),
        ),
      ),
    );
  }

  @override
  double get maxExtent => maxHeight;

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(covariant AnimatedHeaderDelegate oldDelegate) => true;
}
