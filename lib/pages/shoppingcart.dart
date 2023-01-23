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
      body: Column(
        children: [
          ShoppingCartCard(),
          ButtomButton()
        ],
      )


      /*OutlinedButton(
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
      */


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

  Widget ShoppingCartCard() {
    return
      ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: shoppingcheck,
          shrinkWrap: true,

          itemBuilder:( context,index){
            return
              isLoading ? Center(child: CircularProgressIndicator(),) :

              Container(
                padding: EdgeInsets.all(16),
                child: Container(
                  height: 96,
                  width: 320,
                  decoration: BoxDecoration(
                    border: Border.all(
                        width: 1,
                        color: Colors.black12
                    ),
                    borderRadius: BorderRadius.circular(8),

                  ),
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(8))
                        ),
                        child: Image.network(shoppingcart[index].imageUrl,
                          fit: BoxFit.cover,),),
                      SizedBox(width: 10,),
                      Expanded(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(shoppingcart[index].productName,
                                  style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                                Expanded(child: SizedBox()),
                                IconButton(
                                  padding: EdgeInsets.zero,
                                  constraints: BoxConstraints(),
                                  onPressed: (){}, icon: Icon(Icons.dangerous,size: 18,),)
                              ],
                            ),
                            Row(
                              children: [
                                Text(shoppingcart[index].martName)
                              ],
                            ),
                            Row(
                              children: [
                                Text(shoppingcart[index].price.toString(),
                                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                                Expanded(child: SizedBox()),
                                IconButton(
                                    style: ButtonStyle(
                                        backgroundColor:MaterialStatePropertyAll(Colors.black38)
                                    ),
                                    padding: EdgeInsets.zero,
                                    constraints: BoxConstraints(),
                                    onPressed: (){
                                      setState(() {
                                        if (this.shoppingcart[index].amount == 1){

                                        } else{
                                          this.shoppingcart[index].amount--;}
                                      });
                                    },
                                    icon: Icon(
                                        Icons.horizontal_rule
                                    )),
                                SizedBox(width: 5,),
                                Container(
                                  padding: EdgeInsets.fromLTRB(5, 1, 5, 1),
                                  child: Text(shoppingcart[index].amount.toString()),
                                  decoration: BoxDecoration(
                                      border:Border.all(
                                          width: 1,
                                          color: Colors.black38
                                      ),
                                      borderRadius: BorderRadius.all(Radius.circular(8))),
                                ),
                                SizedBox(width: 5,),
                                IconButton(
                                    style: ButtonStyle(
                                        backgroundColor:MaterialStatePropertyAll(Colors.black38)
                                    ),
                                    padding: EdgeInsets.zero,
                                    constraints: BoxConstraints(),
                                    onPressed: (){
                                      setState(() {
                                        this.shoppingcart[index].amount++;
                                      });
                                    },
                                    icon: Icon(
                                        Icons.add
                                    )),
                              ],
                            )
                          ],
                        ),
                      )

                      /*
                      Column(
                        children: [
                          Row(
                            children: [
                              //Text(shoppingcart[index].productName,
                                //style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                              Expanded(child: SizedBox()),
                              IconButton(onPressed: (){}, icon: Icon(Icons.dangerous)),
                            ],
                          )
                        ],
                       */
                    ],
                  ),
                ),
              );
            /*ListTile(
              /*leading: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8))
                ),
                child: Image.network(shoppingcart[index].imageUrl,
                fit: BoxFit.cover,),
              ),*/

              title: Column(
                children: [
                  Text(shoppingcart[index].productName,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                  Expanded(child: SizedBox()),
                  Text(shoppingcart[index].martName,
                    style: TextStyle(fontSize: 12, ),),
                  Expanded(child: SizedBox()),
                  Text(shoppingcart[index].price.toString(),
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),

                ],
              ),

              /*trailing: Column(
                children: [
                  IconButton(onPressed: (){}, icon: Icon(Icons.dangerous)),
                  Expanded(child: SizedBox()),
                  Row(
                    children: [
                      IconButton(onPressed: (){}, icon: Icon(Icons.horizontal_rule), iconSize: 32,),
                      SizedBox(width: 3,),
                      Container(width: 32,height: 32, decoration: BoxDecoration(border: Border.all(color: Colors.black38)),
                        child: Text(shoppingcart[index].amount.toString(),
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                      ),
                      SizedBox(width: 3,),
                      IconButton(onPressed: (){}, icon: Icon(Icons.add), iconSize: 32,),
                    ],
                  )
                ],
              )*/

            );*/
          } );
  }


  Widget ButtomButton() {
    return  Container(
      padding: EdgeInsets.all(16),
      child:
      InkWell(
        onTap: (){
          Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ChangeNotifierProvider(
                  create: (context) => RecommendResultProvider(),
                  child: RecommendResultPage(),
                ),
              ));
        },
        child: Container(
          width: 380,
          height: 56,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("예산 저장하기",
                style: TextStyle(
                    fontSize: 17, fontWeight: FontWeight.bold,
                    color: Colors.white
                ),),
            ],
          ),
          decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(8),
              color: Color.fromRGBO(95, 89,225, 100)),
        ),
      ),
    );

  }

}

