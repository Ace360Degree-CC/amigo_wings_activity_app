import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../model/user_model.dart';

class ApiServices {
  static String studentId = '';
  static String branch = '';
  static String batchNo = '';
  static String name = '';
  static String fatherName = '';
  static String surname = '';
  static String email = '';
  static String rollNO = '';
  static String course = '';
  static String MobileNo = '';
  static String profilePic = ''; // ✅ Add profile picture variable

  static int otp = 0;
  static String error = '';
  Future<Result> fetchData(String phone) async {
    print('Fetching data for phone: $phone');

    var uri =
        "https://nationalskillprogram.com/amigo_lead_generation/sign_in2.php?phone=${phone}&otp=1234";
    var response = await http.get(Uri.parse(uri));

    if (response.statusCode == 200) {
      String jsonString = response.body.trim();

      if (jsonString.contains('}{')) {
        print("⚠️ API returned multiple JSON objects. Fixing format...");
        jsonString = jsonString.split('}{')[0] + "}"; // ✅ Keep only the first valid JSON
      }

      try {
        var parsedData = json.decode(jsonString);
        if (parsedData['result'] != null && parsedData['result'].isNotEmpty) {
          return Result.fromJson(parsedData['result'][0]);
        } else {
          throw Exception("No data found in response");
        }
      } catch (e) {
        print("❌ JSON Parsing Error: $e");
        throw Exception("Invalid JSON format");
      }
    } else {
      throw Exception("Failed to load data");
    }
  }


  Future<void> sendOtp(phone) async {
    print('otp invoked');
    var uri =
        "https://nationalskillprogram.com/amigo_lead_generation/sign_in.php?phone=${phone}";
    var response = await http.get(Uri.parse(uri));

    if (response.statusCode == 200) {
      var result = json.decode(response.body);

      otp = result['result'][0]['otp'] ?? 0;
      error = result['result'][0]['error'] ?? '';

      print(otp);
      print(error);
    }
  }
}
