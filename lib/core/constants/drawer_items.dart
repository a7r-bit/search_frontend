class DrawerItemData {
  final String assetPath;
  final String title;
  final String route;

  DrawerItemData({
    required this.assetPath,
    required this.title,
    required this.route,
  });
}

final drawerItems = [
  DrawerItemData(
    assetPath: "assets/icons/drawer_folder.svg",
    title: "Документы",
    route: "/node/root",
  ),
  DrawerItemData(
    assetPath: "assets/icons/users.svg",
    title: "Пользователи",
    route: "/users",
  ),
  DrawerItemData(
    assetPath: "assets/icons/admin_panel.svg",
    title: "Администрирование",
    route: "/admin",
  ),
  DrawerItemData(
    assetPath: "assets/icons/help.svg",
    title: "Помощь",
    route: "/help",
  ),
];
