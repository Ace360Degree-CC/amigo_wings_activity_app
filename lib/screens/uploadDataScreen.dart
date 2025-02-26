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
        _students = rows.map((row) => row.map((cell) => cell.toString()).toList()).toList();
      });
    }
  }

  /// ✅ Upload data to server
  Future<void> _uploadData() async {
    if (_students.isEmpty) {
      print("❌ No data to upload!");
      return;
    }

    for (var row in _students) {
      Map<String, String> payload = {
        'name': row[0],
        'phone_1': row[1],
        'phone_2': row[2],
        'college': row[3],
        'location': row[4],
        'stream': row[5],
        'created_date': row[6],
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
                  title: Text(_students[index][0]), // Name
                  subtitle: Text("Phone: ${_students[index][1]}"),
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
