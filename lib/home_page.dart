import 'package:animation_template/page/download_page.dart';
import 'package:flutter/material.dart';
import 'animation_model.dart';
import 'camera_screen/camera_screen.dart';

List<AnimationModel> animations = [
  AnimationModel(name: 'Download', route: const DownloadPage(path: 'assets/liquid_download.riv')),
];

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => CameraScreen())), child: Text('Camera'));
    return GridView.builder(
        itemCount: animations.length,
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 1.5,
        ),
        itemBuilder: (context, index) {
          return ElevatedButton(
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => animations[index].route)),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.blueGrey),
            child: Text(
              animations[index].name,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        });
  }
}
