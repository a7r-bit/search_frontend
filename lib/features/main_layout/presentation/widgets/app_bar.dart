import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search_frontend/core/constants/constants.dart';
import 'package:search_frontend/core/constants/padding.dart';
import 'package:search_frontend/core/utils/index.dart';
import 'package:search_frontend/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:search_frontend/features/auth/presentation/cubit/auth_state.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final GlobalKey<ScaffoldState> drawerKey;

  const AppBarWidget({required this.drawerKey, super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
      leading: IconButton(
        icon: Icon(Icons.menu, color: Theme.of(context).colorScheme.onSurface),
        onPressed: () => drawerKey.currentState?.openDrawer(),
      ),
      actions: [HeaderSidePanel(), SizedBox(width: 10)],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class HeaderSidePanel extends StatelessWidget {
  const HeaderSidePanel({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        final user = state.user;

        if (user == null) {
          return const SizedBox();
        }
        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "${user.firstName} ${user.middleName}",
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                Text(
                  user.activeRole,
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ],
            ),
            SizedBox(width: AppPadding.small + 2),
            CircleAvatar(
              backgroundColor: brightColorFromString(
                "${user.firstName[0]}${user.middleName[0]}",
              ),
              child: Text(
                "${user.firstName[0]}${user.middleName[0]}",
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ),
            SizedBox(width: AppPadding.small + 2),
            MenuAnchor(
              builder: (context, controller, child) {
                return IconButton(
                  icon: const Icon(Icons.keyboard_arrow_down),
                  onPressed: () {
                    if (controller.isOpen) {
                      controller.close();
                    } else {
                      controller.open();
                    }
                  },
                );
              },

              menuChildren: [
                user.roles.length > 1
                    ? SubmenuButton(
                        menuChildren: [
                          ...List.generate(user.roles.length, (index) {
                            return MenuItemButton(
                              onPressed: () {
                                context.read<AuthCubit>().switchRole(
                                  user.roles[index],
                                );
                              },
                              child: Text(user.roles[index]),
                            );
                          }),
                        ],
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Активная роль",
                              style: Theme.of(context).textTheme.labelSmall,
                            ),
                            Text(
                              user.activeRole,
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                          ],
                        ),
                      )
                    : MenuItemButton(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Активная роль",
                              style: Theme.of(context).textTheme.labelSmall,
                            ),
                            Text(
                              user.activeRole,
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                          ],
                        ),
                      ),
              ],
            ),
          ],
        );
      },
    );
  }
}
