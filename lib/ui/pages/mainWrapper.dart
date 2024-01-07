import 'package:exchange/ui/pages/SignUpPage.dart';
import 'package:exchange/ui/pages/homePage.dart';
import 'package:exchange/ui/pages/marketPage.dart';
import 'package:exchange/ui/pages/profilePage.dart';
import 'package:exchange/ui/pages/watchList.dart';
import 'package:flutter/material.dart';

import '../ui_helpers/themeSwitcher.dart';
import '../ui_helpers/bottomNav.dart';

class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  final PageController _pageController = PageController();

  PageController get pageController => _pageController;

  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).primaryColor;
    TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Exchange 2Byte', style: textTheme.titleLarge),
        centerTitle: true,
        actions: const [ThemeSwitcher()],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: color,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        child: const Icon(
          Icons.swap_horiz_outlined,
          size: 35,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNav(pageController: pageController),
      body: PageView(
        controller: pageController,
        children: const [
          HomePage(),
          MarketViewPage(),
          ProfilePage(),
          WatchList()
        ],
      ),
    );
  }
}
