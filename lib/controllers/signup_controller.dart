import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../database_sevices/auth_service.dart';
import '../database_sevices/firebase_storage.dart';
import '../database_sevices/firestore_service.dart';
import '../models/user_model.dart';

class SignupController extends GetxController {
  GlobalKey<FormState> formKey = GlobalKey();

  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;

  FireStoreService firestore = FireStoreService();
  FirebaseStorageService storage = FirebaseStorageService();
  FirebaseAuthService authService = FirebaseAuthService();

  File? imageFile;
  UserCredential? user;
  bool isUploading = false;
  bool isHidden = false;

  Future<void> pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker()
        .pickImage(source: source, maxWidth: 612, maxHeight: 408);
    imageFile = File(
      pickedFile!.path,
    );
    update();
  }

  void isObscuree(bool isHid) {
    isHidden = isHid;
    update();
  }

  Future<String> uploadUserImage(File image) async {
    String imageUrl = await storage.uploadImage(image);
    return imageUrl;
  }

  Future<void> createUser(String email, String password) async {
    user = await authService.creatUserWithEmailAndPassword(email, password);
  }

  Future<void> saveUserToFirestore(UserModel model) async {
    firestore.saveUserToFirestore(model);
  }

  void isUploadingImage(bool isUp) {
    isUploading = isUp;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }
}
