import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Helpers/notiefier.dart';

class CameraView extends StatefulWidget {
  final String categoria;
  const CameraView({Key? key, required this.categoria}) : super(key: key);

  @override
  State<CameraView> createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  CameraController? _controller;

  @override
  void initState() {
    super.initState();
    _initCamera();
  }

  Future<void> _initCamera() async {
    if (globalCameras.isEmpty) return;

    _controller = CameraController(globalCameras[0], ResolutionPreset.high);
    await _controller!.initialize();
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_controller == null || !_controller!.value.isInitialized) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 43, 85, 100),
      body: Stack(
        children: [
          SizedBox(
              height: MediaQuery.of(context).size.height,
              child: CameraPreview(_controller!)),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 50,
                      height: 50,
                      child: FloatingActionButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        shape: const CircleBorder(
                          side: BorderSide(
                            color: Color.fromARGB(
                                169, 0, 0, 0), 
                            width: 3.0,
                          ),
                        ),
                        child: const Icon(Icons.arrow_back),
                      ),
                    ),
                    SizedBox(
                      height: 80,
                      width: 80,
                      child: FloatingActionButton(
                        elevation: 10,
                        onPressed: () async {
                          final notifier = Provider.of<ArmadioNotifier>(context,
                              listen: false);
                          await notifier.aggiungiCapo(_controller!, widget.categoria);
                          if (mounted) Navigator.pop(context);
                        },
                        shape: const CircleBorder(
                          side: BorderSide(
                            color: Color.fromARGB(
                                169, 0, 0, 0), 
                            width: 3.0, // Spessore del contorno
                          ),
                        ),
                      ),
                    ),
                    //widget x tenerli belli
                    Visibility(
                      visible: false,
                      maintainSize: true,
                      maintainAnimation: true,
                      maintainState: true,
                      child: Container(
                          width: 50, height: 1, color: Colors.transparent),
                    ),
                  ]),
            ),
          ),
        ],
      ),
    );
  }
}
