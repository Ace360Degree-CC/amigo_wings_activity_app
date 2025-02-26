import 'dart:convert';
import 'dart:io';
import 'package:amigo_academy/screens/thankyou.dart';
import 'package:flutter/material.dart';
import 'package:searchfield/searchfield.dart';
import 'package:http/http.dart' as http;
import '../api_services/api_service.dart';
import '../widgets/custom_txtField.dart';
import 'package:path_provider/path_provider.dart';
import 'package:csv/csv.dart';


class AddStudent extends StatefulWidget {
  const AddStudent({super.key});

  @override
  State<AddStudent> createState() => _AddStudentState();
}

enum Streams { arts, commerce, science }

class _AddStudentState extends State<AddStudent> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  // Controllers for input fields
  TextEditingController nameController = TextEditingController();
  TextEditingController phone1Controller = TextEditingController();
  TextEditingController phone2Controller = TextEditingController();
  TextEditingController collegeController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  // Stream and college selection
  Streams stream = Streams.arts;
  String? _selectedCollege;
  List<String> colleges = [];

  // Current Date Variables
  late String formattedDate;

  @override
  void initState() {
    super.initState();
    fetchCollege();

    // Format date to YYYY-MM-DD
    var now = DateTime.now();
    formattedDate = "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";
  }
  Future<void> saveDataLocally() async {
    String studentName = nameController.text.trim();
    String collegeName = _selectedCollege?.isNotEmpty == true ? _selectedCollege! : collegeController.text.trim();
    String phone1 = phone1Controller.text.trim();
    String phone2 = phone2Controller.text.trim();
    String location = locationController.text.trim();
    String streamValue = stream == Streams.arts ? "Arts" : stream == Streams.commerce ? "Commerce" : "Science";

    if (studentName.isEmpty || collegeName.isEmpty || phone1.isEmpty || location.isEmpty) {
      print("❌ ERROR: Required fields are missing!");
      return;
    }

    List<String> row = [
      studentName,
      phone1,
      phone2,
      collegeName,
      location,
      streamValue,
      formattedDate,
    ];

    // ✅ Get directory to store the CSV file
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/students.csv');

    List<List<String>> data = [];

    // ✅ If file exists, load previous data
    if (await file.exists()) {
      String content = await file.readAsString();
      List<List<dynamic>> rows = const CsvToListConverter().convert(content);
      data = rows.map((row) => row.map((cell) => cell.toString()).toList()).toList();
    }

    data.add(row); // ✅ Add new entry
    String csv = const ListToCsvConverter().convert(data);

    await file.writeAsString(csv); // ✅ Save to file

    print("✅ Student data saved locally: ${file.path}");
    showSuccessModal();
  }
  /// ✅ Fetch available colleges from API
  Future<void> fetchCollege() async {
    try {
      var response = await http.get(Uri.parse('https://nationalskillprogram.com/amigo_lead_generation/lead_source.php'));

      if (response.statusCode == 200) {
        var data = json.decode(response.body)['result'];
        setState(() {
          colleges = List<String>.from(data.map((item) => item['lead_source'].toString()));
        });
      } else {
        print("❌ Failed to fetch colleges: ${response.statusCode}");
      }
    } catch (e) {
      print("❌ Error fetching colleges: $e");
    }
  }

  /// ✅ Sends data to the server after validation
  Future<void> sendDataToServer() async {
    String studentName = nameController.text.trim();
    String collegeName = _selectedCollege?.isNotEmpty == true ? _selectedCollege! : collegeController.text.trim();
    String phone1 = phone1Controller.text.trim();
    String phone2 = phone2Controller.text.trim();
    String location = locationController.text.trim();
    String streamValue = stream == Streams.arts ? "Arts" : stream == Streams.commerce ? "Commerce" : "Science";

    // ❌ Prevent submission if required fields are empty
    if (studentName.isEmpty || collegeName.isEmpty || phone1.isEmpty || location.isEmpty) {
      print("❌ ERROR: Required fields are missing!");
      return;
    }

    Map<String, String> payload = {
      'student_id': ApiServices.studentId,
      'branch_id': ApiServices.branch,
      'name': studentName,
      'phone_1': phone1,
      'phone_2': phone2,
      'college': collegeName,
      'location': location,
      'stream': streamValue,
      'created_date': formattedDate,
      'status': "1"
    };

    print("📌 Sending Payload: $payload");

    try {
      final response = await http.post(
        Uri.parse("https://nationalskillprogram.com/amigo_lead_generation/add_enquery.php"),
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: payload,
      );

      if (response.statusCode == 200) {
        print('✅ Data sent successfully');
        print('📌 Server Response: ${response.body}');
        showSuccessModal();
      } else {
        print('❌ Failed to send data. Status Code: ${response.statusCode}');
        print('📌 Response Body: ${response.body}');
      }
    } catch (e) {
      print("❌ Error sending data: $e");
    }
  }

  /// ✅ Shows success modal after successful submission
  void showSuccessModal() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ThankYouScreen()));
              },
              child: Text("OK", style: TextStyle(color: Colors.blue)),
            ),
          ],
        );
      },
    );
  }

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
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 40),
          child: Form(
            key: _key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Student Name', style: TextStyle(fontSize: 18)),
                CustomTextField(
                  controller: nameController,
                  validator: (val) {
                    if (val!.isEmpty) return "Please enter name";
                    if (!RegExp(r"^[a-zA-Z\s]+$").hasMatch(val)) return "Only letters allowed";
                    return null;
                  },
                ),

                const SizedBox(height: 20),
                const Text('Phone no 1', style: TextStyle(fontSize: 18)),
                CustomTextField(
                  controller: phone1Controller,
                  validator: (val) {
                    if (val!.isEmpty) return "Please enter phone number";
                    if (!RegExp(r"^\d{10}$").hasMatch(val)) return "Enter a valid 10-digit number";
                    return null;
                  },
                ),

                const SizedBox(height: 20),
                const Text('Phone no 2 (Optional)', style: TextStyle(fontSize: 18)),
                CustomTextField(
                  controller: phone2Controller,
                  validator: (val) {
                    if (val!.isNotEmpty && !RegExp(r"^\d{10}$").hasMatch(val)) return "Enter a valid 10-digit number";
                    return null;
                  },
                ),

                const SizedBox(height: 20),
                const Text('College', style: TextStyle(fontSize: 18)),
                SearchField(
                  hint: 'Search College here..',
                  suggestions: colleges.map((e) => SearchFieldListItem(e, child: Padding(
                      padding: const EdgeInsets.all(8.0), child: Text(e)))).toList(),
                  onSubmit: (val) {
                    setState(() {
                      _selectedCollege = val.trim();
                      collegeController.text = val.trim();
                    });
                    print("📌 Selected College Updated: $_selectedCollege");
                  },
                ),
                const SizedBox(height: 20),

                const Text('Location', style: TextStyle(fontSize: 18)),
                CustomTextField(controller: locationController, validator: (val) => val!.isEmpty ? "Please enter location" : null),
                const SizedBox(height: 20),

                const Text('Stream:', style: TextStyle(fontSize: 18)),
                Row(
                  children: [
                    Radio(value: Streams.arts, groupValue: stream, onChanged: (Streams? val) => setState(() => stream = val!)),
                    const Text("Arts"),
                    Radio(value: Streams.commerce, groupValue: stream, onChanged: (Streams? val) => setState(() => stream = val!)),
                    const Text("Commerce"),
                    Radio(value: Streams.science, groupValue: stream, onChanged: (Streams? val) => setState(() => stream = val!)),
                    const Text("Science"),
                  ],
                ),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Color(0xffD4000A)),
                    onPressed: () {
                      if (_key.currentState!.validate()) saveDataLocally();
                    },
                    child: const Text("Add Student", style: TextStyle(color: Colors.white70)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
