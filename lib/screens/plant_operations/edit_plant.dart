import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';

import '../../Custom/custom_textfield.dart';
import '../../Models/plant.dart';
import '../../constants.dart';
import '../../providers/admin_provider.dart';

class EditPlant extends StatelessWidget {
  Plant plant;
  EditPlant(this.plant);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Consumer<MainProvider>(builder: (context, provider, w) {
        return SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: provider.updatePlantKey,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            icon:
                                Icon(AntDesign.arrowleft, color: kPrimaryColor),
                            onPressed: () => Navigator.pop(context)),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    InkWell(
                      onTap: () {
                        provider.pickImageForPlant();
                      },
                      child: Container(
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 9,
                              offset:
                                  Offset(0, 1), // changes position of shadow
                            ),
                          ],
                        ),
                        child: provider.pickedPlantImage == null
                            ? Stack(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(5),
                                    child: Opacity(
                                        opacity: 0.5,
                                        child: Image.network(
                                          height:200,
                                          width:200,
                                          plant.plantImage!,
                                          fit: BoxFit.cover,
                                        )),
                                  ),
                                  Center(
                                    child: Icon(Icons.camera),
                                  ),
                                ],
                              )
                            : Image.file(
                                provider.pickedPlantImage!,
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    CustomTextField(
                        provider.plantNameController,
                        plant.plantName!,
                        ((plant.plantName!)),
                        TextInputType.name,
                        false,
                        Icons.texture),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextField(
                        provider.plantDescController,
                        plant.plantDescription!.length > 10 ?  plant.plantDescription!.substring(0, 10) + "..." :  plant.plantDescription!,
                        ((plant.plantDescription!)),
                        TextInputType.text,
                        false,
                        Icons.description_outlined),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextField(
                      provider.plantWateringController,
                      plant.plantWatering!.length > 10 ?  plant.plantWatering!.substring(0, 10) + "..." :  plant.plantWatering!,
                      ((plant.plantWatering!)),
                      TextInputType.text,
                      false,
                      Icons.water,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextField(
                      provider.plantLightningController,
                      plant.plantLightning!.length > 10 ?  plant.plantLightning!.substring(0, 10) + "..." :  plant.plantLightning!,
                      ((plant.plantLightning!)),
                      TextInputType.text,
                      false,
                      Icons.wb_incandescent_outlined,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          provider.updatePlant(plant);
                        },
                        child: const Text(
                          'Update Plant',
                          style: TextStyle(fontSize: 17),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kPrimaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
