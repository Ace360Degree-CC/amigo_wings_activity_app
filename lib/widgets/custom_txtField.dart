import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  TextEditingController controller;
  String? Function(String?)? validator;
  //Widget child;
  CustomTextField({
    Key? key,
    required this.controller,
    required this.validator,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: EdgeInsets.only(left: 10, top: 10),
          child: TextFormField(
              validator: widget.validator,
              controller: widget.controller,
              decoration: InputDecoration.collapsed(hintText: '')),
        ),
      ),
    );
  }
}
