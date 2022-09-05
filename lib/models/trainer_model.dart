import 'dart:convert';

import 'package:tcc_app/models/user_trainer_model.dart';

class TrainerModel {
  String? id;
  String? trainerId;
  String firstName;
  String lastName;
  double price;
  int phone;
  String cpf;
  int cep;
  String about;
  String paymentKey;
  double rating;
  int numberClients;
  List<UserTrainerModel> clients;
  String? fcmToken;

  TrainerModel({
    this.id,
    required this.trainerId,
    required this.firstName,
    required this.lastName,
    required this.price,
    required this.phone,
    required this.cpf,
    required this.cep,
    required this.about,
    required this.paymentKey,
    required this.rating,
    required this.numberClients,
    required this.clients,
    this.fcmToken,
  });

  Map<String, dynamic> toMap() {
    return {
      'trainer_id': trainerId,
      'first_name': firstName,
      'last_name': lastName,
      'price': price,
      'phone': phone,
      'cpf': cpf,
      'cep': cep,
      'about': about,
      'payment_key': paymentKey,
      'rating': rating,
      'number_clients': numberClients,
      'clients': clients.map((e) => e.toMap()).toList(),
      'fcm_token': fcmToken,
    };
  }

  factory TrainerModel.fromMap(
    Map<String, dynamic> map,
    String? id, {
    String? fcmToken,
  }) {
    List<UserTrainerModel> users = [];
    map['clients'].forEach((item) => users.add(UserTrainerModel.fromMap(item)));
    return TrainerModel(
      id: map['id'] ?? id,
      trainerId: map['trainer_id'] ?? '',
      firstName: map['first_name'] ?? '',
      lastName: map['last_name'] ?? '',
      price: map['price']?.toDouble() ?? 0.0,
      phone: map['phone']?.toInt() ?? 0,
      cpf: map['cpf'],
      cep: map['cep']?.toInt() ?? 0,
      about: map['about'] ?? '',
      paymentKey: map['payment_key'] ?? '',
      rating: map['rating']?.toDouble() ?? 0.0,
      numberClients: map['number_clients']?.toInt() ?? 0,
      clients: users,
      fcmToken: fcmToken ?? map['fcm_token'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory TrainerModel.fromJson(
    String source,
    String? id, {
    String? fcmToken,
  }) =>
      TrainerModel.fromMap(
        json.decode(source),
        id,
        fcmToken: fcmToken,
      );
}
