import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'dart:developer';

import '../constants.dart';
import '../models/user_model.dart';

class FireStoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<void> saveEventToFireStore(String collectionName, String documentName,
      Map<String, dynamic> data) async {
    await _firestore.collection(collectionName).doc(documentName).set(data);
  }

  Future<void> saveUserToFirestore(UserModel model) async {
    try {
      _firestore
          .collection(FirebaseConstants.userCollection)
          .doc(model.userId)
          .set(model.toMap());
    } on FirebaseException catch (e) {
      log(e.toString());
    }
  }

  Future<UserModel?> getCurrentUser(String email) async {
    var collection = _firestore.collection(FirebaseConstants.userCollection);
    var querySnapshot = await collection.where('email', isEqualTo: email).get();
    UserModel? model;

    for (var element in querySnapshot.docs) {
      if (element.data()['email'] == email) {
        model = UserModel.fromMap(querySnapshot.docs.first.data());
      }
    }

    return model;
  }
}
