import 'package:flutter/material.dart';
import 'package:my_plant_flutter_app/screens/plant_operations/add_plant.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import '../app_routers/app_routers.dart';
import '../constants.dart';
import '../screens/user/user_profile.dart';

class MyAppBar extends StatelessWidget with PreferredSizeWidget {
  Color? _backgroundColor;
  MyAppBar([this._backgroundColor]);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: AppBar(
          backgroundColor: _backgroundColor == null
              ?  Colors.transparent
              : _backgroundColor,
          title: Text("My Plants",
              style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.normal,
                  fontFamily: 'Gordita_thin')),
          actions: [

            IconButton(
              onPressed: () {
                AppRouter.navigateToScreen(AddNewPlant());
              },
              icon: Icon(AntDesign.pluscircleo),
              color: kPrimaryColor,
            ),
            IconButton(
              onPressed: () {
                AppRouter.navigateToScreen(UserProfile());
              },
              icon: Icon(AntDesign.user),
              color: kPrimaryColor,
            ),
            IconButton(
              onPressed: () {
                AppRouter.showWarningLogOutDialog();
              },
              icon: Icon(AntDesign.logout, color: kPrimaryColor),
              color: kPrimaryColor,
            ),
          ],
          leading: Image.asset("assets/images/cactus.png")),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => AppBar().preferredSize;
}
