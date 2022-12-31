import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/bottom_nav_provider.dart';
import 'account_book.dart';

class BottomNavigation extends StatelessWidget {
  BottomNavigation({Key? key}) : super(key: key);
  late BottomNavigationProvider _bottomNavigationProvider;

  @override
  Widget build(BuildContext context) {
    _bottomNavigationProvider = Provider.of<BottomNavigationProvider>(context);
    const Color selected = Color.fromRGBO(63, 66, 72, 1);
    const Color unSelected = Color.fromRGBO(204, 210, 223, 1);
    const EdgeInsets itemPadding = EdgeInsets.fromLTRB(0, 8, 0, 5);

    // 페이지별 화면 추가 필요 영수증 촬영은 카메라 연결
    return Scaffold(
      body: SafeArea(
        child: [
          Container(),
          Container(),
          Container(),
          AccountBook(),
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
                  child: const Icon(
                    Icons.money,
                    size: 20,
                    color: unSelected,
                  )),
              activeIcon: Container(
                  child: const Icon(
                Icons.money,
                size: 20,
                color: unSelected,
              )),
              label: '홈',
            ),
            BottomNavigationBarItem(
              icon: Container(
                  padding: itemPadding,
                  child: const Icon(
                    Icons.money,
                    size: 20,
                    color: unSelected,
                  )),
              activeIcon: Container(
                  padding: itemPadding,
                  child: const Icon(
                    Icons.money,
                    size: 20,
                    color: unSelected,
                  )),
              label: '예산작성',
            ),
            BottomNavigationBarItem(
              icon: Container(
                  padding: itemPadding,
                  child: const Icon(
                    Icons.control_camera_outlined,
                    size: 20,
                    color: unSelected,
                  )),
              activeIcon: Container(
                  padding: itemPadding,
                  child: const Icon(
                    Icons.money,
                    size: 20,
                    color: unSelected,
                  )),
              label: '영수증 촬영',
            ),
            BottomNavigationBarItem(
              icon: Container(
                  padding: itemPadding,
                  child: const Icon(
                    Icons.money,
                    size: 20,
                    color: unSelected,
                  )),
              activeIcon: Container(
                  padding: itemPadding,
                  child: const Icon(
                    Icons.money,
                    size: 20,
                    color: unSelected,
                  )),
              label: '가계부',
            ),
            BottomNavigationBarItem(
              icon: Container(
                  padding: itemPadding,
                  child: const Icon(
                    Icons.money,
                    size: 20,
                    color: unSelected,
                  )),
              activeIcon: Container(
                  padding: itemPadding,
                  child: const Icon(
                    Icons.money,
                    size: 20,
                    color: unSelected,
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
