import 'package:flutter/material.dart';
import 'package:my_plant_flutter_app/providers/admin_provider.dart';
import '../../constants.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<MainProvider>(builder: (context, provider, x) {
        return Container(
          color: Colors.white,
          width: double.infinity,
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/cactus.png',
                  width: 80, // Set the width of the image
                ),
            SizedBox(height: 20),
                const Text(
                  "My Plant",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'Gordita_thin',
                    color: kPrimaryColor,
                    wordSpacing: 1.5,
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
