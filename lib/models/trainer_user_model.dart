import 'dart:convert';

class TrainerUserModel {
  String id;
  String trainerId;
  String firstName;
  String lastName;
  double price;
  String paymentKey;
  double rating;
  bool active;
  bool accepted;
  bool hasResponse;
  String? fcmToken;

  TrainerUserModel({
    required this.id,
    required this.trainerId,
    required this.firstName,
    required this.lastName,
    required this.price,
    required this.paymentKey,
    required this.rating,
    required this.active,
    required this.accepted,
    required this.hasResponse,
    this.fcmToken,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'trainerId': trainerId,
      'firstName': firstName,
      'lastName': lastName,
      'price': price,
      'paymentKey': paymentKey,
      'rating': rating,
      'active': active,
      'accepted': accepted,
      'hasResponse': hasResponse,
      'fcm_token': fcmToken,
    };
  }

  factory TrainerUserModel.fromMap(Map<String, dynamic> map) {
    return TrainerUserModel(
      id: map['id'] ?? '',
      trainerId: map['trainerId'] ?? '',
      firstName: map['firstName'] ?? '',
      lastName: map['lastName'] ?? '',
      price: map['price']?.toDouble() ?? 0.0,
      paymentKey: map['paymentKey'] ?? '',
      rating: map['rating']?.toDouble() ?? 0.0,
      active: map['active'] ?? false,
      accepted: map['accepted'] ?? false,
      hasResponse: map['hasResponse'] ?? false,
      fcmToken: map['fcmToken'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory TrainerUserModel.fromJson(String source) =>
      TrainerUserModel.fromMap(json.decode(source));
}
