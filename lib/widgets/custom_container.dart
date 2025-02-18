import 'package:flutter/material.dart';

class CustomContainer extends StatefulWidget {
  String title;
  String subtitle;
  CustomContainer({required this.title, required this.subtitle, super.key});

  @override
  State<CustomContainer> createState() => _CustomContainerState();
}

class _CustomContainerState extends State<CustomContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
      child: Card(
        elevation: 8,
      
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              widget.title,
              style: const TextStyle(
                  //6F6F6F
                  color: Color(0xff6F6F6F),
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                widget.subtitle,
                style: const TextStyle(color: Colors.black45),
              ),
            )
          ],
        ),
        // ),
      ),
    );
  }
}
