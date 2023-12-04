import 'package:animator/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gif/flutter_gif.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late FlutterGifController controller;
  @override
  void initState() {

    controller = FlutterGifController(vsync: this);
    controller.animateTo(110,duration: Duration(seconds: 10));
    Future.delayed(Duration(seconds: 10), () {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeScreen()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff2a003f),
      body: Center(
        child: GifImage(image: AssetImage('assets/solar-system.gif'), controller: controller),
      ),
    );
  }
}
