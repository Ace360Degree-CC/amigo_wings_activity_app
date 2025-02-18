import 'dart:convert';

import 'package:amigo_academy/screens/thankyou.dart';
import 'package:flutter/material.dart';
import 'package:searchfield/searchfield.dart';
import 'package:http/http.dart' as http;
import '../api_services/api_service.dart';
import '../widgets/custom_txtField.dart';

class AddStudent extends StatefulWidget {
  const AddStudent({super.key});

  @override
  State<AddStudent> createState() => _AddStudentState();
}

enum Streams { arts, commerce, science }

class _AddStudentState extends State<AddStudent> {
  var now = new DateTime.now();
  String todays_date = '';
  String todays_month = '';
  String yearn = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchCollege();
    var now = new DateTime.now();
    todays_date = now.day.toString();
    todays_month = now.month.toString();
    yearn = now.year.toString();
  }

  Future<void> sendDataToServer(
      String student_id,
      String branch_id,
      String student_name,
      String phone_1,
      String phone_2,
      String college,
      String location,
      String stream,
      String created_date,
      String status) async {
    student_id = student_id.toString();
    branch_id = branch_id.toString();
    phone_1 = phone_1.toString();
    phone_2 = phone_2.toString();
    status = status.toString();

    Map<String, String> payload = {
      'student_id': student_id,
      'branch_id': branch_id,
      'name': student_name,
      'phone_1': phone_1,
      'phone_2': phone_2,
      'college': college,
      'location': location,
      'stream': stream,
      'created_date': created_date,
      'status': status
    };

    String url =
        "https://nationalskillprogram.com/amigo_lead_generation/add_enquery.php"
        "?student_id=${Uri.encodeComponent(student_id)}"
        "&branch_id=${Uri.encodeComponent(branch_id)}"
        "&student_name=${Uri.encodeComponent(student_name)}"
        "&phone_1=${Uri.encodeComponent(phone_1)}"
        "&phone_2=${Uri.encodeComponent(phone_2)}"
        "&college=${Uri.encodeComponent(college)}"
        "&location=${Uri.encodeComponent(location)}"
        "&stream=${Uri.encodeComponent(stream)}"
        "&created_date=${Uri.encodeComponent(created_date)}"
        "&status=${Uri.encodeComponent(status)}";

    final response = await http.post(Uri.parse(url),
        body: json.encode(payload),
        headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      print(response.body);
      print('✅ Data sent successfully');

      // ✅ Show success modal after successful submission
      showSuccessModal();
    } else {
      print('❌ Failed to send data. Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');
    }
  }

  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  void showSuccessModal() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Text("Success!", textAlign: TextAlign.center),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.check_circle, color: Colors.green, size: 50),
              SizedBox(height: 10),
              Text(
                "Student data added successfully!",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close modal
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => ThankYouScreen()));
              },
              child: Text("OK", style: TextStyle(color: Colors.blue)),
            ),
          ],
        );
      },
    );
  }

  List<String> colleges = [];
  void fetchCollege() async {
    var uri =
        'https://nationalskillprogram.com/amigo_lead_generation/lead_source.php';

    var response = await http.get(Uri.parse(uri));
    if (response.statusCode == 200) {
      var data = json.decode(response.body)['result'];
      print(data);
      for (Map i in data) {
        //   colleges.add(data[i]["lead_source"]);
        colleges.add(i['lead_source']);
      }
      for (int i = 0; i < colleges.length; i++) {
        print(colleges[i]);
      }
      print(colleges.length);
    }
  }

  Streams stream = Streams.arts;
  TextEditingController nameController = TextEditingController();
  var items = [
    'Working a lot harder',
    'Being a lot smarter',
    'Being a self-starter',
    'Placed in charge of trading charter',
  ];
  String? _selectedCollege;
  TextEditingController phone1Controller = TextEditingController();
  TextEditingController phone2Controller = TextEditingController();
  TextEditingController collegeController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back)),
          backgroundColor: Color(0xffD4000A),
          title: const Text("Add Student")),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.only(left: 12.0, right: 12, top: 40),
          child: Form(
            key: _key,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text(
                'Student Name',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextField(
                controller: nameController,
                validator: (val) {
                  if (val!.isEmpty || val == '') {
                    return "please enter name";
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(
                height: 20,
              ),
              const Text('Phone no 1', style: TextStyle(fontSize: 18)),
              const SizedBox(
                height: 10,
              ),
              CustomTextField(
                controller: phone1Controller,
                validator: (val) {
                  if (val!.isEmpty || val == '') {
                    return "please enter phone1";
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(
                height: 20,
              ),
              const Text('Phone no 2', style: TextStyle(fontSize: 18)),
              const SizedBox(
                height: 10,
              ),
              CustomTextField(
                controller: phone2Controller,
                validator: (val) {
                  if (val!.isEmpty || val == '') {
                    return "please enter phone2";
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(
                height: 20,
              ),
              const Text('College', style: TextStyle(fontSize: 18)),
              const SizedBox(
                height: 10,
              ),
              // Material(
              //   elevation: 10,
              //   child: Container(
              //     height: 50,
              //     decoration: BoxDecoration(
              //       color: Colors.white,
              //       borderRadius: BorderRadius.circular(10),
              //     ),
              //     child: Padding(
              //       padding: EdgeInsets.only(left: 10, top: 10),
              //       child: Row(
              //         children: [
              //           Expanded(
              //             child: TextField(
              //                 controller: collegeController,
              //                 decoration:
              //                     InputDecoration.collapsed(hintText: '')),
              //           ),
              //           new PopupMenuButton<String>(
              //             icon: const Icon(Icons.arrow_drop_down),
              //             onSelected: (String value) {
              //               collegeController.text = value;
              //             },
              //             itemBuilder: (BuildContext context) {
              //               return items
              //                   .map<PopupMenuItem<String>>((String value) {
              //                 return new PopupMenuItem(
              //                     child: new Text(value), value: value);
              //               }).toList();
              //             },
              //           ),
              //           // IconButton(
              //           //     onPressed: () {}, icon: Icon(Icons.arrow_drop_down))
              //         ],
              //       ),
              //     ),
              //   ),
              // ),

              Container(
                height: 60,
                margin: EdgeInsets.symmetric(horizontal: 2),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          blurRadius: 10,
                          offset: Offset(0, 10))
                    ]),
                child: SearchField(
                  hint: 'Search College here..',
                  searchInputDecoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.blueGrey.shade200, width: 0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.blueGrey.shade200, width: 0),
                    ),
                  ),
                  itemHeight: 60,
                  emptyWidget: Text(
                    "No result found!",
                    style: TextStyle(color: Colors.red),
                  ),
                  maxSuggestionsInViewPort: 6,
                  suggestionsDecoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  onSubmit: (val) {
                    setState(() {
                      _selectedCollege = val;
                    });
                  },
                  suggestions: [
                    "Facebook",
                    " Data ",
                    " Google",
                    " Student reference",
                    " Walkin Friend",
                    " website Enquiry",
                    " Caller Personal Reference",
                    " Instagram",
                    " wings feb 2020",
                    " Online counseling",
                    " Online Seminar",
                    " Telephonic Enquiry ",
                    " Superadmin  ",
                    " Floor mang ",
                    " Direct Walkin  ",
                    " Testing",
                    " NKES College 2021",
                    " NG Bedekar College Thane 2021",
                    " Shreeram College Bhandup 2021",
                    " Ambedkar College Chembur 2021",
                    " Ambedkar College Wadala 2021",
                    " Reckon College Nallasopara 2021 "
                  ]
                      .map((e) => SearchFieldListItem(e,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(e),
                          )))
                      .toList(),
                ),
              ),

              SizedBox(
                height: 20,
              ),
              const Text('Location ', style: TextStyle(fontSize: 18)),
              const SizedBox(
                height: 10,
              ),
              CustomTextField(
                controller: locationController,
                validator: (val) {
                  if (val!.isEmpty || val == '') {
                    return "please enter location";
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(
                height: 20,
              ),
              const Text('Stream:', style: TextStyle(fontSize: 18)),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Radio(
                      value: Streams.arts,
                      groupValue: stream,
                      fillColor: MaterialStateColor.resolveWith(
                          (states) => Colors.black),
                      onChanged: (Streams? val) {
                        setState(() {
                          stream = val!;
                        });
                      }),
                  const Text("Arts"),
                  Radio(
                      value: Streams.commerce,
                      groupValue: stream,
                      fillColor: MaterialStateColor.resolveWith(
                          (states) => Colors.black),
                      onChanged: (Streams? val) {
                        setState(() {
                          stream = val!;
                        });
                      }),
                  const Text("Commerce"),
                  Radio(
                      value: Streams.science,
                      groupValue: stream,
                      fillColor: MaterialStateColor.resolveWith(
                          (states) => Colors.black),
                      onChanged: (Streams? val) {
                        setState(() {
                          stream = val!;
                        });
                      }),
                  const Text("Science"),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  height: 40,
                  width: 130,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xffD4000A)),
                      onPressed: () {
                        if (_key.currentState!.validate()) {
                          sendDataToServer(
                              ApiServices.studentId,
                              ApiServices.branch,
                              ApiServices.name,
                              phone1Controller.text,
                              phone2Controller.text,
                              collegeController.text,
                              locationController.text,
                              stream.toString(),
                              todays_date + "/" + todays_month + "/" + yearn,
                              "1");
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) =>
                          //             const ThankYouScreen()));
                        }
                      },
                      child: const FittedBox(
                          child: Text(
                        "Add Student",
                        style: TextStyle(color: Colors.white70),
                      ))),
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
