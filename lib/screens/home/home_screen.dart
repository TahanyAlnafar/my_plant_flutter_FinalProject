import 'package:flutter/material.dart';
import 'package:my_plant_flutter_app/components/PlantCard.dart';
import 'package:my_plant_flutter_app/providers/admin_provider.dart';
import 'package:provider/provider.dart';
import '../../components/my_appbar.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: Consumer<MainProvider>(builder: (context, provider, w) {
        return provider.allPlants == null
            ? const Center(
                child: Text('No plants Found'),
              )
            : GridView.builder(
                itemCount: provider.allPlants!.length,
                padding: EdgeInsets.only(
                  left: 5,
                  right: 5,
                  top: 5,
                ),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1 / 1.13,
                ),
                itemBuilder: (context, index) {
                  return PlantCard(provider.allPlants![index]);
                },
              );
      }),
    );
  }
}
