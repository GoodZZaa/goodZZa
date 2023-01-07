import 'package:flutter/material.dart';
import 'package:good_zza_code_in_songdo/provider/search_provider.dart';
import 'package:provider/provider.dart';

import '../provider/account_book_provider.dart';
import '../provider/bottom_nav_provider.dart';
import 'bottom_nav.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 1500), () {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => MultiProvider(
                    providers: [
                      ChangeNotifierProvider(
                          create: (context) => BottomNavigationProvider()),
                      ChangeNotifierProvider(
                          create: (context) => AccountProvider()),
                      ChangeNotifierProvider(
                          create: (context) => SearchProvider()),
                    ],
                    child: BottomNavigation(),
                  )),
          (route) => false);
    });

    return Container(
      color: Colors.white,
      height: double.infinity,
      width: double.infinity,
      child: Image.asset('assets/images/good_zza.png', height: 130, width: 130),
    );
  }
}
