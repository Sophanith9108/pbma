import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pbma/core.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final controller = Get.put(() => HomeController());

  @override
  Widget build(BuildContext context) {
    return AppNavigation(
      body: RefreshIndicator(
        onRefresh: () => Future.delayed(const Duration(seconds: 2)),
        child: CustomScrollView(
          slivers: List.generate(5, (index) {
            return SliverStickyHeader(
              header: Container(
                height: 50,
                color: AppColors.primary,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(width: AppDimensions.padding),
                    Text(
                      DateTime(
                        DateTime.now().year,
                        DateTime.now().month,
                        DateTime.now().day + index,
                      ).format(pattern: "dd.MMM.yyyy"),
                      style: AppTextStyles.title,
                    ),
                  ],
                ),
              ),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  return ListTile(
                    onTap: () async {
                      await Future.delayed(const Duration(milliseconds: 300));
                      showModalBottomSheet(
                        context: Get.context!,
                        isScrollControlled: true,
                        useSafeArea: true,
                        builder: (_) {
                          return Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: AppDimensions.spadding,
                                  right: AppDimensions.spadding,
                                  top: AppDimensions.spadding,
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        'Title of the $index',
                                        style: AppTextStyles.header1,
                                      ),
                                    ),
                                    IconButton.outlined(
                                      onPressed: () {
                                        Get.back();
                                      },
                                      icon: Icon(FontAwesomeIcons.xmark),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: ListView(
                                  shrinkWrap: true,
                                  physics: const ScrollPhysics(),
                                  padding: const EdgeInsets.all(
                                    AppDimensions.padding,
                                  ),
                                  children: [
                                    Text(
                                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
                                      'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.'
                                      'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.'
                                      'Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.'
                                      'Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'
                                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit.'
                                      'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.'
                                      'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.'
                                      'Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.'
                                      'Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'
                                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit.'
                                      'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.'
                                      'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.'
                                      'Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.'
                                      'Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'
                                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit.'
                                      'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.'
                                      'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.'
                                      'Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.'
                                      'Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'
                                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit.'
                                      'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.'
                                      'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.'
                                      'Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.'
                                      'Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'
                                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit.'
                                      'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.'
                                      'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.'
                                      'Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.'
                                      'Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'
                                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit.'
                                      'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.'
                                      'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.'
                                      'Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.'
                                      'Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'
                                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit.'
                                      'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.'
                                      'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.'
                                      'Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.'
                                      'Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'
                                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit.'
                                      'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.'
                                      'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.'
                                      'Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.'
                                      'Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
                                      textAlign: TextAlign.justify,
                                      style: AppTextStyles.value,
                                      strutStyle: StrutStyle(height: 1.5),
                                    ),
                                    const SizedBox(
                                      height: AppDimensions.padding,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    leading: Icon(FontAwesomeIcons.tractor),
                    title: Text('Item $index', style: AppTextStyles.title),
                    subtitle: Text(
                      'Pay for food $index',
                      style: AppTextStyles.subtitle,
                    ),
                    trailing: Icon(
                      FontAwesomeIcons.chevronDown,
                      size: AppDimensions.miconSize,
                    ),
                  );
                }, childCount: 5),
              ),
            );
          }),
        ),
      ),
    );
  }
}
