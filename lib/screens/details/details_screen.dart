import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';

import '../../app_routers/app_routers.dart';
import '../../constants.dart';
import '../../Models/plant.dart';
import '../../providers/admin_provider.dart';
import '../plant_operations/edit_plant.dart';

class DetailsScreen extends StatelessWidget {
  Plant plant;

  DetailsScreen(this.plant);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<MainProvider>(builder: (context, provider, w) {
        return SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            margin: EdgeInsets.all(20.0),
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(AntDesign.arrowleft, color: kPrimaryColor),
                        onPressed: () => Navigator.pop(context),
                      ),
                      Container(
                        width: 100,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              icon: Icon(AntDesign.edit, color: kPrimaryColor),
                              onPressed: () {
                                AppRouter.navigateToScreen(EditPlant(plant));
                              },
                            ),
                            IconButton(
                              icon: Icon(AntDesign.delete, color: kPrimaryColor),
                              onPressed: () {
                                AppRouter.showWarningDeletePlantDialog(plant);

                              },
                            ),
                          ],
                        ),
                      ),

                    ],
                  ),
                ),
                Image.network(
                  plant.plantImage!,
                  height:350,
                  width:350,
                  fit: BoxFit.cover,
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(
                    defaultPadding,
                    defaultPadding * 2,
                    defaultPadding,
                    defaultPadding,
                  ),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(defaultBorderRadius * 3),
                      topRight: Radius.circular(defaultBorderRadius * 3),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.local_florist_outlined,
                            color: kPrimaryColor.withOpacity(0.5),
                            size: 20,
                          ),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.03, // 3% of the screen width
                          ),

                          SizedBox(
                            height: 30,
                            width: 50,
                            child: Center(
                              child: Text(
                                plant.plantName!,maxLines: 1,
                                style: const TextStyle(
                                    fontSize: 25,
                                    fontFamily: 'Gordita_thin',
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.03, // 3% of the screen width
                          ),
                          Icon(
                            Icons.local_florist_outlined,
                            color: kPrimaryColor.withOpacity(0.5),
                            size: 20,
                          ),
                        ],
                      ),
                      const SizedBox(height: defaultPadding),
                      Row(
                        children: [
                          Icon(
                            Icons.water,
                            color: kPrimaryColor.withOpacity(0.5),
                            size: 20,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width *
                                0.03, // 3% of the screen width
                          ),
                          Text(
                            "Watering : ",
                            style:
                                Theme.of(context).textTheme.headline6!.copyWith(
                                      color: Colors.black,
                                    ),
                          ),
                        ],
                      ),
                      const SizedBox(height: defaultPadding),
                      Text(
                        "Needs ${plant.plantWatering!} ",
                        style: Theme.of(context)
                            .textTheme
                            .headline2!
                            .copyWith(color: kPrimaryColor, fontSize: 18),
                      ),
                      const SizedBox(height: defaultPadding),
                      Row(
                        children: [
                          Icon(
                            Icons.wb_incandescent_outlined,
                            color: kPrimaryColor.withOpacity(0.5),
                            size: 20,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.03, // 3% of the screen width,
                          ),
                          Text(
                            "Lightning : ",
                            style:
                                Theme.of(context).textTheme.headline6!.copyWith(
                                      color: Colors.black,
                                    ),
                          ),
                        ],
                      ),
                      const SizedBox(height: defaultPadding),
                      Text(
                        "Needs ${plant.plantLightning!} ",
                        style: Theme.of(context)
                            .textTheme
                            .headline2!
                            .copyWith(color: kPrimaryColor, fontSize: 18),
                      ),
                      const SizedBox(height: defaultPadding),
                      Row(
                        children: [
                          Icon(
                            Icons.description_outlined,
                            color: kPrimaryColor.withOpacity(0.5),
                            size: 20,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Description : ",
                            style:
                                Theme.of(context).textTheme.headline6!.copyWith(
                                      color: Colors.black,
                                    ),
                          ),
                        ],
                      ),
                      const SizedBox(height: defaultPadding),
                      Text(
                        plant.plantDescription!,
                        style: Theme.of(context)
                            .textTheme
                            .headline2!
                            .copyWith(color: kPrimaryColor, fontSize: 18),
                      ),
                    ],
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
