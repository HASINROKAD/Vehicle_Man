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
  RxString name = ''.obs;
  RxString emailToShow = ''.obs;

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
      // print('Google Sign-In successful: ${googleUser.email}');

      final googleAuth = googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      final userCred = await _auth.signInWithCredential(
        credential,
      ); //important line
      name.value = userCred.user?.displayName ?? 'NO Name';
      emailToShow.value = userCred.user?.email ?? 'No Email';
      Get.offAllNamed(AppRoutes.homeView);
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    } finally {
      isloading.value = false;
    }
  }

  Future<void> login({required String email, required String password}) async {
    try {
      final credWithEmailAndPassword = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final userId = credWithEmailAndPassword.user?.uid;
      final doc = await _firestore
          .collection(FbCollection.userCollection)
          .doc(userId)
          .get();

      if (!doc.exists) {
        throw Exception('User profile not found');
      }
      name.value = '${doc['first_name']} ${doc['last_name']}';
      emailToShow.value = credWithEmailAndPassword.user?.email ?? 'No Email';

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
      final uCred = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final uid = uCred.user!.uid;

      await _firestore.collection(FbCollection.userCollection).doc(uid).set({
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

  Future<void> restoreUserSession() async {
    final user = _auth.currentUser;
    if (user == null) return;

    emailToShow.value = user.email ?? 'No Email';

    // Google user
    if (user.displayName!.isNotEmpty) {
      name.value = user.displayName!;
      return;
    }

    // Email/password user
    final doc = await _firestore
        .collection(FbCollection.userCollection)
        .doc(user.uid)
        .get();

    if (doc.exists) {
      name.value = '${doc['first_name']} ${doc['last_name']}';
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
    Get.offAllNamed(AppRoutes.loginView);
  }
}
