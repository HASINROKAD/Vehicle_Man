import 'package:flutter/material.dart';
import 'package:vehicle_man/widgets/common/custom_button.dart';
import 'package:vehicle_man/widgets/common/custom_text_field.dart';

class CustomHomeBottomSheet extends StatelessWidget {
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
            controller: TextEditingController(),
          ),
          CustomTextField(
            hintText: 'vehicle number',
            controller: TextEditingController(),
          ),
          CustomTextField(
            hintText: 'mobile number',
            controller: TextEditingController(),
          ),

          CustomButton(
            text: 'Submit',
            onTap: () {
              //TODO:implemetn on tap
            },
          ),
        ],
      ),
    );
  }
}
