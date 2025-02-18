import 'package:amigo_academy/api_services/api_service.dart';
import 'package:amigo_academy/model/user_model.dart';
import 'package:flutter/material.dart';

import '../shared_preferences/user_status.dart';
import '../widgets/custom_container.dart';
import 'login.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool isLoading = true; // To show loading state
  String? phone; // ✅ Use dynamic phone number
  Result? userData; // Store user data

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  Future<void> loadUserData() async {
    String? storedPhone =
        await UserStatus().getPhoneNumber(); // ✅ Retrieve stored phone
    if (storedPhone != null) {
      setState(() {
        phone = storedPhone;
        loadUserData(); // ✅ Load user data using the fetched phone number
      });
    } else {
      print("No phone number found, redirecting to login...");
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Login()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Profile'),
          backgroundColor: Color(0xffD4000A),
          elevation: 0,
        ),
        body: isLoading
            ? Center(
                child:
                    CircularProgressIndicator()) // Show loader until data is loaded
            : SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(children: [
                  // Profile Header
                  Container(
                    height: MediaQuery.of(context).size.height * 0.25,
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(32),
                            bottomRight: Radius.circular(32)),
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color.fromRGBO(217, 217, 217, 1),
                              Color.fromRGBO(131, 130, 130, 1),
                            ])),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 90,
                          width: 90,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle, // Makes the image circular
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: ClipOval(
                            child: ApiServices.profilePic.isNotEmpty
                                ? Image.network(
                                    ApiServices
                                        .profilePic, // ✅ Load image from API
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Icon(Icons.person,
                                          size: 70,
                                          color: Colors
                                              .grey); // Placeholder on error
                                    },
                                  )
                                : Icon(Icons.person,
                                    size: 70,
                                    color: Colors
                                        .grey), // Default icon if no profile pic
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 30,
                          width: 90,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(18)),
                          child: Center(
                            child: Text(
                              ApiServices.name, // Display name dynamically
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),

                  // Profile Details
                  Container(
                    padding: const EdgeInsets.all(12),
                    child: Column(children: [
                      Container(
                        child: Column(
                          children: [
                            Container(
                              height: 120,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14)),
                              child: Card(
                                elevation: 8,
                                child: Column(children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 45.0, right: 58, top: 5),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          "Course Selected:",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xff6F6F6F)),
                                        ),
                                        Text(
                                          ApiServices.course,
                                          style: const TextStyle(
                                              color: Colors.black45),
                                        )
                                      ],
                                    ),
                                  ),
                                  const Divider(
                                    color: Colors.grey,
                                    indent: 4,
                                    endIndent: 4,
                                    thickness: 0.7,
                                  ),
                                  IntrinsicHeight(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            const Text(
                                              "Batch no:",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0xff6F6F6F)),
                                            ),
                                            Text(ApiServices.batchNo,
                                                style: const TextStyle(
                                                    color: Colors.black45))
                                          ],
                                        ),
                                        Container(
                                          height: 50,
                                          width: 1,
                                          color: Colors.grey,
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            const Text(
                                              "Roll no:",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0xff6F6F6F)),
                                            ),
                                            Text(ApiServices.rollNO,
                                                style: const TextStyle(
                                                    color: Colors.black45))
                                          ],
                                        ),
                                      ],
                                    ),
                                  )
                                ]),
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomContainer(
                        title: 'Mobile No:',
                        subtitle: ApiServices.MobileNo,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomContainer(
                        title: 'Email:',
                        subtitle: ApiServices.email,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomContainer(
                        title: 'Branch:',
                        subtitle: ApiServices.branch,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ]),
                  ),

                  Container(
                    height: 40,
                    width: 110,
                    child: ElevatedButton(
                      onPressed: () {
                        UserStatus().deleteLoggedIn('isLoggedIn');
                      },
                      child: const Text(
                        'Logout',
                        style: TextStyle(color: Colors.white70),
                      ),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xffD4000A)),
                    ),
                  ),
                ])));
  }
}
