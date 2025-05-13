import 'package:flutter/material.dart';
import 'package:pbma/core.dart';

class AppNavigation extends StatelessWidget {
  const AppNavigation({
    super.key,
    this.title,
    this.body,
    this.floatingActionButton,
    this.bottomNavigationBar,
    this.leading,
    this.actions,
  });

  final String? title;
  final Widget? body;
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;
  final Widget? leading;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar:
            title == null
                ? null
                : AppBar(
                  leading: leading,
                  title: Text(title!, style: AppTextStyles.header),
                  actions: actions,
                  elevation: AppDimensions.elevation,
                ),
        floatingActionButton: floatingActionButton,
        body: body,
        bottomNavigationBar: bottomNavigationBar,
      ),
    );
  }
}
