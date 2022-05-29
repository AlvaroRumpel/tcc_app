import 'dart:convert';

//         'personal_id': FirebaseAuth.instance.currentUser?.uid, String
//         'first_name': nameController.text, String
//         'last_name': lastNameController.text, String
//         'price': priceController.text, float
//         'phone': phoneController.text, long
//         'cpf': cpfController.text, long
//         'cep': cepController.text, long
//         'about': aboutController.text, String
//         'paymant_key': keyController.text, String
//         'rating': 0, float
//         'number_clients': 0, int

class TrainerModel {
  String? id;
  String personalId;
  String firstName;
  String lastName;
  double price;
  int phone;
  int cpf;
  int cep;
  String about;
  String paymentKey;
  double rating;
  int numberClients;
  List<String> clients;

  TrainerModel({
    this.id,
    required this.personalId,
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
  });

  Map<String, dynamic> toMap() {
    return {
      'personal_id': personalId,
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
      'clients': clients,
    };
  }

  factory TrainerModel.fromMap(Map<String, dynamic> map) {
    return TrainerModel(
      id: map['id'],
      personalId: map['personal_id'] ?? '',
      firstName: map['first_name'] ?? '',
      lastName: map['last_name'] ?? '',
      price: map['price']?.toDouble() ?? 0.0,
      phone: map['phone']?.toInt() ?? 0,
      cpf: map['cpf']?.toInt() ?? 0,
      cep: map['cep']?.toInt() ?? 0,
      about: map['about'] ?? '',
      paymentKey: map['payment_key'] ?? '',
      rating: map['rating']?.toDouble() ?? 0.0,
      numberClients: map['number_clients']?.toInt() ?? 0,
      clients: map['clients'],
    );
  }

  String toJson() => json.encode(toMap());

  factory TrainerModel.fromJson(String source) =>
      TrainerModel.fromMap(json.decode(source));
}
