import 'package:flutter/material.dart';

import '../constants/activate_constant.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const MyAppBar({Key? key, required this.title}) : super(key: key);
  @override
  Size get preferredSize => const Size.fromHeight(60.0);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
        icon: const Icon(
          Icons.search,
          size: 35,

        ),
        tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
      ),
      title: Text(
        title,
        style: const TextStyle(color: Colors.black),
      ),
      centerTitle: true,
      backgroundColor: activeColors.background,
      elevation: 0,
    );
  }
}
