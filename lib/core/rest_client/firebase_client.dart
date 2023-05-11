import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseClient {
  static FirebaseFirestore database() {
    FirebaseFirestore database = FirebaseFirestore.instance;
    return database;
  }
}
