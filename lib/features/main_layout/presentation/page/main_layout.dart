import 'package:flutter/material.dart';
import 'package:search_frontend/core/constants/index.dart';
import 'package:search_frontend/core/utils/index.dart';
import 'package:search_frontend/features/main_layout/presentation/widgets/index.dart';

class MainLayout extends StatelessWidget {
  final Widget child;
  final Widget? headerWidget;
  final GlobalKey<ScaffoldState> drawerKey = GlobalKey<ScaffoldState>();

  MainLayout({super.key, required this.child, this.headerWidget});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: drawerKey,
      drawer: SizedBox(width: 200, child: SideDrawerPanel()),
      appBar: !Responsive.isDesktop(context)
          ? AppBarWidget(drawerKey: drawerKey)
          : PreferredSize(preferredSize: Size.zero, child: SizedBox()),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (Responsive.isDesktop(context))
              Expanded(flex: 2, child: SideDrawerPanel()),
            Expanded(
              flex: 14,
              child: Padding(
                padding: EdgeInsets.all(AppPadding.small + 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    if (Responsive.isDesktop(context))
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (headerWidget != null)
                            Flexible(child: headerWidget!),

                          if (headerWidget != null)
                            const SizedBox(width: AppPadding.small + 2),
                          HeaderSidePanel(),
                        ],
                      ),

                    if (Responsive.isDesktop(context))
                      SizedBox(height: AppPadding.small + 2),
                    Expanded(child: child),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
