// To parse required this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
    UserModel({
        required this.id,
        required this.idNo,
        required this.fname,
        required this.mname,
        required this.lname,
        required this.gender,
        required this.dob,
        required this.email,
        required this.mobile,
        required this.address,
        required this.photo,
        required this.username,
        required this.password,
        required this.type,
        required this.status,
        required this.createdDt,
        required this.updatedDt,
    });

    int id;
    String idNo;
    String fname;
    String mname;
    String lname;
    String gender;
    DateTime dob;
    String email;
    String mobile;
    String address;
    String photo;
    String username;
    String password;
    int type;
    int status;
    DateTime createdDt;
    DateTime updatedDt;

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        idNo: json["id_no"],
        fname: json["fname"],
        mname: json["mname"],
        lname: json["lname"],
        gender: json["gender"],
        dob: DateTime.parse(json["dob"]),
        email: json["email"],
        mobile: json["mobile"],
        address: json["address"],
        photo: json["photo"],
        username: json["username"],
        password: json["password"],
        type: json["type"],
        status: json["status"],
        createdDt: DateTime.parse(json["created_dt"]),
        updatedDt: DateTime.parse(json["updated_dt"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "id_no": idNo,
        "fname": fname,
        "mname": mname,
        "lname": lname,
        "gender": gender,
        "dob": "${dob.year.toString().padLeft(4, '0')}-${dob.month.toString().padLeft(2, '0')}-${dob.day.toString().padLeft(2, '0')}",
        "email": email,
        "mobile": mobile,
        "address": address,
        "photo": photo,
        "username": username,
        "password": password,
        "type": type,
        "status": status,
        "created_dt": createdDt.toIso8601String(),
        "updated_dt": updatedDt.toIso8601String(),
    };
}
