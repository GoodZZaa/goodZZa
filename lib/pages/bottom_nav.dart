import 'package:flutter/material.dart';
import 'package:good_zza_code_in_songdo/pages/home_page.dart';
import 'package:good_zza_code_in_songdo/pages/account_book2.dart';
import 'package:good_zza_code_in_songdo/pages/receipt_camera.dart';
import 'package:provider/provider.dart';

import '../provider/bottom_nav_provider.dart';
import 'account_book.dart';

class BottomNavigation extends StatelessWidget {
  BottomNavigation({Key? key}) : super(key: key);
  late BottomNavigationProvider _bottomNavigationProvider;

  @override
  Widget build(BuildContext context) {
    _bottomNavigationProvider = Provider.of<BottomNavigationProvider>(context);
    const Color selected = Color.fromARGB(0xFF, 0x54, 0xB1, 0x75);
    const Color unSelected = Color.fromARGB(104, 107, 104, 104);
    const EdgeInsets itemPadding = EdgeInsets.fromLTRB(0, 8, 0, 5);

    // 페이지별 화면 추가 필요 영수증 촬영은 카메라 연결
    return Scaffold(
      body: SafeArea(
        child: [
          HomePage(),
          Container(),
          TakePictureScreen(),
          AccountBook2(),
          Container()
        ].elementAt(_bottomNavigationProvider.currentPage),
      ),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Container(
                  padding: itemPadding,
                  child: Image.asset(
                    'assets/icons/bottom_nav_home.png',
                    height: 20,
                    width: 23,
                    color: unSelected,
                  )),
              activeIcon: Container(
                  padding: itemPadding,
                  child: Image.asset(
                    'assets/icons/bottom_nav_home.png',
                    height: 20,
                    width: 23,
                    color: selected,
                  )),
              label: '홈',
            ),
            BottomNavigationBarItem(
              icon: Container(
                  padding: itemPadding,
                  child: Image.asset(
                    'assets/icons/bottom_nav_shopping_cart.png',
                    height: 20,
                    width: 23,
                    color: unSelected,
                  )),
              activeIcon: Container(
                  padding: itemPadding,
                  child: Image.asset(
                    'assets/icons/bottom_nav_shopping_cart.png',
                    height: 20,
                    width: 23,
                    color: selected,
                  )),
              label: '예산안',
            ),
            BottomNavigationBarItem(
              icon: Container(
                  padding: itemPadding,
                  child: Image.asset(
                    'assets/icons/icon_camera.png',
                    height: 20,
                    width: 23,
                    color: unSelected,
                  )),
              activeIcon: Container(
                  padding: itemPadding,
                  child: Image.asset(
                    'assets/icons/icon_camera.png',
                    height: 20,
                    width: 23,
                    color: selected,
                  )),
              label: '영수증 촬영',
            ),
            BottomNavigationBarItem(
              icon: Container(
                  padding: itemPadding,
                  child: Image.asset(
                    'assets/icons/bottom_nav_account_book.png',
                    height: 20,
                    width: 23,
                    color: unSelected,
                  )),
              activeIcon: Container(
                  padding: itemPadding,
                  child: Image.asset(
                    'assets/icons/bottom_nav_account_book.png',
                    height: 20,
                    width: 23,
                    color: selected,
                  )),
              label: '가계부',
            ),
            BottomNavigationBarItem(
              icon: Container(
                  padding: itemPadding,
                  child: Image.asset(
                    'assets/icons/bottom_nav_mypage.png',
                    height: 20,
                    width: 23,
                    color: unSelected,
                  )),
              activeIcon: Container(
                  padding: itemPadding,
                  child: Image.asset(
                    'assets/icons/bottom_nav_mypage.png',
                    height: 20,
                    width: 23,
                    color: selected,
                  )),
              label: '마이페이지',
            ),
          ],
          currentIndex: _bottomNavigationProvider.currentPage,
          selectedItemColor: selected,
          unselectedItemColor: unSelected,
          onTap: (index) {
            _bottomNavigationProvider.setCurrentPage(index);
          }),
    );
  }
}
