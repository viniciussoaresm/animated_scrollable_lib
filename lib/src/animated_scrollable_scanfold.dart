import 'package:flutter/material.dart';
import 'animated_header_delegate.dart';

class AnimatedScrollableScanfold extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final HeaderBuilder header;
  final List<Widget> items;
  final Widget? bottomWidget;
  final double expandedHeight;
  final double? collapsedHeight;
  final BoxDecoration? decoration;
  final EdgeInsetsGeometry? padding;

  final double _finalCollapsedHeight;

  const AnimatedScrollableScanfold({
    super.key,
    this.appBar,
    required this.header,
    required this.items,
    this.bottomWidget,
    this.expandedHeight = 200.0,
    this.collapsedHeight,
    this.decoration,
    this.padding = const EdgeInsets.all(0),
  }) : _finalCollapsedHeight =
           collapsedHeight ?? (appBar != null ? 0.0 : kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SizedBox(
          height: constraints.maxHeight,
          width: constraints.maxWidth,
          child: Scaffold(
            appBar: appBar,
            body: Container(
              decoration: decoration,
              child: Column(
                children: [
                  Expanded(
                    child: CustomScrollView(
                      physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics(),
                      ),
                      slivers: [
                        SliverPersistentHeader(
                          pinned: true,
                          floating: false,
                          delegate: AnimatedHeaderDelegate(
                            maxHeight: expandedHeight,
                            minHeight: _finalCollapsedHeight,
                            builder: header,
                          ),
                        ),
                        SliverPadding(
                          padding: padding ?? EdgeInsets.zero,
                          sliver: SliverList(
                            delegate: SliverChildListDelegate(items),
                          ),
                        ),
                        const SliverToBoxAdapter(child: SizedBox(height: 120)),
                      ],
                    ),
                  ),
                  if (bottomWidget != null)
                    SafeArea(top: false, child: bottomWidget!),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
