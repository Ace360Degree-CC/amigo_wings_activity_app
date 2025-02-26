import 'package:amigo_academy/screens/profile.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:amigo_academy/shared_preferences/user_status.dart';
import 'package:amigo_academy/api_services/api_service.dart';

import 'home.dart';

class Lead extends StatefulWidget {
  const Lead({super.key});

  @override
  State<Lead> createState() => _LeadState();
}

class _LeadState extends State<Lead> {
  String _response = '';
  String? studentId; // ✅ Store student ID dynamically

  @override
  void initState() {
    super.initState();
    _fetchStudentId();
  }

  /// ✅ Fetch student ID dynamically
  Future<void> _fetchStudentId() async {
    try {
      // Retrieve student ID from API or shared preferences
      String? storedStudentId = ApiServices.studentId ??
          await UserStatus().getStudentId(); // ✅ Fallback to shared prefs

      if (storedStudentId != null) {
        setState(() {
          studentId = storedStudentId;
        });
        getLeadData(storedStudentId); // ✅ Call API with dynamic student ID
      } else {
        print("⚠️ No student ID found. Please log in again.");
      }
    } catch (e) {
      print("Error fetching student ID: $e");
    }
  }

  /// ✅ Fetch lead data dynamically using student ID
  Future<void> getLeadData(String studentId) async {
    try {
      var uri =
          "https://nationalskillprogram.com/amigo_lead_generation/enquery_count.php?student_id=${studentId}";
      var response = await http.get(Uri.parse(uri));

      if (response.statusCode == 200) {
        String jsonString = response.body.trim();

        // ✅ Check if the response is valid JSON
        if (jsonString.contains('}{')) {
          print("⚠️ API returned multiple JSON objects. Fixing format...");

          // ✅ Extract only the first valid JSON object
          jsonString = jsonString.split('}{')[0] + "}"; // Keep only first JSON
        }

        var result = json.decode(jsonString);

        if (result.containsKey('result')) {
          setState(() {
            _response = 'Data fetched successfully';
          });
        }
      } else {
        print("⚠️ API Error: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching lead data: $e");
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: 30, left: 15, right: 15),
        child: Column(children: [
          studentId == null
              ? const Center(
                  child: CircularProgressIndicator(color: Color(0xffD4000A)))
              : _response == 'Not updated any student detail yet'
                  ? const Text(
                      'No data to show',
                      style: TextStyle(
                          color: Color(0xffD4000A),
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    )
                  : Column(
                      children: [
                        Table(
                          border: TableBorder.all(),
                          children: const [
                            TableRow(children: [
                              Center(
                                  child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('S. No'),
                              )),
                              Center(
                                  child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('Date'),
                              )),
                              Center(
                                  child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('Count'),
                              )),
                            ]),
                            TableRow(children: [
                              Center(
                                  child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('1'),
                              )),
                              Center(
                                  child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('25/02/2023'),
                              )),
                              Center(
                                  child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('25'),
                              )),
                            ]),
                          ],
                        ),
                        Container(
                          height: 110,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12)),
                          child: Card(
                            elevation: 8,
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text(
                                    'Total Lead Count :',
                                    style: TextStyle(
                                        color: Color(0xff6F6F6F),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 19),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    '360',
                                    style: TextStyle(
                                        fontSize: 26, color: Color(0xffD4000A)),
                                  ),
                                ]),
                          ),
                        ),
                      ],
                    ),
          const SizedBox(height: 20),
          Container(
              height: 200,
              width: MediaQuery.of(context).size.width,
              child: Image.asset(
                'assets/logo_red.png',
                color: Colors.grey.shade400,
              ))
        ]),
      ),
    );
  }
}
