// A screen that takes in a list of cameras and the Directory to store images.
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TakePictureScreen extends StatefulWidget {
  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
  bool _cameraInitialized = false;
  late CameraController _controller;
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
        _camera, ResolutionPreset.max // 가장 높은 해상도의 기능을 쓸 수 있도록 합니다.
        );
    _controller
        .initialize()
        .then((value) => setState(() => _cameraInitialized = true));
  }

  @override
  void dispose() {
    // 위젯의 생명주기 종료시 컨트롤러 역시 해제시켜줍니다.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _cameraInitialized
        ? CameraPreview(_controller)
        : const Center(
            child: CircularProgressIndicator(
            color: Color.fromARGB(0xFF, 0x54, 0xB1, 0x75),
          ));
  }
}
