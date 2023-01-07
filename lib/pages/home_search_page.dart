import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Home_Search_Page extends StatefulWidget {
  const Home_Search_Page({Key? key}) : super(key: key);

  @override
  State<Home_Search_Page> createState() => _Home_Search_Page();
}

class _Home_Search_Page extends State<Home_Search_Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: EmptyAppBar(),
      appBar: AppBar(
        backgroundColor: Colors.white,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.black,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 28,
          ),
        ),
        centerTitle: true,
        title: Container(
          height: 40,
          child: Center(
            child: TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(
                    width: 1,
                    color: Color.fromRGBO(200, 200, 203, 1),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(
                    width: 1,
                    color: Color.fromRGBO(200, 200, 203, 1),
                  ),
                ),
              ),
            ),
          ),
        ),
        elevation: 0.0,
        actions: [
          Container(
            width: 50,
            child: Icon(
              Icons.shopping_cart,
              size: 28,
              color: Color.fromRGBO(200, 200, 203, 1),
            ),
          ),
        ],
      ),
      // body: Column(
      //   children: [
      //     Row(
      //       mainAxisAlignment: MainAxisAlignment.spaceAround,
      //       crossAxisAlignment: CrossAxisAlignment.center,
      //       children: [
      //         IconButton(
      //             onPressed: () {
      //               Navigator.pop(context);
      //             },
      //             icon: Icon(
      //               Icons.arrow_back,
      //               size: 20,
      //             )),
      //         Column(
      //           children: [
      //             Row(
      //               children: [
      //                 Icon(
      //                   Icons.location_on,
      //                   size: 20,
      //                 ),
      //                 SizedBox(width: 5),
      //                 Text(
      //                   "서울시 종로구 삼성동 1번길",
      //                   style: TextStyle(fontSize: 16),
      //                 )
      //               ],
      //             ),
      //             Text(
      //               "1.5km 이내",
      //               style: TextStyle(fontSize: 14),
      //             )
      //           ],
      //         ),
      //         Icon(
      //           Icons.shopping_cart,
      //           size: 28,
      //           color: Color.fromRGBO(200, 200, 203, 1),
      //         )
      //       ],
      //     ),
      //   ],
      // ),
    );
  }
}
