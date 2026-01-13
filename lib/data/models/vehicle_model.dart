class VehicleModel {
  String? id;
  String name;
  String number;
  String ownerName;

  VehicleModel({
    this.id,
    required this.name,
    required this.number,
    required this.ownerName,
  });

  Map<String, dynamic> toMap() {
    return {'name': name, 'number': number, 'ownerName': ownerName};
  }

  factory VehicleModel.fromMap(Map<String, dynamic> map, String docId) {
    return VehicleModel(
      id: docId,
      name: map['name'],
      number: map['number'],
      ownerName: map['ownerName'],
    );
  }
}
