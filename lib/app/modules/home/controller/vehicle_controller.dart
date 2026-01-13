import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vehicle_man/data/models/vehicle_model.dart';
import 'package:vehicle_man/firebase/database/fb_collection.dart';

class VehicleController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  RxList<VehicleModel> vehicles = <VehicleModel>[].obs;
  RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchVehicles();
  }

  Future<void> addVehicle(String name, String number, String ownerName) async {
    await _firestore.collection(FbCollection.vehicleCollection).add({
      'name': name,
      'number': number,
      'ownerName': ownerName,
    });
  }

  void fetchVehicles() {
    isLoading.value = true;
    _firestore
        .collection('vehicle_data')
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
}
