import 'package:flutter/cupertino.dart';
import 'package:good_zza_code_in_songdo/models/cheapest_mart.dart';
import 'package:good_zza_code_in_songdo/models/cheapest_product.dart';
import 'package:good_zza_code_in_songdo/network/homeapge_gateway.dart';
import 'package:good_zza_code_in_songdo/network/homepage_gateway2.dart';

class HomeProvider extends ChangeNotifier {

  List<CheapestMart> cheapestmart = [];
  List<CheapestProduct> cheapestproduct = [];
  bool isLoading = true;
  bool isLoading2 = true;
  int pageNumber = 1;
  int totalCount = 100;

  HomepageGateway homepageGateway = HomepageGateway();
  HomepageGateway2 homepageGateway2 = HomepageGateway2();

  void init() {
    readCheapestProduct();
    readCheapestMart();
  }

  Future readCheapestProduct() async {
    cheapestproduct.addAll(await homepageGateway.getCheapestProduct(isFirst : true, pageNumber: pageNumber));
    pageNumber++;

    isLoading = false;

    notifyListeners();
  }

  Future readCheapestMart() async{
    cheapestmart.addAll(await homepageGateway2.getCheapestMart2(isFirst: true,pageNumber: 1));

    isLoading2 = false;

    notifyListeners();

  }


}
