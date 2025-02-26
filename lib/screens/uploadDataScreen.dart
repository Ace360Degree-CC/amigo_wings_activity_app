import 'dart:io';
import 'package:flutter/material.dart';
import 'package:csv/csv.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class UploadDataScreen extends StatefulWidget {
  const UploadDataScreen({super.key});

  @override
  State<UploadDataScreen> createState() => _UploadDataScreenState();
}

class _UploadDataScreenState extends State<UploadDataScreen> {
  List<List<String>> _students = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  /// ✅ Load stored CSV data
  Future<void> _loadData() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/students.csv');

    if (await file.exists()) {
      String content = await file.readAsString();
      List<List<dynamic>> rows = const CsvToListConverter().convert(content);

      setState(() {
        _students = rows.map((row) {
          // ✅ Ensure at least 9 columns exist
          if (row.length < 9) {
            print("❌ ERROR: Incorrect data format in CSV: $row");
            return List<String>.filled(9, "");  // Fallback empty row
          }
          return row.map((cell) => cell.toString()).toList();
        }).toList();
      });

      print("✅ Loaded Data: $_students");
    }
  }


  /// ✅ Upload data to server
  Future<void> _uploadData() async {
    if (_students.isEmpty) {
      print("❌ No data to upload!");
      return;
    }

    for (var row in _students) {
      if (row.length < 9) {
        print("❌ ERROR: Skipping row due to incorrect format: $row");
        continue;  // ✅ Skip improperly formatted rows
      }

      Map<String, String> payload = {
        'student_id': row[0],  // ✅ Send student ID
        'branch_id': row[1],   // ✅ Send branch ID
        'name': row[2],
        'phone_1': row[3],
        'phone_2': row[4],
        'college': row[5],
        'location': row[6],
        'stream': row[7],
        'created_date': row[8],
        'status': "1"
      };

      print("📌 Uploading: $payload");

      try {
        final response = await http.post(
          Uri.parse("https://nationalskillprogram.com/amigo_lead_generation/add_enquery.php"),
          headers: {'Content-Type': 'application/x-www-form-urlencoded'},
          body: payload,
        );

        if (response.statusCode == 200) {
          print('✅ Uploaded successfully: ${response.body}');
        } else {
          print('❌ Failed to upload: ${response.statusCode}');
        }
      } catch (e) {
        print("❌ Error uploading: $e");
      }
    }

    // ✅ Clear local file after upload
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/students.csv');
    await file.delete();
    setState(() {
      _students.clear();
    });

    print("✅ All data uploaded and local file deleted!");
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Upload Data")),
      body: Column(
        children: [
          Expanded(
            child: _students.isEmpty
                ? const Center(child: Text("No data available"))
                : ListView.builder(
              itemCount: _students.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text("Student Name: ${_students[index][2]}"), // Name
                  subtitle: Text("Phone: ${_students[index][3]}"),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: _uploadData,
            child: const Text("Upload Data"),
          ),
        ],
      ),
    );
  }
}
