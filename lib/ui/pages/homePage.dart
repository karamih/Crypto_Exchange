import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:exchange/models/CryptoData.dart';
import 'package:exchange/providers/cryptoDataProvider.dart';
import 'package:exchange/ui/pages/advPageView.dart';
import 'package:exchange/ui/ui_helpers/shimmer_effect.dart';
import 'package:exchange/utilities/decimal_rounder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:marquee/marquee.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:exchange/network/responseModel.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController();

  PageController get pageController => _pageController;

  int currentChoice = 0;
  final List<String> choices = ['Top Market Cap', 'Top Gainers', 'Top Losers'];

  late CryptoDataProvider cryptoDataProvider;
  late Timer timer;

  @override
  void initState() {
    super.initState();

    cryptoDataProvider =
        Provider.of<CryptoDataProvider>(context, listen: false);
    cryptoDataProvider.getTopMarketCapData();

    timer = Timer.periodic(const Duration(seconds: 10), (timer) {
      cryptoDataProvider.getAllData();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    Color primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
        body: SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 5, 8, 0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 180,
                  child: AdvertisementPageView(
                    pageController: pageController,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: SmoothPageIndicator(
                    count: 3,
                    controller: pageController,
                    effect: const ExpandingDotsEffect(
                        activeDotColor: Colors.amber,
                        dotHeight: 10,
                        dotWidth: 10,
                        dotColor: Colors.white),
                    onDotClicked: (index) {
                      pageController.animateToPage(index,
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.bounceInOut);
                    },
                  ),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 20,
            child: Marquee(
              text: 'This is 2Byte exchange a place for create money.',
              style: textTheme.bodySmall,
              scrollAxis: Axis.horizontal,
              crossAxisAlignment: CrossAxisAlignment.start,
              blankSpace: 20.0,
              velocity: 100.0,
              pauseAfterRound: const Duration(seconds: 1),
              startPadding: 10.0,
              accelerationDuration: const Duration(seconds: 1),
              accelerationCurve: Curves.linear,
              decelerationDuration: const Duration(milliseconds: 500),
              decelerationCurve: Curves.easeOut,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8, left: 8),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          padding: const EdgeInsets.only(top: 20, bottom: 20),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                      child: Text(
                        'Buy',
                        style: textTheme.bodySmall,
                      )),
                ),
                const SizedBox(
                  width: 5,
                ),
                Expanded(
                    child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            padding: const EdgeInsets.only(top: 20, bottom: 20),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20))),
                        child: Text('Sell', style: textTheme.bodySmall)))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
            child: Wrap(
              spacing: 5,
              children: List.generate(choices.length, (index) {
                return ChoiceChip(
                  label: Text(
                    choices[index],
                    style: textTheme.bodySmall,
                  ),
                  selected: currentChoice == index,
                  selectedColor: primaryColor,
                  backgroundColor: Colors.grey,
                  labelStyle: textTheme.bodySmall,
                  padding: const EdgeInsets.only(top: 5, bottom: 5),
                  onSelected: (value) {
                    setState(() {
                      currentChoice = value ? index : currentChoice;
                      switch (index) {
                        case 0:
                          cryptoDataProvider.getTopMarketCapData();
                        case 1:
                          cryptoDataProvider.getTopGainersData();
                        case 2:
                          cryptoDataProvider.getTopLosersData();
                      }
                    });
                  },
                );
              }),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          SizedBox(
            height: 500,
            child: Consumer<CryptoDataProvider>(
              builder: (context, value, child) {
                switch (value.state.status) {
                  case Status.LOADING:
                    return const ShimmerEffect();

                  case Status.COMPLETED:
                    List<CryptoData>? model =
                        cryptoDataProvider.dataFuture.data!.cryptoCurrencyList;
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                      child: SizedBox(
                        height: 100,
                        child: ListView.separated(
                            itemBuilder: (context, index) {
                              int number = index + 1;
                              int? tokenId = model[index].id;

                              MaterialColor percentChangeColor =
                                  DecimalRounder.setColorFilter(
                                      model[index].quotes![0].percentChange24h);

                              String finalPrice =
                                  DecimalRounder.removePriceDecimals(
                                      model[index].quotes![0].price);

                              String finalPercent =
                                  DecimalRounder.removePercentDecimals(
                                      model[index].quotes![0].percentChange24h);

                              Icon percentIcon =
                                  DecimalRounder.setPercentChangesIcon(
                                      model[index].quotes![0].percentChange24h);

                              return Row(
                                children: [
                                  SizedBox(
                                    width: 60,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          number.toString(),
                                          style: textTheme.bodySmall,
                                        ),
                                        CachedNetworkImage(
                                          imageUrl:
                                              'https://s2.coinmarketcap.com/static/img/coins/32x32/$tokenId.png',
                                          fadeInDuration:
                                              const Duration(milliseconds: 300),
                                          width: 32,
                                          height: 32,
                                          fit: BoxFit.fill,
                                          placeholder: (context, url) =>
                                              const CircularProgressIndicator(),
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.error),
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Flexible(
                                    fit: FlexFit.tight,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          model[index].name.toString(),
                                          style: textTheme.bodySmall,
                                        ),
                                        Text(
                                          model[index].symbol.toString(),
                                          style: textTheme.labelSmall,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 12,
                                  ),
                                  Flexible(
                                    fit: FlexFit.tight,
                                    child: ColorFiltered(
                                      colorFilter: ColorFilter.mode(
                                          percentChangeColor, BlendMode.srcIn),
                                      child: SvgPicture.network(
                                          'https://s3.coinmarketcap.com/generated/sparklines/web/1d/2781/$tokenId.svg'),
                                    ),
                                  ),
                                  Expanded(
                                      child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        '\$$finalPrice',
                                        style: textTheme.bodySmall,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          percentIcon,
                                          Text(
                                            '$finalPercent%',
                                            style: TextStyle(
                                                color: percentChangeColor),
                                          )
                                        ],
                                      )
                                    ],
                                  ))
                                ],
                              );
                            },
                            separatorBuilder: (context, index) {
                              return const Divider(
                                thickness: 1,
                                color: Colors.black12,
                              );
                            },
                            itemCount: model!.length),
                      ),
                    );
                  case Status.ERROR:
                    return Text(value.state.message);
                  default:
                    return Container();
                }
              },
            ),
          )
        ]),
      ),
    ));
  }
}
