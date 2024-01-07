import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:exchange/models/CryptoData.dart';
import 'package:exchange/providers/cryptoDataProvider.dart';
import 'package:exchange/ui/ui_helpers/shimmer_market.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../network/responseModel.dart';
import '../../utilities/decimal_rounder.dart';

class MarketViewPage extends StatefulWidget {
  const MarketViewPage({Key? key}) : super(key: key);

  @override
  State<MarketViewPage> createState() => _MarketViewPageState();
}

class _MarketViewPageState extends State<MarketViewPage> {
  late CryptoDataProvider cryptoDataProvider;
  late Timer timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    cryptoDataProvider =
        Provider.of<CryptoDataProvider>(context, listen: false);
    cryptoDataProvider.getAllData();

    timer = Timer.periodic(const Duration(seconds: 20),
        (Timer t) => cryptoDataProvider.getAllData());
  }

  @override
  void dispose() {
    timer.cancel();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    var borderColor = Theme.of(context).secondaryHeaderColor;

    TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: [
            Expanded(
              child: Consumer<CryptoDataProvider>(
                  builder: (context, marketViewProvider, child) {
                switch (marketViewProvider.state.status) {
                  case Status.LOADING:
                    return const ShimmerMarketWidget();
                  case Status.COMPLETED:
                    List<CryptoData>? model =
                        marketViewProvider.dataFuture.data!.cryptoCurrencyList;
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            onChanged: (value) {
                              // List<CryptoData>? searchList = [];
                              //
                              // for(CryptoData crypto in model!){
                              //   if(crypto.name!.toLowerCase().contains(value) || crypto.symbol!.toLowerCase().contains(value)){
                              //     searchList.add(crypto);
                              //   }
                              // }
                              // marketViewProvider.configSearch(searchList);
                            },
                            // controller: searchController,
                            decoration: InputDecoration(
                              hintStyle: textTheme.bodySmall,
                              prefixIcon: Icon(
                                Icons.search,
                                color: borderColor,
                              ),
                              // hintText: AppLocalizations.of(context)!.search,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: borderColor),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(15)),
                              ),
                              border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: ListView.separated(
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return const Divider();
                            },
                            itemCount: model!.length,
                            itemBuilder: (context, index) {
                              var number = index + 1;
                              var tokenId = model[index].id;

                              // get filter color for chart (green or red)
                              MaterialColor filterColor =
                                  DecimalRounder.setColorFilter(
                                      model[index].quotes![0].percentChange24h);

                              // get price decimals fix
                              var finalPrice =
                                  DecimalRounder.removePriceDecimals(
                                      model[index].quotes![0].price);

                              // percent change setup decimals and colors
                              var percentChange =
                                  DecimalRounder.removePercentDecimals(
                                      model[index].quotes![0].percentChange24h);

                              Color percentColor =
                                  DecimalRounder.setPercentChangesColor(
                                      model[index].quotes![0].percentChange24h);
                              Icon percentIcon =
                                  DecimalRounder.setPercentChangesIcon(
                                      model[index].quotes![0].percentChange24h);

                              return Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: InkWell(
                                  onTap: () {
                                    // Navigator.push(context, MaterialPageRoute(builder: (context) => TokenDetailPage(cryptoData: model[index])));
                                  },
                                  child: SizedBox(
                                    height: height * 0.075,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10.0),
                                          child: Text(
                                            number.toString(),
                                            style: textTheme.bodySmall,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10.0, right: 15),
                                          child: CachedNetworkImage(
                                            fadeInDuration: const Duration(
                                                milliseconds: 500),
                                            height: 32,
                                            width: 32,
                                            imageUrl:
                                                "https://s2.coinmarketcap.com/static/img/coins/32x32/$tokenId.png",
                                            placeholder: (context, url) =>
                                                Shimmer.fromColors(
                                              baseColor: Colors.grey.shade400,
                                              highlightColor: Colors.white,
                                              child: SizedBox(
                                                width: 32,
                                                height: 32,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    const Icon(Icons.error),
                                          ),
                                        ),
                                        Flexible(
                                          fit: FlexFit.tight,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                model[index].name!,
                                                style: textTheme.bodySmall,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              Text(
                                                model[index].symbol!,
                                                style: textTheme.labelSmall,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Flexible(
                                            fit: FlexFit.tight,
                                            // flex: 2,
                                            child: ColorFiltered(
                                                colorFilter: ColorFilter.mode(
                                                    filterColor,
                                                    BlendMode.srcATop),
                                                child: SvgPicture.network(
                                                  "https://s3.coinmarketcap.com/generated/sparklines/web/1d/2781/$tokenId.svg",
                                                ))),
                                        // Spacer(),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                right: 10.0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Text(
                                                  "\$$finalPrice",
                                                  style: textTheme.bodySmall,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    percentIcon,
                                                    Text(
                                                      "$percentChange%",
                                                      style: GoogleFonts.ubuntu(
                                                          color: percentColor,
                                                          fontSize: 13),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  case Status.ERROR:
                    return Center(
                      child: Text(marketViewProvider.state.message),
                    );
                  default:
                    return const ShimmerMarketWidget();
                }
              }),
            ),
          ],
        ),
      ),
    );
  }
}
