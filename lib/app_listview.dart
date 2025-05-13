import 'package:flutter/material.dart';
import 'package:pbma/core.dart';

class AppListview extends StatelessWidget {
  const AppListview({
    super.key,
    required this.onFreshing,
    this.onLoadMore,
    this.onItemClick,
    required this.itemCount,
    required this.itemBuilder,
  });

  final Function onFreshing;
  final Function? onLoadMore;
  final Function? onItemClick;
  final int itemCount;
  final Widget Function(int index) itemBuilder;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      elevation: AppDimensions.elevation,
      onRefresh: () => onFreshing(),
      child: ListView.builder(
        itemCount: itemCount,
        itemBuilder: (context, index) => itemBuilder(index),
      ),
    );
  }
}
