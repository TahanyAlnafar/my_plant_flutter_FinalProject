import 'dart:developer';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_plant_flutter_app/screens/user/user_profile.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../app_routers/app_routers.dart';
import '../../helpers/firestore_helper.dart';
import '../Models/plant.dart';
import '../helpers/ auth_helper.dart';
import '../helpers/storage_helper.dart';
import '../Models/app_user.dart';
import '../screens/authentaication/login_screen.dart';
import '../screens/authentaication/signup_screen.dart';
import '../screens/home/home_screen.dart';

class MainProvider extends ChangeNotifier {
  MainProvider() {
    checkUser();
    getAllPlants();
  }

  File? pickedPlantImage;

  List<Plant>? allPlants;

  GlobalKey<FormState> plantFormKey = GlobalKey();
  GlobalKey<FormState> updatePlantKey = GlobalKey();

  // plant controllers
  TextEditingController plantNameController = TextEditingController();
  TextEditingController plantDescController = TextEditingController();
  TextEditingController plantLightningController = TextEditingController();
  TextEditingController plantWateringController = TextEditingController();

  // categories ----------------------------------------

  pickImageForPlant() async {
    XFile? xfile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (xfile != null) {
      pickedPlantImage = File(xfile.path);
      notifyListeners();
    }
  }

  getAllPlants() async {
    allPlants = await FirestoreHelper.firestoreHelper.getAllPlants();
    notifyListeners();
  }

  addNewPlant() async {
    if (pickedPlantImage != null) {
      AppRouter.showLoaderDialog();
      // 2- upload image to firebase storage and get its url
      String imageUrl = await StorageHelper.storageHelper
          .uploadImage("plants_images", pickedPlantImage!);

      Plant newPlant = Plant(
          plantImage: imageUrl,
          plantName: plantNameController.text,
          plantWatering: plantWateringController.text,
          plantLightning: plantLightningController.text,
          plantDescription: plantDescController.text);

      String? id = await FirestoreHelper.firestoreHelper.addNewPlant(newPlant);

      AppRouter.hideLoadingDialog();
      if (id != null) {
        newPlant.id = id;
        allPlants?.add(newPlant);
        notifyListeners();
        AppRouter.showCustomDialog('The plant has been successfully added');
        log('The plant has been successfully added');
      } else {
        AppRouter.showCustomDialog('some error occured while adding plant');
        log('some error occured while adding plant');
      }
      pickedPlantImage = null;
      plantNameController.clear();
      plantWateringController.clear();
      plantLightningController.clear();
      plantDescController.clear();
    }
  }

  deletePlant(Plant plant) async {
    bool deleteSuccess =
        await FirestoreHelper.firestoreHelper.deletePlant(plant);
    if (deleteSuccess) {
      allPlants!.remove(plant);
      notifyListeners();
      AppRouter.showCustomDialog('The plant has been successfully deleted');
      log('The plant has been successfully deleted');
    } else {
      AppRouter.showCustomDialog('some error occured while deleting plant');
      log('some error occured while deleting plant');
    }
  }

  updatePlant(Plant plant) async {
    AppRouter.showLoaderDialog();
    if (pickedPlantImage != null) {
      String imageUrl = await StorageHelper.storageHelper
          .uploadImage("plants_images", pickedPlantImage!);
      plant.plantImage = imageUrl;
    }


    Plant newPlant = Plant(
      id: plant.id,
      plantImage: plant.plantImage,
      plantName: plantNameController.text.isEmpty
          ? plant.plantName
          : plantNameController.text,
      plantLightning: plantLightningController.text.isEmpty
          ? plant.plantLightning
          : plantLightningController.text,
      plantWatering: plantWateringController.text.isEmpty
          ? plant.plantWatering
          :  plantWateringController.text,
      plantDescription: plantDescController.text.isEmpty
          ? plant.plantDescription
          : plantDescController.text,
    );

    bool? isUpdated =
        await FirestoreHelper.firestoreHelper.updatePlant(newPlant);

    if (isUpdated != null && isUpdated) {
      int index = allPlants!.indexOf(plant);
      allPlants![index] = newPlant;
      pickedPlantImage = null;
      notifyListeners();
      AppRouter.navigateAndReplaceScreen(HomeScreen());
      AppRouter.showCustomDialog('success Your plant has been updated');
      log('success Your plant has been updated');
    } else {
      AppRouter.showCustomDialog('some error occured while updating plant');
      log('some error occured while updating plant');
    }
    plantNameController.clear();
    plantDescController.clear();
    plantWateringController.clear();
    plantLightningController.clear();
  }

  //-----------------------------------------------

  updateUserImage() async {
    AppRouter.showLoaderDialog();
    XFile? pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      File file = File(pickedFile.path);
      String imageUrl =
          await StorageHelper.storageHelper.uploadImage("users_images", file);

      currentLoggedUser!.imageUrl = imageUrl;
      await FirestoreHelper.firestoreHelper.updateUserInfo(currentLoggedUser!);
      getUserFromFirestore(currentLoggedUser!.id!);
      notifyListeners();
      AppRouter.navigateAndReplaceScreen(UserProfile());
      AppRouter.showCustomDialog(
          'user image info has been successfully updated');
    }
  }

  updateUserInfo() async {
    AppRouter.showLoaderDialog();
    currentLoggedUser!.userName = profileUserNameController.text;
    currentLoggedUser!.userPhone = profilePhoneController.text;
    currentLoggedUser!.userAddress = profileUserAddressController.text;
    await FirestoreHelper.firestoreHelper.updateUserInfo(currentLoggedUser!);
    getUserFromFirestore(currentLoggedUser!.id!);
    AppRouter.navigateAndReplaceScreen(UserProfile());
    AppRouter.showCustomDialog('user info has been successfully updated');
  }

  //-----------------------------------------------

  String app_name = 'My Plant';
  AppUser? currentLoggedUser;

  late User loggedUser;

  // login
  TextEditingController loginEmailController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();

  // register
  TextEditingController registerEmailController = TextEditingController();
  TextEditingController registerPasswordController = TextEditingController();
  TextEditingController registerUserNameController = TextEditingController();
  TextEditingController registerUserAddressController = TextEditingController();
  TextEditingController registerPhoneNumController = TextEditingController();

  // user profile
  TextEditingController profileUserNameController = TextEditingController();
  TextEditingController profilePhoneController = TextEditingController();
  TextEditingController profileUserAddressController = TextEditingController();
  TextEditingController profileEmailController = TextEditingController();

  login() async {
    String? userId = await AuthHelper.authHelper
        .login(loginEmailController.text.trim(), loginPasswordController.text);
    if (userId != null) {
      getUserFromFirestore(userId);
      AppRouter.navigateAndReplaceScreen(HomeScreen());
      loginEmailController.clear();
      loginPasswordController.clear();
    } else {
      AppRouter.showCustomDialog(
          'some error occured while logging in , please check all fields');
    }
  }

  register() async {
    bool isSuccess = await AuthHelper.authHelper.signup(
        registerEmailController.text.trim(), registerPasswordController.text);
    log(isSuccess.toString());

    if (isSuccess) {
      getUserFromAuth();
      AppUser appUser = AppUser(
          id: loggedUser.uid,
          userName: registerUserNameController.text,
          userAddress: registerUserAddressController.text,
          userEmail: registerEmailController.text,
          userPhone: registerPhoneNumController.text.trim(),
          isAdmin: false);

      FirestoreHelper.firestoreHelper.createNewUser(appUser);
      User? user = AuthHelper.authHelper.checkUser();
      getUserFromFirestore(user!.uid);
      AppRouter.navigateAndReplaceScreen(LoginScreen());
      registerUserNameController.clear();
      registerUserAddressController.clear();
      registerEmailController.clear();
      registerPhoneNumController.clear();
      registerPasswordController.clear();
    } else {
      AppRouter.showCustomDialog(
          'some error occured while registering , please check all fields');
    }
  }

  signOut() async {
    AuthHelper.authHelper.signOut();
    AppRouter.navigateAndReplaceScreen(LoginScreen());
  }

  getUserFromAuth() {
    loggedUser = AuthHelper.authHelper.checkUser();
  }

  startTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? firstTime = prefs.getBool('first_time');
  }

  getUserFromFirestore(String id) async {
    currentLoggedUser =
        await FirestoreHelper.firestoreHelper.getUserFromFirestore(id);
    currentLoggedUser!.id = id;
    profileUserNameController.text = currentLoggedUser!.userName ?? '';
    profilePhoneController.text = currentLoggedUser!.userPhone ?? '';
    profileUserAddressController.text = currentLoggedUser!.userAddress ?? '';
    profileEmailController.text = currentLoggedUser!.userEmail ?? '';
    notifyListeners();
  }

  checkUser() async {
    await Future.delayed(const Duration(milliseconds: 1500));

    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? firstTime = prefs.getBool('first_time');

    User? user = AuthHelper.authHelper.checkUser();
    if (user == null) {
      if (firstTime != null && !firstTime) {
        // Not first time

        log("sec");
        AppRouter.navigateAndReplaceScreen(LoginScreen());
      } else {
        // First time
        log("first");
        prefs.setBool('first_time', false);
        AppRouter.navigateAndReplaceScreen(SignUpScreen());
      }
    } else {
      getUserFromFirestore(user.uid);
      AppRouter.navigateAndReplaceScreen(HomeScreen());
    }
  }
}
