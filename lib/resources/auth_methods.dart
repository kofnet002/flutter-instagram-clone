import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/models/user.dart' as model;
import 'package:instagram_clone/resources/storage_methods.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

// Get snaptshot from firebase firestore and convert to user model
  Future<model.User> getUserDetails() async {
    User currentUser = _auth.currentUser!;

    DocumentSnapshot snap =
        await _firestore.collection('users').doc(currentUser.uid).get();

    return model.User.fromSnap(snap);
  }

  // sign up method
  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    required String bio,
    required Uint8List file,
  }) async {
    String res = "Something went wrong";
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty ||
          bio.isNotEmpty ||
          file != null) {
        // register user
        UserCredential credential = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        print(credential.user!.uid);

        // save profile image
        String photoUrl = await StorageMethods()
            .uploadImageToStorage('profilePics', file, false);

        // add user to database
        model.User user = model.User(
            email: email,
            uid: credential.user!.uid,
            photoUrl: photoUrl,
            username: username,
            bio: bio,
            followers: [],
            following: []);

        await _firestore.collection('users').doc(credential.user!.uid).set(
              user.toJson(),
            );

        res = "Successfully registered";
      }
    }
    // on FirebaseAuthException catch (error) {
    //   if (error.code == 'invalid-email') {
    //     res = 'The email is badly formatted';
    //   } else if (error.code == 'weak-password') {
    //     res = 'Password should be at least 6 characters';
    //   }
    // }
    catch (error) {
      res = error.toString();
    }
    return res;
  }

  // login user
  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = 'Something went wrong';

    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = "Login successful";
      } else {
        res = "Email and password cannot be empty";
      }
    } on FirebaseAuthException catch (error) {
      if (error.code == 'invalid-email') {
        res = 'Email is badly formatted';
      } else if (error.code == 'user-not-found') {
        res = 'Invalid credentials';
      } else if (error.code == 'invalid-credential') {
        res = 'Invalid credentials';
      }
    } catch (error) {
      res = error.toString();
    }
    return res;
  }
}
