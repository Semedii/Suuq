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
  String? fCMToken;
  List<String?>? favProducts;

  UserModel({
    this.language = Language.somali,
    this.joinedDate,
    this.address,
    this.id,
    this.name,
    this.email,
    this.phoneNumber,
    this.avatar,
    this.favProducts,
    this.fCMToken,
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
        fCMToken: data?['fCMToken'],
        favProducts: data?['favProducts']?.cast<String>(),
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
      "favProducts": favProducts,
      "fCMToken": fCMToken,
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
        fCMToken: map['fCMToken'],
        favProducts: map['favProducts']?.cast<String>(),
        avatar: map['phone_number']);
  }
}
