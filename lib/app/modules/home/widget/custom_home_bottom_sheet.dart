import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vehicle_man/app/modules/home/controller/vehicle_controller.dart';
import 'package:vehicle_man/widgets/common/custom_button.dart';
import 'package:vehicle_man/widgets/common/custom_text_field.dart';

class CustomHomeBottomSheet extends GetView<VehicleController> {
  const CustomHomeBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 20),
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 4,
            width: 40,
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: Colors.grey.shade400,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          CustomTextField(
            hintText: 'vehicle name',
            controller: controller.nameCtrl,
          ),
          CustomTextField(
            hintText: 'vehicle number',
            controller: controller.numberCtrl,
          ),
          CustomTextField(
            hintText: 'owner name',
            controller: controller.ownerCtrl,
          ),

          Obx(
            () => CustomButton(
              text: controller.isEditMode.value ? 'Update' : 'Submit',
              onTap: controller.saveVehicle,
            ),
          ),
        ],
      ),
    );
  }
}
