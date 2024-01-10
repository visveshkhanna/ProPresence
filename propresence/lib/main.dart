import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:propresence/api.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();
  final firstCamera = cameras[0];
  runApp(MyApp(camera: firstCamera));
}

class MyApp extends StatelessWidget {
  final CameraDescription camera;

  const MyApp({Key? key, required this.camera}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ProPresence',
      home: CameraScreen(camera: camera),
    );
  }
}

class CameraScreen extends StatefulWidget {
  final CameraDescription camera;

  const CameraScreen({Key? key, required this.camera}) : super(key: key);

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _controller;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.max,
    );
    _controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_controller.value.isInitialized) {
      return Container();
    }

    return Scaffold(
      backgroundColor: Colors.black26,
      appBar: AppBar(
        title: const Text(
          'ProPresence',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        elevation: 5,
        shadowColor: Colors.grey,
        backgroundColor: Colors.black12,
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            child: Center(
              child: ClipRRect(
                child: SizedOverflowBox(
                  size: const Size(500, 500), // aspect is 1:1
                  alignment: Alignment.center,
                  child: CameraPreview(
                    _controller,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 40.0),
          ElevatedButton(
            onPressed: () {
              _controller.takePicture().then((value) => {
                    processImage(value.path).then((value) => {
                          Fluttertoast.showToast(
                              msg: "Welcome ${value}",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0)
                        })
                  });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: CupertinoColors.activeGreen,
            ),
            child: const Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                'Check in',
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              _controller.takePicture().then((value) => {
                processImage(value.path).then((value) => {
                  Fluttertoast.showToast(
                      msg: "Bye ${value}",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0)
                })
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: CupertinoColors.destructiveRed,
            ),
            child: const Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                'Check out',
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
