import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:tcc_app/config/database_variables.dart';
import 'package:tcc_app/models/training_finished_model.dart';

class ProfileService {
  var db = FirebaseFirestore.instance;
}
