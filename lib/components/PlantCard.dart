import 'package:flutter/material.dart';
import 'package:my_plant_flutter_app/Models/plant.dart';
import 'package:my_plant_flutter_app/app_routers/app_routers.dart';
import 'package:my_plant_flutter_app/screens/details/details_screen.dart';
import '../constants.dart';

class PlantCard extends StatelessWidget {
  Plant plant;

  PlantCard(this.plant);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        AppRouter.navigateToScreen( DetailsScreen(plant));
        Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (context) => DetailsScreen(plant)));
      },
      child: Wrap(
        children: [
          Center(
            child: Container(
              margin: EdgeInsets.all( MediaQuery.of(context).size.width * 0.02),
              width: 180,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFFC1BFBF).withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 2,
                    offset: Offset(
                      0,
                      1,
                    ),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 5, bottom: 5),
                    height: 150,
                    width: double.infinity,
                    child: Container(
                      margin: EdgeInsets.only(right: 5, left: 5),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(plant.plantImage!),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all( 5),
                    child: SizedBox(
                      height: 30,
                      child: Text(
                        plant.plantName!,maxLines: 1,
                        style: const TextStyle(
                            fontSize: 25,
                            color:  kPrimaryColor,
                            fontFamily: 'Gordita_thin',
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),

                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}