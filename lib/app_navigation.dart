import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pbma/core.dart';

class AppNavigation extends StatelessWidget {
  AppNavigation({
    super.key,
    this.title,
    this.subtitle,
    this.body,
    this.floatingActionButton,
    this.bottomNavigationBar,
    this.leading,
    this.actions,
  });

  final String? title;
  final String? subtitle;
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
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(title!, style: AppTextStyles.header),
                      Visibility(
                        visible: subtitle != null,
                        child: Text(
                          subtitle ?? "",
                          style: AppTextStyles.subtitle,
                        ),
                      ),
                    ],
                  ),
                  actions: actions,
                  elevation: AppDimensions.elevation,
                ),
        floatingActionButton: floatingActionButton,
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        body: body,
        bottomNavigationBar: bottomNavigationBar,
      ),
    );
  }
}
