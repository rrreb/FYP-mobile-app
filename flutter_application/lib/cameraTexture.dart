import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';

import 'camera.dart';

class CameraTexturePage extends StatefulWidget {
  const CameraTexturePage({super.key});

  @override
  CameraPageState createState() => CameraPageState();
}

enum features {LOGO, TEXTURE}

class CameraPageState extends State<CameraTexturePage> with WidgetsBindingObserver {
  CameraController? _controller;
  bool _isCameraInitialized = false;
  late final List<CameraDescription> _cameras;

  features feature = features.TEXTURE;
  List<bool> hasPhoto = [false, false];

  XFile? xFileLogo;
  XFile? xFileTexture;

  @override
  void initState() {
    super.initState();
    initCamera();
  }

  Future<void> initCamera() async {
    _cameras = await availableCameras();
    // Initialize the camera with the first camera in the list
    await onNewCameraSelected(_cameras.first);
  }

  Future<void> onNewCameraSelected(CameraDescription description) async {
    final previousCameraController = _controller;

    // Instantiating the camera controller
    final CameraController cameraController = CameraController(
      description,
      ResolutionPreset.medium,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );

    // Initialize controller
    try {
      await cameraController.initialize();
      if (mounted) {
        setState(() {
          _controller = cameraController;
          _isCameraInitialized = true;
        });
      }
    } on CameraException catch (e) {
      debugPrint('Error initializing camera: $e');
    }

    // Dispose the previous controller
    await previousCameraController?.dispose();

    // Update UI if controller updated
    // cameraController.addListener(() {
    //   // if (mounted) setState(() {});
    //   setState(() {});
    // });
  }

  @override
  void dispose() {
    _controller?.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final CameraController? cameraController = _controller;

    if (cameraController == null || !cameraController.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      // Free up memory when camera not active
      cameraController.dispose();
    } else if (state == AppLifecycleState.resumed) {
      // Reinitialize the camera with same properties
      onNewCameraSelected(cameraController.description);
    }
  }

  Future<XFile?> capturePhoto() async {
    final CameraController? cameraController = _controller;
    // if (cameraController!.value.isTakingPicture) {
    //   // A capture is already pending, do nothing.
    //   return null;
    // }
    try {
      XFile file;
      setState(() async {
        await cameraController!.setFlashMode(FlashMode.off); //optional
        file = await cameraController.takePicture();
        feature == features.LOGO
          ? xFileLogo = file
          : xFileTexture = file;
        // return file;
      });
      // return file;
      return null;
    } on CameraException catch (e) {
      debugPrint('Error occured while taking picture: $e');
      return null;
    }
  }
  List<String> featuresList = ['Logo', 'Texture'];


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final deviceRatio = size.width / size.height;

    if (_isCameraInitialized) {
      return SafeArea(
        child: Scaffold(
          appBar: AppBar(
              title: Text('Texture',style: TextStyle(color: Color(0xaaaa7d29), fontWeight: FontWeight.bold)),
            backgroundColor: Color(0xFF282828),
            foregroundColor: Colors.white,
          ),
          body: Container(
            color: Color(0xFF282828),
            child: Column(children: [
                Expanded(
                  child: Container(
                    width: size.width,
                    //   height: 700,
                      child: FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Container(
                          width: size.width,
                          height: size.width * _controller!.value.aspectRatio,
                          child: Transform.rotate(
                            angle: -90 * 3.1415926535897932 / 180,
                            child:  CameraPreview(_controller!),
                          ), // this is my CameraPreview
                        ),
                      ),
                  ),
                ),
              Text((feature == features.LOGO)? "Place the logo inside the box" : '', style: TextStyle(color: Colors.white),),
              Container(
                child: Swiper(
                  loop: false,
                  itemCount: featuresList.length,
                  itemWidth: MediaQuery.of(context).size.width/5,
                  viewportFraction: 1,
                  scale: 0.5,
                  index: 1,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      child: Center(
                        child: Text(
                          featuresList[index],
                          style: TextStyle(fontSize: 30.0, color: Colors.white),
                        ),
                      ),
                    );
                  },
                  onIndexChanged: (int index) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CameraPage()),
                    );
                  },
              ),
                height: 54,
              ),
              SizedBox(height: 30),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(), // Empty container as the first child
                  ),
                  Expanded(
                    flex: 1,
                    child: ElevatedButton(
                      onPressed: capturePhoto,
                      style: ElevatedButton.styleFrom(
                        // fixedSize: const Size(70, 70),
                          shape: const CircleBorder(),
                          backgroundColor: Colors.white),
                      child: const Icon(
                        Icons.panorama_fish_eye,
                        color: Color(0xFF282828),
                        size: 56,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: ElevatedButton(
                      onPressed: capturePhoto,
                      style: ElevatedButton.styleFrom(
                        // fixedSize: const Size(70, 70),
                          shape: const CircleBorder(),
                          backgroundColor: Color(0xFF282828)),
                      child: const Icon(
                        Icons.chevron_right,
                        color: Colors.white,
                        size: 56,
                      ),
                    ),
                  ),
                ]
              ),
            ]),
        ),
        ),
      );
    } else {
      return
            Center(
              child: CircularProgressIndicator(),
            );
    }
  }
}