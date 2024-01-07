import 'package:flutter/material.dart';

class BottomNav extends StatelessWidget {
  final PageController pageController;

  const BottomNav({super.key, required this.pageController});

  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).primaryColor;

    return BottomAppBar(
      color: color,
      shape: const CircularNotchedRectangle(),
      notchMargin: 5.0,
      height: 70,
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: SizedBox(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width / 2 - 20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: () {
                      pageController.animateToPage(0,
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.bounceInOut);
                    },
                    icon: const Icon(Icons.home, size: 35,),
                  ),
                  IconButton(
                    onPressed: () {
                      pageController.animateToPage(1,
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.bounceInOut);
                    },
                    icon: const Icon(Icons.bar_chart, size: 35,),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 2 - 20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: () {
                      pageController.animateToPage(2,
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.bounceInOut);
                    },
                    icon: const Icon(Icons.person, size: 35,),
                  ),
                  IconButton(
                    onPressed: () {
                      pageController.animateToPage(3,
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.bounceInOut);
                    },
                    icon: const Icon(Icons.bookmark, size: 35,),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
