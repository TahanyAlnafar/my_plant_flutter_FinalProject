import 'package:my_plant_flutter_app/Models/plant.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import '../providers/admin_provider.dart';

class AppRouter {
  static GlobalKey<NavigatorState> navKey = GlobalKey();

  static showLoaderDialog() {
    AlertDialog alert = AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(
              margin: EdgeInsets.only(left: 7), child: Text("Loading...")),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: navKey.currentContext!,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static hideLoadingDialog() {
    navKey.currentState!.pop();
  }

  static showCustomDialog(String content) {
    showDialog(
        context: navKey.currentContext!,
        builder: (context) {
          return AlertDialog(
            content: Text(content,
                style: TextStyle(fontSize: 20, color: kPrimaryColor)),
            actions: [
              TextButton(
                  onPressed: navKey.currentState!.pop!,
                  child: Text('OK', style: TextStyle(fontSize: 15))),
            ],
          );
        });
  }

  static showWarningLogOutDialog() {
    showDialog(
        context: navKey.currentContext!,
        builder: (context) {
          return AlertDialog(
            content: Text("Are you sure you want to log out ?",
                style: TextStyle(fontSize: 20, color: kPrimaryColor)),
            actions: [
              TextButton(
                  onPressed: navKey.currentState!.pop!,
                  child: Text('Cancel', style: TextStyle(fontSize: 15))),
              TextButton(
                  onPressed: () =>
                      Provider.of<MainProvider>(context, listen: false)
                          .signOut(),
                  child: Text("Log Out",
                      style: TextStyle(color: Colors.red, fontSize: 15)))
            ],
          );
        });
  }

  static showWarningDeletePlantDialog(Plant plant) {
    showDialog(
        context: navKey.currentContext!,
        builder: (context) {
          return AlertDialog(
            content: Text("Are you sure you want to DELETE this plant ?",
                style: TextStyle(fontSize: 20, color: kPrimaryColor)),
            actions: [
              TextButton(
                  onPressed: navKey.currentState!.pop!,
                  child: Text('Cancel', style: TextStyle(fontSize: 15))),
              TextButton(
                  onPressed: () {
                    Provider.of<MainProvider>(context, listen: false)
                        .deletePlant(plant);
                    Navigator.pop(context); // close the dialog
                    Navigator.pop(context); // close the screen
                  },
                  child: Text("Delete",
                      style: TextStyle(color: Colors.red, fontSize: 15)))
            ],
          );
        });
  }

  static showWarningClearFieldsDialog() {
    showDialog(
        context: navKey.currentContext!,
        builder: (context) {
          return AlertDialog(
            content: Text("Are you sure you want to CLEAR All THE FIELDS ?",
                style: TextStyle(fontSize: 20, color: kPrimaryColor)),
            actions: [
              TextButton(
                  onPressed: navKey.currentState!.pop!,
                  child: Text('Cancel', style: TextStyle(fontSize: 15))),
              TextButton(
                  onPressed: () {
                    Provider.of<MainProvider>(context, listen: false)
                        .plantNameController.clear();
                    Provider.of<MainProvider>(context, listen: false)
                      .plantDescController.clear();
                    Provider.of<MainProvider>(context, listen: false)
                      .plantWateringController.clear();
                    Provider.of<MainProvider>(context, listen: false)
                      .plantLightningController.clear();
                    Provider.of<MainProvider>(context, listen: false)
                      .pickedPlantImage = null ;
                    Navigator.of(context).pop();

                  },
                  child: Text("CLEAR",
                      style: TextStyle(color: Colors.red, fontSize: 15)))
            ],
          );
        });
  }


  static navigateToScreen(Widget widget) {
    navKey.currentState!.push(MaterialPageRoute(builder: ((context) {
      return widget;
    })));
  }

  static navigateAndReplaceScreen(Widget widget) {
    navKey.currentState!.pushReplacement(MaterialPageRoute(builder: ((context) {
      return widget;
    })));
  }
}
