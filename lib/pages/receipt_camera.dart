// A screen that takes in a list of cameras and the Directory to store images.
import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:good_zza_code_in_songdo/provider/receipt_camera_provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class TakePictureScreen extends StatefulWidget {
  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
  late ReceiptCameraProvider _receiptCameraProvider;
  bool _cameraInitialized = false;
  late CameraController? _controller;
  late CameraDescription _camera;

  @override
  void initState() {
    super.initState();
    _initcamera();
  }

  void _initcamera() async {
    final cameras = await availableCameras();

    if (cameras.isEmpty) {
      print('empty');
      return;
    } else {
      print('noempty');
      _camera = cameras.first;
    }
    CameraDescription backCamera;
    for (var camera in cameras) {
      if (camera.lensDirection == CameraLensDirection.back) {
        backCamera = camera;
        break;
      }
    }

    _controller = CameraController(
        _camera, ResolutionPreset.medium // 가장 높은 해상도의 기능을 쓸 수 있도록 합니다.
        );
    _controller!
        .initialize()
        .then((value) => setState(() => _cameraInitialized = true));
  }

  @override
  void dispose() {
    // 위젯의 생명주기 종료시 컨트롤러 역시 해제시켜줍니다.
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _receiptCameraProvider = Provider.of<ReceiptCameraProvider>(context);

    return _cameraInitialized
        ? Stack(
            children: [
              AspectRatio(
                aspectRatio: 1 / _controller!.value.aspectRatio,
                child: CameraPreview(_controller!),
              ),
              Positioned(
                  bottom: 10,
                  right: 0,
                  left: 0,
                  child: InkWell(
                    onTap: () async {
                      print('촬영 클릭!');
                      XFile? rawImage = await takePicture();
                      if (rawImage != null) {
                        postDialog(context, rawImage);
                      }
                    },
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        const Icon(Icons.circle,
                            color: Colors.white38, size: 70),
                        const Icon(Icons.circle, color: Colors.white, size: 55),
                      ],
                    ),
                  ))
            ],
          )
        : const Center(
            child: CircularProgressIndicator(
            color: Color.fromARGB(0xFF, 0x54, 0xB1, 0x75),
          ));
  }

  Future<XFile?> takePicture() async {
    final CameraController? cameraController = _controller;
    print('촬영 시작');
    if (cameraController!.value.isTakingPicture) {
      return null;
    }
    try {
      XFile file = await cameraController
          .takePicture()
          .timeout(const Duration(seconds: 2));
      print('카메라 촬영 성공');
      return file;
    } on Exception catch (e) {
      print('카메라 촬영 실패 $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('촬영에 실패했습니다. 다시 시도해주세요'),
        ),
      );
      return null;
    }
  }

  Future<bool> postDialog(BuildContext context, XFile file) async {
    return await showDialog(
        context: context,
        barrierDismissible: false,
        useRootNavigator: false,
        builder: (BuildContext context) => AlertDialog(
              buttonPadding: const EdgeInsets.all(20),
              alignment: Alignment.center,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              content: Container(
                margin: const EdgeInsets.only(top: 20),
                child: const Text(
                  '이 영수증으로 지출을 기록하시겠습니까?',
                  style: TextStyle(
                      color: Color.fromARGB(255, 24, 24, 1),
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w600,
                      fontSize: 17),
                ),
              ),
              actions: <Widget>[
                SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 55,
                    child: Row(
                      children: [
                        Flexible(
                            child: InkWell(
                          child: Container(
                            margin: const EdgeInsets.fromLTRB(0, 0, 6, 0),
                            alignment: Alignment.center,
                            height: 55,
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(234, 234, 234, 1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Text(
                              '취소',
                              style: TextStyle(
                                  color: Color.fromRGBO(102, 102, 102, 1),
                                  fontFamily: 'Pretendard',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          onTap: () {
                            Navigator.pop(context, false);
                          },
                        )),
                        Flexible(
                            child: InkWell(
                          child: Container(
                            margin: const EdgeInsets.fromLTRB(6, 0, 0, 0),
                            alignment: Alignment.center,
                            height: 55,
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(240, 120, 5, 1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Text(
                              '저장',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Pretendard',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          onTap: () {
                            _receiptCameraProvider.postReceiptImage(file);
                          },
                        ))
                      ],
                    ))
              ],
            ));
  }
}
