import 'package:flutter/material.dart';

// To parse this JSON data, do
//
//     final collegeModel = collegeModelFromJson(jsonString);

import 'dart:convert';

CollegeModel collegeModelFromJson(String str) => CollegeModel.fromJson(json.decode(str));

String collegeModelToJson(CollegeModel data) => json.encode(data.toJson());

class CollegeModel {
    CollegeModel({
        required this.result,
    });

    List<CollegeResult> result;

    factory CollegeModel.fromJson(Map<String, dynamic> json) => CollegeModel(
        result: List<CollegeResult>.from(json["result"].map((x) => CollegeResult.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "result": List<dynamic>.from(result.map((x) => x.toJson())),
    };
}

class CollegeResult {
    CollegeResult({
        required this.leadSource,
    });

    String leadSource;

    factory CollegeResult.fromJson(Map<String, dynamic> json) => CollegeResult(
        leadSource: json["lead_source"],
    );

    Map<String, dynamic> toJson() => {
        "lead_source": leadSource,
    };
}
