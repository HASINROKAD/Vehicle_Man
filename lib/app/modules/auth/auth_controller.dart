import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:vehicle_man/app/routes/app_routes.dart';

import '../../../firebase/database/fb_collection.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  RxBool isloading = false.obs;

  @override
  void onInit() {
    super.onInit();
    // _googleSignIn.initialize();/
    _googleSignIn.initialize(
      serverClientId:
          '15354620310-0qolli9o97ad38k0smkotnq1fl13ks3b.apps.googleusercontent.com',
    );
  }

  Future<void> signInWithGoogle() async {
    try {
      isloading.value = true;

      final GoogleSignInAccount? googleUser = await _googleSignIn
          .authenticate();

      if (googleUser == null) {
        // User cancelled the sign-in
        throw ('User cancelled Google Sign-In');
      }
      print('Google Sign-In successful: ${googleUser.email}');

      final googleAuth = googleUser.authentication;

      print('Got Google auth tokens');

      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      final userCred = await _auth.signInWithCredential(
        credential,
      ); //important line
      print(userCred);
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    } finally {
      isloading.value = false;
    }
  }

  Future<void> login({required String email, required String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      Get.offAllNamed(AppRoutes.homeView);
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Login Failed", e.message ?? "Something went wrong");
    }
  }

  Future<void> register({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String mobileNumber,
  }) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await _firestore.collection(FbCollection.userCollection).add({
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'mobile_number': mobileNumber,
      });

      Get.back();
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Register Failed", e.message ?? "Something went wrong");
    }
  }

  Future<void> logout() async {
    await _googleSignIn.disconnect();
    await _auth.signOut();
  }
}
