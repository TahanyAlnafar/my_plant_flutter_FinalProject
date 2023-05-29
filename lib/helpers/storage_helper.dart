import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class StorageHelper {
  StorageHelper._();

  static StorageHelper storageHelper = StorageHelper._();
  FirebaseStorage storage = FirebaseStorage.instance;

  Future<String> uploadImage(String folderName, File file) async {
    String path = file.path;
    String name = path.split('/').last;
    Reference reference = storage.ref('$folderName/$name');
    await reference.putFile(file);
    String imageUrl = await reference.getDownloadURL();
    return imageUrl;
  }

}
