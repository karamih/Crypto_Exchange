import 'package:exchange/providers/themeSwitcherProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThemeSwitcher extends StatelessWidget {
  const ThemeSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    final themeSwitcherProvider = Provider.of<ThemeSwitcherProvider>(context);
    Icon themeSwitcherIcon = Icon(
      themeSwitcherProvider.isDarkMode
          ? CupertinoIcons.moon_fill
          : CupertinoIcons.sun_max_fill,
    );

    return IconButton(
        onPressed: () {
          themeSwitcherProvider.toggleTheme();
        },
        icon: themeSwitcherIcon);
  }
}
