class UserModel {
  String? id;
  String? name;
  String? email;
  String? phoneNumber;
  String? avatar;

  UserModel({this.name, this.email, this.phoneNumber, this.avatar});

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "phone_number": phoneNumber,
        "avatar": avatar,
      };
}
