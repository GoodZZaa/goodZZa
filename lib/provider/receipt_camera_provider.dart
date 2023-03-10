import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:good_zza_code_in_songdo/service/account_service.dart';

class ReceiptCameraProvider extends ChangeNotifier {
  final AccountService _accountService = AccountService();

  void postReceiptImage(XFile file) async {
    DateTime now = DateTime.now();
    final File imageFile = File(file.path);
    _accountService.postReceiptImg(now.year, now.month, now.day, imageFile);
  }
}
