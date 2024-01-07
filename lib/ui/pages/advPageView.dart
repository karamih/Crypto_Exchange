import 'package:flutter/material.dart';

class AdvertisementPageView extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final pageController;

  const AdvertisementPageView({super.key, required this.pageController});

  @override
  State<AdvertisementPageView> createState() => _AdvertisementPageViewState();
}

class _AdvertisementPageViewState extends State<AdvertisementPageView> {
  List<String> images = [
    "assets/images/btc.jpg",
    "assets/images/usdt.jpg",
    "assets/images/nft.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: widget.pageController,
      allowImplicitScrolling: true,
      children: [
        advertisement(images[0]),
        advertisement(images[1]),
        advertisement(images[2])
      ],
    );
  }

  Widget advertisement(String img) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Image.asset(img, fit: BoxFit.fill),
    );
  }
}
