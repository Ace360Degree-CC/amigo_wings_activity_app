import 'package:flutter/material.dart';

class CustomLoginInput extends StatefulWidget {
  TextEditingController controller;
  String text;
  String errorText;
  CustomLoginInput(
      {required this.controller,
      required this.text,
      required this.errorText,
      super.key});

  @override
  State<CustomLoginInput> createState() => _CustomLoginInputState();
}

class _CustomLoginInputState extends State<CustomLoginInput> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30.0, right: 30),
      child: Container(
        height: 55,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28),
            border: Border.all(color: const Color(0xffD4000A), width: 1)),
        child: Padding(
          padding: const EdgeInsets.only(left: 14.0, top: 16),
          child: TextFormField(
            keyboardType: TextInputType.number,
            controller: widget.controller,
            obscureText: true,
            decoration: InputDecoration(
                border: InputBorder.none,
                errorText: widget.errorText,
                hintText: widget.text,
                hintStyle: const TextStyle(color: Colors.grey, fontSize: 16)),
          ),
        ),
      ),
    );
  }
}
