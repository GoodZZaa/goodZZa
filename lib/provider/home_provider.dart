import 'package:flutter/cupertino.dart';
import 'package:good_zza_code_in_songdo/models/cheapest_mart.dart';
import 'package:good_zza_code_in_songdo/models/cheapest_product.dart';
import 'package:good_zza_code_in_songdo/network/homeapge_gateway.dart';

class HomeProvider extends ChangeNotifier {

  List<CheapestMart> cheapestmart = [];
  List<CheapestProduct> cheapestproduct = [];
  bool isLoading = true;
  int pageNumber = 1;
  int totalCount = 100;

  HomepageGateway homepageGateway = HomepageGateway();

  void init() {
    readCheapestProduct();
  }

  Future readCheapestProduct() async {
    cheapestproduct.addAll(await homepageGateway.getCheapestProduct(isFirst : true, pageNumber: pageNumber));
    pageNumber++;

    isLoading = false;

    notifyListeners();
  }


}
