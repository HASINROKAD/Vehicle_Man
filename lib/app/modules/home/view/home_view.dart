import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vehicle_man/app/modules/home/controller/vehicle_controller.dart';
import 'package:vehicle_man/app/modules/home/widget/custom_home_bottom_sheet.dart';
import 'package:vehicle_man/app/modules/home/widget/custom_home_drawer.dart';

class HomeView extends GetView<VehicleController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vehicle-Man'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              controller.clearForm();
              Get.bottomSheet(
                CustomHomeBottomSheet(),
                isScrollControlled: true,
              );
            },
          ),
        ],
      ),
      drawer: CustomHomeDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Obx(() {
          // 🔄 LOADING
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.vehicles.isEmpty) {
            return const Center(child: Text('No vehicles found'));
          }

          return ListView.builder(
            itemCount: controller.vehicles.length,
            itemBuilder: (context, index) {
              final vehicle = controller.vehicles[index];

              return Card(
                elevation: 2,
                margin: const EdgeInsets.symmetric(vertical: 6),
                child: ExpansionTile(
                  leading: CircleAvatar(
                    radius: 22,
                    backgroundColor: Colors.blue.shade100,
                    child: Text(
                      vehicle.ownerName.isNotEmpty
                          ? vehicle.ownerName[0].toUpperCase()
                          : '?',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  title: Text(
                    vehicle.name,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  subtitle: Text(vehicle.number),

                  children: [
                    const Divider(),

                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Owner: ${vehicle.ownerName}',
                            style: const TextStyle(fontSize: 14),
                          ),

                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.blue,
                                ),
                                onPressed: () {
                                  controller.startEdit(vehicle);
                                  Get.bottomSheet(
                                    const CustomHomeBottomSheet(),
                                    isScrollControlled: true,
                                  );
                                },
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  // controller.deleteVehicle(vehicle.id!);
                                  Get.defaultDialog(
                                    title: 'Confirm Deletion',
                                    content: const Text(
                                      'This action cannot be undone.',
                                      textAlign: TextAlign.center,
                                    ),
                                    confirm: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.red,
                                      ),
                                      onPressed: () {
                                        controller.deleteVehicle(vehicle.id!);
                                        Get.back();
                                      },
                                      child: const Text('Delete'),
                                    ),
                                    cancel: OutlinedButton(
                                      onPressed: Get.back,
                                      child: const Text('Cancel'),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
