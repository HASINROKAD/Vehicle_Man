import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vehicle_man/data/models/vehicle_model.dart';
import 'package:vehicle_man/firebase/database/fb_collection.dart';

class VehicleController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  final nameCtrl = TextEditingController();
  final numberCtrl = TextEditingController();
  final ownerCtrl = TextEditingController();

  RxBool isEditMode = false.obs;
  String? editingVehicleId;

  RxList<VehicleModel> vehicles = <VehicleModel>[].obs;
  RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchVehicles();
  }

  void startEdit(VehicleModel vehicle) {
    isEditMode.value = true;
    editingVehicleId = vehicle.id;

    nameCtrl.text = vehicle.name;
    numberCtrl.text = vehicle.number;
    ownerCtrl.text = vehicle.ownerName;
  }

  Future<void> saveVehicle() async {
    final uid = _firebaseAuth.currentUser!.uid;

    if (isEditMode.value) {
      // 🔄 UPDATE
      await _firestore
          .collection(FbCollection.vehicleCollection)
          .doc(editingVehicleId)
          .update({
            'name': nameCtrl.text.trim(),
            'number': numberCtrl.text.trim(),
            'ownerName': ownerCtrl.text.trim(),
          });
    } else {
      // ➕ ADD
      await _firestore.collection(FbCollection.vehicleCollection).add({
        'name': nameCtrl.text.trim(),
        'number': numberCtrl.text.trim(),
        'ownerName': ownerCtrl.text.trim(),
        'userId': uid,
        'createdAt': FieldValue.serverTimestamp(),
      });
    }

    clearForm();
    Get.back();
  }

  void fetchVehicles() {
    isLoading.value = true;
    final uid = _firebaseAuth.currentUser!.uid;
    _firestore
        .collection('vehicle_data')
        .where('userId', isEqualTo: uid)
        .snapshots()
        .listen(
          (snapshot) {
            debugPrint('🔥 Firestore snapshot received');

            for (var doc in snapshot.docs) {
              debugPrint('🆔 ${doc.id} → ${doc.data()}');
            }

            vehicles.value = snapshot.docs
                .map((doc) => VehicleModel.fromMap(doc.data(), doc.id))
                .toList();

            isLoading.value = false;
          },
          onError: (error) {
            isLoading.value = false;
            debugPrint('❌ Firestore error: $error');
          },
        );
  }

  Future<void> updateVehicle(
    String id,
    String name,
    String number,
    String ownerName,
  ) async {
    await _firestore.collection(FbCollection.vehicleCollection).doc(id).update({
      'name': name,
      'number': number,
      'ownerName': ownerName,
    });
  }

  Future<void> deleteVehicle(String id) async {
    await _firestore
        .collection(FbCollection.vehicleCollection)
        .doc(id)
        .delete();
  }

  void clearForm() {
    nameCtrl.clear();
    numberCtrl.clear();
    ownerCtrl.clear();
    isEditMode.value = false;
    editingVehicleId = null;
  }

  @override
  void onClose() {
    nameCtrl.dispose();
    numberCtrl.dispose();
    ownerCtrl.dispose();
    super.onClose();
  }
}
