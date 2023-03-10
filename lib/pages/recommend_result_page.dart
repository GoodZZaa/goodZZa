import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:good_zza_code_in_songdo/models/recommend_mart.dart';
import 'package:good_zza_code_in_songdo/provider/recommend_result_provider.dart';
import 'package:provider/provider.dart';

import '../provider/account_book_provider.dart';
import '../provider/bottom_nav_provider.dart';
import '../provider/home_provider.dart';
import '../provider/receipt_camera_provider.dart';
import 'bottom_nav.dart';

class RecommendResultPage extends StatefulWidget {
  const RecommendResultPage({Key? key}) : super(key: key);

  @override
  State<RecommendResultPage> createState() => _RecommendResultPage();
}

class _RecommendResultPage extends State<RecommendResultPage> {
  late RecommendResultProvider _recommendResultProvider;

  @override
  void initState() {
    super.initState();
    _recommendResultProvider =
        Provider.of<RecommendResultProvider>(context, listen: false);
    _recommendResultProvider.fetchRecommendResult();
  }

  @override
  void dispose() {
    super.dispose();
  }

  _buildCard(RecommendMart mart, index) {
    return Column(
      children: [
        Stack(
          children: [
            CachedNetworkImage(
              imageBuilder: (context, imageProvider) => Container(
                margin: const EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width * 0.2,
                height: MediaQuery.of(context).size.width * 0.2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  // shape: BoxShape.circle,
                  image:
                      DecorationImage(image: imageProvider, fit: BoxFit.cover),
                ),
              ),
              imageUrl: mart.imageUrl ??
                  'https://www.thejungleadventure.com/assets/images/noimage/noimage.png',
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  Container(
                width: MediaQuery.of(context).size.width * 0.1,
                height: MediaQuery.of(context).size.width * 0.1,
                child:
                    CircularProgressIndicator(value: downloadProgress.progress),
              ),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
            Positioned(
              right: MediaQuery.of(context).size.width * 0.2,
              left: 0,
              bottom: MediaQuery.of(context).size.width * 0.2,
              top: 0,
              child: Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width * 0.2 * 0.2,
                height: MediaQuery.of(context).size.width * 0.2 * 0.2,
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.grey),
                  shape: BoxShape.circle,
                  color: Colors.transparent,
                ),
                child: Text(
                  '$index',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            )
          ],
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.2,
          // height: MediaQuery.of(context).size.width * 0.2,
          child: Text(
            "${mart.martName}",
            maxLines: 2,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.2,
          child: Text(
            "?????????",
            maxLines: 1,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.2,
          // height: MediaQuery.of(context).size.width * 0.2,
          child: Text(
            "${mart.estimatedPrice}???",
            maxLines: 1,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        Divider(
          height: 10,
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.2,
          // height: MediaQuery.of(context).size.width * 0.2,
          child: Text(
            "+${mart.distance}km",
            maxLines: 1,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }

  _renderBody() {
    _recommendResultProvider = Provider.of<RecommendResultProvider>(context);

    if (_recommendResultProvider.recommendResult.recommendationMarts.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CachedNetworkImage(
            imageBuilder: (context, imageProvider) => Container(
              margin: const EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width * 0.6,
              height: MediaQuery.of(context).size.width * 0.6 * 0.85,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                // shape: BoxShape.circle,
                image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
              ),
            ),
            imageUrl: _recommendResultProvider
                    .recommendResult.recommendationMarts[0].imageUrl ??
                'https://www.thejungleadventure.com/assets/images/noimage/noimage.png',
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                Container(
              width: MediaQuery.of(context).size.width * 0.3,
              height: MediaQuery.of(context).size.width * 0.3,
              child:
                  CircularProgressIndicator(value: downloadProgress.progress),
            ),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
          const Padding(
            padding: EdgeInsets.all(12.0),
            child: Text(
              "????????? ?????? ?????? ??????!",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildCard(
                  _recommendResultProvider
                      .recommendResult.recommendationMarts[0],
                  1),
              _buildCard(
                  _recommendResultProvider
                      .recommendResult.recommendationMarts[1],
                  2),
              _buildCard(
                  _recommendResultProvider
                      .recommendResult.recommendationMarts[2],
                  3),
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          InkWell(
              child: Container(
                  width: 60,
                  child: Icon(
                    Icons.home,
                    size: 25,
                    color: Color.fromARGB(189, 64, 64, 64),
                  )),
              onTap: () => Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MultiProvider(
                            providers: [
                              ChangeNotifierProvider(
                                  create: (context) =>
                                      BottomNavigationProvider()),
                              ChangeNotifierProvider(
                                  create: (context) => AccountProvider()),
                              ChangeNotifierProvider(
                                  create: (context) => ReceiptCameraProvider()),
                              ChangeNotifierProvider(
                                  create: (context) => HomeProvider()),
                            ],
                            child: BottomNavigation(),
                          )),
                  (route) => false)),
        ],
        backgroundColor: Colors.white,
        elevation: 0.0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.black,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 28,
          ),
        ),
        title: const Text(
          "????????? ?????? ??????",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: _renderBody(),
    );
  }
}
