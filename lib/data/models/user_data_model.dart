class UserModel {
  final String id; // Firestore document ID
  final String email;
  final String firstName;
  final String lastName;
  final String mobileNumber;

  UserModel({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.mobileNumber,
  });

  /// Convert Firestore → Dart
  factory UserModel.fromMap(Map<String, dynamic> map, String docId) {
    return UserModel(
      id: docId,
      email: map['email'] ?? '',
      firstName: map['first_name'] ?? '',
      lastName: map['last_name'] ?? '',
      mobileNumber: map['mobile_number'] ?? '',
    );
  }

  /// Convert Dart → Firestore
  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'first_name': firstName,
      'last_name': lastName,
      'mobile_number': mobileNumber,
    };
  }
}
