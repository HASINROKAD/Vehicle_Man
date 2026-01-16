import 'package:flutter/material.dart';

class VehicleListItem extends StatelessWidget {
  final String vehicleName;
  final String vehicleNumber;
  final VoidCallback onTap;

  const VehicleListItem({
    super.key,
    required this.vehicleName,
    required this.vehicleNumber,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blue.shade100,
          child: const Icon(Icons.directions_car, color: Colors.blue),
        ),
        title: Text(
          vehicleName,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(vehicleNumber),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}
