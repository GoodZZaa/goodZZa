import 'package:flutter/material.dart';

import 'pages/splash_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SplashScreen(),
    );


    /// 요렇게 수정한 내용. 
    // 리모트 수정
  }
}
