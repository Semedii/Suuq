import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:suuq/utils/enums/language.dart';

class UserModel {
  String? id;
  String? name;
  String? email;
  String? phoneNumber;
  String? avatar;
  String? address;
  Language language;
  DateTime? joinedDate;

  UserModel({
    this.language = Language.somali,
    this.joinedDate,
    this.address,
    this.id,
    this.name,
    this.email,
    this.phoneNumber,
    this.avatar,
  });

  factory UserModel.fromFirestore({
    required DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  }) {
    final data = snapshot.data();
    Timestamp createdDate = data?['joined_date'];
    return UserModel(
        id: data?['uid'],
        language: getLanguageFromString(data?['language']),
        name: data?['name'],
        email: data?['email'],
        address: data?['address'],
        joinedDate: createdDate.toDate(),
        phoneNumber: data?['phone_number'],
        avatar: data?['phone_number']);
  }
  Map<String, dynamic> toFirestore() {
    return {
      "uid": id,
      "name": name,
      "email": email,
      'joined_date': joinedDate,
      "phone_number": phoneNumber,
      "avatar": avatar,
      "address": address,
      "language": languageToString(language),
    };
  }

//for user object in ordermodel
  factory UserModel.fromJson(Map<String, dynamic> map) {
    Timestamp createdDate = map['joined_date'];
    return UserModel(
        id: map['uid'],
        name: map['name'],
        email: map['email'],
        address: map['address'],
        joinedDate: createdDate.toDate(),
        phoneNumber: map['phone_number'],
        avatar: map['phone_number']);
  }
}
