import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../Models/app_user.dart';
import '../Models/plant.dart';


class FirestoreHelper {
  FirestoreHelper._();

  static FirestoreHelper firestoreHelper = FirestoreHelper._();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  createNewUser(AppUser appUser) async {
    firestore.collection('users').doc(appUser.id).set(appUser.toMap());
  }

  Future<AppUser> getUserFromFirestore(String id) async {
    DocumentSnapshot<Map<String, dynamic>> document =
    await firestore.collection('users').doc(id).get();

    Map<String, dynamic>? data = document.data();

    AppUser appUser = AppUser.fromMap(data!);
    return appUser;
  }

  Future<bool?> updateUserInfo(AppUser appUser) async {
    await firestore.collection('users').doc(appUser.id).update(appUser.toMap());
  }

 

  // ----------------------------------------------------------------------------

  Future<List<Plant>?> getAllPlants() async {
      try {
        QuerySnapshot<Map<String, dynamic>> catsSnapshot =
        await firestore.collection('plants').get();
        List<Plant> categories = catsSnapshot.docs.map((doc) {
          Plant plant = Plant.fromMap(doc.data());
          plant.id = doc.id;
          return plant;
        }).toList();
        return categories;
      } on Exception catch (e) {
        log(e.toString());
      }
    }



  Future<String?> addNewPlant(Plant plant) async {
    try {
      DocumentReference<Map<String, dynamic>> documentReference =
      await firestore
          .collection("plants")
          .add(plant.toMap());
      return documentReference.id;
    } on Exception catch (e) {
      log(e.toString());
    }
  }


  Future<bool> deletePlant(Plant plant) async {
    try {
      await firestore
          .collection('plants')
          .doc(plant.id)
          .delete();
      return true;
    } on Exception catch (e) {
      log(e.toString());
      return false;
    }
  }

  Future<bool?> updatePlant(Plant plant) async {
    try {
      await firestore
          .collection('plants')
          .doc(plant.id)
          .update(plant.toMap());
      return true;
    } on Exception catch (e) {
      log(e.toString());
      return false;
    }
  }

}
