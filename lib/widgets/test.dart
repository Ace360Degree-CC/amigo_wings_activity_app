import 'package:flutter/material.dart';

class CollegeNameField extends StatefulWidget {
  @override
  _CollegeNameFieldState createState() => _CollegeNameFieldState();
}

class _CollegeNameFieldState extends State<CollegeNameField> {
  final TextEditingController _controller = TextEditingController();
  final List<String> _colleges = [
    'Harvard Institute of Technology',
    'ABC Institute of Technology',
    'DEF College of Engineering',
    'GHI Institute of Management',
    'JKL College of Science',
  ];
  String _selectedCollege = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(hintText: 'Enter college name'),
            controller: _controller,
            onChanged: (value) {
              setState(() {
                _selectedCollege = _colleges.firstWhere(
                    (college) =>
                        college.toLowerCase().startsWith(value.toLowerCase()),
                    orElse: () => '');
              });
            },
          ),
          _selectedCollege == null
              ? Text('College not found')
              : Text('$_selectedCollege'),
        ],
      ),
    );
  }
}
