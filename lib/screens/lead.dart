import 'package:amigo_academy/screens/profile.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'home.dart';

class Lead extends StatefulWidget {
  const Lead({super.key});

  @override
  State<Lead> createState() => _LeadState();
}

class _LeadState extends State<Lead> {
  String _response = '';
  Future<void> getLeadData(student_id) async {
    var uri =
        "https://nationalskillprogram.com/amigo_lead_generation/enquery_count.php?student_id=${student_id}";
    var response = await http.get(Uri.parse(uri));

    if (response.statusCode == 200) {
      var result = json.decode(response.body);
      print(result['result'][0]['error']);
      setState(() {
        _response = 'Not updated any student detail yet';
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getLeadData(1076);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 30, left: 15, right: 15),
        child: Column(children: [
          _response == 'Not updated any student detail yet'
              ? Text(
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
                      children: [
                        TableRow(children: [
                          Center(
                              child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('S. No'),
                          )),
                          Center(
                              child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Date'),
                          )),
                          Center(
                              child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Count'),
                          )),
                        ]),
                        TableRow(children: [
                          Center(
                              child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('1'),
                          )),
                          Center(
                              child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('25/02/2023'),
                          )),
                          Center(
                              child: Padding(
                            padding: const EdgeInsets.all(8.0),
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
                            children: [
                              const Text(
                                'Total Lead Count :',
                                style: TextStyle(
                                    color: Color(0xff6F6F6F),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 19),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text(
                                '360',
                                style: TextStyle(
                                    fontSize: 26, color: Color(0xffD4000A)),
                              ),
                            ]),
                      ),
                    ),
                  ],
                ),
          SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 20,
          ),
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
