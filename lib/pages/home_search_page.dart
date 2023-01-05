import 'package:flutter/material.dart';

class Home_Search_Page extends StatefulWidget {
  const Home_Search_Page({Key? key}) : super(key: key);

  @override
  State<Home_Search_Page> createState() => _Home_Search_Page();
}

class _Home_Search_Page extends State<Home_Search_Page> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(onPressed: (){}, icon: Icon(Icons.arrow_back,size: 20,)),
              Column(
                children: [
                  Row(children: [
                    Icon(Icons.location_on, size: 20,),
                    SizedBox(width: 5,),
                    Text("서울시 종로구 삼성동 1번길", style: TextStyle(fontSize: 16),)
                  ],),
                  Text("1.5km 이내",style: TextStyle(fontSize: 14),)
                ],
              ),
              Icon(Icons.shopping_cart,size: 28,color: Color.fromRGBO(200,200,203,1),)

            ],
          ),
        ],
      ),

    );
  }
}
