import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService{
  //collection
  final CollectionReference userCollection = Firestore.instance.collection('users');

}