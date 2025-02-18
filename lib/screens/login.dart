import 'dart:convert';

import 'package:amigo_academy/shared_preferences/user_status.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import '../widgets/custom_login_inputs.dart';
import 'home.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  bool isLoading = false;
  String _response = '';
  int otp = 0;
  String otpError = '';

  Future<void> _sendOtp(String phone) async {
    print('OTP function invoked');
    setState(() {
      isLoading = true;
    });

    var uri =
        "https://nationalskillprogram.com/amigo_lead_generation/sign_in.php?phone=$phone";
    print("Requesting: $uri");

    try {
      var response = await http.get(Uri.parse(uri));

      print("HTTP Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        if (response.body.isEmpty) {
          print("Response body is empty");
          setState(() {
            isLoading = false;
            _response = "Server returned an empty response";
          });
          return;
        }

        try {
          var result = json.decode(response.body);
          print("Response JSON: $result");

          if (result['result'] != null && result['result'].isNotEmpty) {
            var firstResult = result['result'][0];

            if (firstResult.containsKey('error')) {
              setState(() {
                isLoading = false;
                _response = firstResult['error'];
              });
              Navigator.pop(context);
            } else if (firstResult.containsKey('otp')) {
              setState(() {
                isLoading = false;
                otp = firstResult['otp'];
              });
              Navigator.pop(context);
              _showDialog();
            } else {
              setState(() {
                isLoading = false;
                _response = "Failed to get OTP";
              });
            }
          } else {
            setState(() {
              isLoading = false;
              _response = "Invalid response format";
            });
          }
        } catch (e) {
          print("Error parsing JSON: $e");
          setState(() {
            isLoading = false;
            _response = "Invalid response from server";
          });
        }
      } else {
        print("HTTP Request failed: ${response.statusCode}");
        setState(() {
          isLoading = false;
          _response = "Server error. Please try again later.";
        });
      }
    } catch (e) {
      print("Network error: $e");
      setState(() {
        isLoading = false;
        _response = "Network error. Please check your connection.";
      });
    }
  }

  void _showDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            contentPadding: EdgeInsets.zero,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            content: Container(
              height: 240,
              width: 420,
              alignment: Alignment.center,
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(''),
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.cancel_outlined,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                Text(
                  'Please Enter Your OTP',
                  style: TextStyle(fontSize: 18, color: Color(0xffD4000A)),
                ),
                SizedBox(
                  height: 10,
                ),
                Text('OTP has been sent to ' + phoneController.text),
                Text('please wait 30 seconds'),
                SizedBox(
                  height: 8,
                ),
                CustomLoginInput(
                  errorText: otpError,
                  controller: otpController,
                  text: 'Enter OTP here',
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                  width: 120,
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 255, 60, 0),
                      borderRadius: BorderRadius.circular(25)),
                  height: 40,
                  child: TextButton(
                    onPressed: () {
                      int convertedOtp = int.parse(otpController.text);
                      print(otp.runtimeType);
                      print(convertedOtp.runtimeType);
                      print(otp);
                      print(convertedOtp);
                      if (otp == convertedOtp) {
                        UserStatus().setLoggedIn(true);
                        UserStatus().setPhoneNumber(
                            phoneController.text); // ✅ Store phone number

                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => Home()));
                      } else {
                        setState(() {
                          otpError = 'Otp does not match!';
                        });
                      }
                    },
                    child: Text(
                      'SUBMIT',
                      style: TextStyle(color: Colors.white70),
                    ),
                  ),
                )
              ]),
            ),
          );
        });
  }

  @override
  void dispose() {
    // TODO: implement dispose

    phoneController.dispose();
    otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(top: h * 0.15, bottom: h * 0.20),
            child: Form(
              key: _key,
              child: Column(
                children: [
                  Container(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.12,
                          right: MediaQuery.of(context).size.width * 0.12),
                      child: Image.asset('assets/loginlogo.png')),
                  Padding(
                    padding: const EdgeInsets.only(left: 32.0, right: 32.0),
                    child: Container(
                      height: 225,
                      width: MediaQuery.of(context).size.width,
                      child: Card(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        elevation: 4,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10.0, bottom: 15),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("Login",
                                    style: TextStyle(
                                        color: Color(0xffD4000A),
                                        fontSize: 25,
                                        fontWeight: FontWeight.w400)),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 30.0, right: 30),
                                  child: Container(
                                    height: 60,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(28),
                                        border: Border.all(
                                            color: const Color(0xffD4000A),
                                            width: 1)),
                                    child: Padding(
                                      padding:
                                          EdgeInsets.only(top: 14.0, left: 16),
                                      child: TextFormField(
                                        validator: (val) {
                                          if (val == null || val.isEmpty) {
                                            return "Please enter number";
                                          } else if (!RegExp(
                                                  r'^\s*(?:\+?(\d{1,3}))?[-. (]*(\d{3})[-. )]*(\d{3})[-. ]*(\d{4})(?: *x(\d+))?\s*$')
                                              .hasMatch(val)) {
                                            return "Please Enter a Valid Phone Number";
                                          } else
                                            return null;
                                        },
                                        style:
                                            TextStyle(color: Color(0xffD4000A)),
                                        controller: phoneController,
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                            errorText: _response,
                                            border: InputBorder.none,
                                            hintText: 'Enter Phone Number',
                                            hintStyle: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 16)),
                                      ),
                                    ),
                                  ),
                                ),
                                // started from here ... wrote changes

                                Container(
                                  width: 120,
                                  decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 255, 60, 0),
                                      borderRadius: BorderRadius.circular(25)),
                                  height: 40,
                                  child: TextButton(
                                    onPressed: () {
                                      if (_key.currentState!.validate()) {
                                        _sendOtp(phoneController.text);

                                        if (isLoading == true) {
                                          showDialog(
                                              context: context,
                                              builder: (context) => AlertDialog(
                                                    contentPadding:
                                                        EdgeInsets.zero,
                                                    content: Container(
                                                        height: 70,
                                                        width: w,
                                                        child: Row(
                                                          children: [
                                                            SizedBox(
                                                                height: 30,
                                                                width: 30,
                                                                child:
                                                                    CircularProgressIndicator(
                                                                  color: Color(
                                                                      0xffD4000A),
                                                                )),
                                                            SizedBox(width: 15),
                                                            Text(
                                                                'Please Wait....'),
                                                          ],
                                                        )),
                                                  ));
                                        }
                                      }
                                    },
                                    child: Text(
                                      'Send OTP',
                                      style: TextStyle(
                                          color: Colors.grey.shade300),
                                    ),
                                  ),
                                ),
                              ]),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
