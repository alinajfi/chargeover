import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> uploadImage(File imageFile) async {
    Reference storageReference =
        _storage.ref().child('images/${imageFile.path.split('/').last}');
    await storageReference.putFile(imageFile);

    String downloadUrl = await storageReference.getDownloadURL();
    return downloadUrl;
  }

  Future<void> deleteImage(String downloadUrl) async {
    Reference ref = _storage.refFromURL(downloadUrl);
    await ref.delete();
  }
}
