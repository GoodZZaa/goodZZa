// A screen that takes in a list of cameras and the Directory to store images.
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class TakePictureScreen extends StatefulWidget {
  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
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
        _camera, ResolutionPreset.max // 가장 높은 해상도의 기능을 쓸 수 있도록 합니다.
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
                        File imageFile = File(rawImage.path);
                        // 서버 전송
                      }
                    },
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Icon(Icons.circle, color: Colors.white38, size: 70),
                        Icon(Icons.circle, color: Colors.white, size: 55),
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
    if (cameraController!.value.isTakingPicture) {
      return null;
    }
    try {
      XFile file = await cameraController.takePicture();
      print('카메라 촬영 성공');
      return file;
    } on CameraException catch (e) {
      print('카메라 촬영 실패 $e');
      return null;
    }
  }
}
