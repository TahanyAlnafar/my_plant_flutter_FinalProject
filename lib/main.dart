import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_plant_flutter_app/providers/admin_provider.dart';
import 'package:my_plant_flutter_app/screens/Splash/splash_screen.dart';
import 'package:provider/provider.dart';

import 'app_routers/app_routers.dart';
import 'constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: kPrimaryColor,
    ));
    return ChangeNotifierProvider(
        create: (context) {
          return MainProvider();
        },
        child: MaterialApp(
          navigatorKey: AppRouter.navKey,
          debugShowCheckedModeBanner: false,
          title: 'The Flutter Way',
          theme: ThemeData(
            scaffoldBackgroundColor: bgColor,
            // Define the colors for the theme
            primarySwatch: Colors.green,
            backgroundColor: Colors.white,
            fontFamily: "Gordita_thin",
            appBarTheme: const AppBarTheme(
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            textTheme: const TextTheme(
              bodyText2: TextStyle(color: Colors.black54),
            ),
          ),
          home: SplashScreen(),
        ));
  }
}
