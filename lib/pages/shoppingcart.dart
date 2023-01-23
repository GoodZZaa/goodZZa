import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:good_zza_code_in_songdo/models/shoppingcartdata.dart';
import 'package:good_zza_code_in_songdo/network/shoppingcart_checkout.dart';
import 'package:good_zza_code_in_songdo/pages/home_page.dart';
import 'package:good_zza_code_in_songdo/pages/home_search_page.dart';
import 'package:hive/hive.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:good_zza_code_in_songdo/provider/recommend_result_provider.dart';
import 'package:good_zza_code_in_songdo/pages/recommend_result_page.dart';


class ShoppingCart extends StatefulWidget {
  

  @override
  _ShoppingCartState createState() {
    return new _ShoppingCartState();

  }
}

class _ShoppingCartState extends State<ShoppingCart> {

  List<Shoppingcart> shoppingcart = [];
  bool isLoading = true;
  Checkout checkout = Checkout();
  int shoppingcheck = 3;
  
  

  Future readShoppingCart() async {
    shoppingcart.addAll(await checkout.getShoppingCart());
  }

  @override
  void initState() {
    super.initState();
    readShoppingCart().then((value) {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: shoppingcartAppbar(),
      body: OutlinedButton(
          onPressed: (){
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ChangeNotifierProvider(
              create: (context) => RecommendResultProvider(),
              child: RecommendResultPage(),
            ),
          ),
        );

        //   // todo : 옮겨야함
        //   Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //       builder: (context) => const RecommendResultPage(),
        //     ),
        //   );
      }, 
          child: Text('예산 저장하기',
          style: TextStyle(color: Colors.white,fontSize: 17),)),


    );
  }

  AppBar shoppingcartAppbar() {
    return AppBar(
      leadingWidth: 70,
      centerTitle: true,
      backgroundColor: Colors.white,
      elevation: 0.0,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.black,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      leading: InkWell(
        child: Container(
          margin: const EdgeInsets.only(left: 10),
          child: Image.asset(
            'assets/icons/back_icon.png',
            height: 25,
          ),
        ),
        onTap: (){
          Navigator.pop(context);
        },
      ),
      title: Text('장바구니 내역',
        style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17,color: Colors.black),),

    );
  }

}