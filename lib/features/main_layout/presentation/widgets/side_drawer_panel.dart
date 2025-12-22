import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:search_frontend/core/constants/index.dart';
import 'package:search_frontend/core/utils/index.dart';

class SideDrawerPanel extends StatelessWidget {
  const SideDrawerPanel({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Drawer(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.only(
          bottomRight: Radius.circular(AppRadius.medium),
          topRight: Radius.circular(AppRadius.medium),
        ),
      ),
      elevation: 0,
      width: double.infinity,
      backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 100,
            child: DrawerHeader(
              margin: EdgeInsets.zero,
              padding: EdgeInsetsGeometry.symmetric(
                horizontal: AppPadding.small,
              ),

              child: Image.asset("assets/logo.png"),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(AppPadding.small + 2),
              child: Column(
                children: [
                  ...List.generate(drawerItems.length, (index) {
                    final item = drawerItems[index];
                    return ListTileWidget(
                      assetPath: item.assetPath,
                      title: item.title,
                      onTap: () {
                        context.go(item.route);
                      },
                      selected: isRouteSelected(item, context),
                      //  GoRouterState.of(
                      //   context,
                      // ).uri.toString().startsWith("/directory"),
                    );
                  }),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(AppPadding.small + 2),
            child: ListTile(
              leading: Icon(Icons.logout),
              onTap: () => context.go("/login"),
              title: Text("Выход"),
            ),
          ),
        ],
      ),
    );
  }

  bool isRouteSelected(DrawerItemData item, BuildContext context) {
    final currentPath = GoRouterState.of(context).uri.toString();
    final splitCurrent = currentPath.split("/");
    final normalizedRoute = item.route.split('/');

    return splitCurrent[1] == normalizedRoute[1];
  }
}

class ListTileWidget extends StatelessWidget {
  final String assetPath;
  final String title;
  final VoidCallback onTap;
  final bool selected;

  const ListTileWidget({
    super.key,
    required this.assetPath,
    required this.title,
    required this.onTap,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SvgPicture.asset(
        assetPath,
        colorFilter: ColorFilter.mode(
          Theme.of(context).listTileTheme.selectedColor!,
          BlendMode.srcIn,
        ),
      ),
      onTap: onTap,
      title: Text(title),
      selected: selected,
    );
  }
}
