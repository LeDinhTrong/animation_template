import 'dart:async';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class DownloadPage extends StatelessWidget {
  final String path;
  const DownloadPage({Key? key, required this.path}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    StateMachineController? controller;

    SMIInput<bool>? inputDownloadStatus;
    SMIInput<double>? inputProgress;

    double progress = 0;
    Timer? timer;

    void startDownload() {
      inputDownloadStatus?.change(true);

      timer = Timer.periodic(
        const Duration(milliseconds: 50),
        (timer) async {
          progress++;

          inputProgress?.change(progress);

          if (progress == 100) {
            await Future.delayed(const Duration(seconds: 2));

            progress = 0;
            inputDownloadStatus?.change(false);
            timer.cancel();
          }
        },
      );
    }

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Container(
              color: Colors.black,
              padding: const EdgeInsets.all(20),
              child: SizedBox(
                height: 240,
                width: 240,
                child: RiveAnimation.asset(
                  path,
                  stateMachines: const ['Guido SM'],
                  onInit: (artboard) {
                    controller = StateMachineController.fromArtboard(artboard, 'Guido SM');

                    if (controller == null) return;

                    artboard.addController(controller!);
                    inputDownloadStatus = controller?.findInput('Downloading');
                    inputProgress = controller?.findInput('Progress');
                  },
                ),
              ),
            ),
            TextButton(
              onPressed: startDownload,
              style: TextButton.styleFrom(backgroundColor: Colors.blueGrey),
              child: const Text('Start Download', style: TextStyle(color: Colors.white)),
            )
          ],
        ),
      ),
    );
  }
}
