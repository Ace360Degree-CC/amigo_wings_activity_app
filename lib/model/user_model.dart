// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
    UserModel({
        required this.result,
    });

    List<Result> result;

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        result: List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "result": List<dynamic>.from(result.map((x) => x.toJson())),
    };
}

class Result {
    Result({
        required this.studentId,
        required this.branchId,
        required this.batchNo,
        required this.name,
        required this.fatherName,
        required this.surname,
        required this.emailId,
        required this.rollNo,
        required this.course,
        required this.mobileNo,
        required this.profilePic,
    });

    String studentId;
    String branchId;
    String batchNo;
    String name;
    String fatherName;
    String surname;
    String emailId;
    String rollNo;
    String course;
    String mobileNo;
    String profilePic;

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        studentId: json["student_id"],
        branchId: json["branch_id"],
        batchNo: json["batch_no"],
        name: json["name"],
        fatherName: json["father_name"],
        surname: json["surname"],
        emailId: json["email_id"],
        rollNo: json["roll_no"],
        course: json["course"],
        mobileNo: json["mobile_no"],
        profilePic: json["profile_pic"],
    );

    Map<String, dynamic> toJson() => {
        "student_id": studentId,
        "branch_id": branchId,
        "batch_no": batchNo,
        "name": name,
        "father_name": fatherName,
        "surname": surname,
        "email_id": emailId,
        "roll_no": rollNo,
        "course": course,
        "mobile_no": mobileNo,
        "profile_pic": profilePic,
    };
}
