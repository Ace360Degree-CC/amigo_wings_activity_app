import 'package:amigo_academy/api_services/api_service.dart';
import 'package:amigo_academy/main.dart';
import 'package:amigo_academy/model/user_model.dart';
import 'package:amigo_academy/screens/lead.dart';
import 'package:amigo_academy/screens/login.dart';
import 'package:amigo_academy/screens/profile.dart';
import 'package:amigo_academy/screens/uploadDataScreen.dart';
import 'package:amigo_academy/shared_preferences/user_status.dart';
import 'package:flutter/material.dart';
import 'add_student.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => HomeState();
}

class HomeState extends State<Home> {
  List<String> titles = ['Home', 'Profile', 'Add Lead', 'Upload Data'];
  List<IconData> icons = [Icons.home, Icons.person, Icons.add_box, Icons.cloud_upload];

  Future<Result>? futureResults;
  int selected = 0; // Track selected sidebar item

  @override
  void initState() {
    super.initState();
    _loadUserPhoneNumber();
  }

  /// ✅ Loads user phone number and fetches data
  Future<void> _loadUserPhoneNumber() async {
    String? phone = await UserStatus().getPhoneNumber();
    if (phone != null) {
      if (mounted) {
        setState(() {
          futureResults = ApiServices().fetchData(phone);
        });
      }
    } else {
      print("No phone number found, redirecting to login...");
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (navigatorKey.currentState != null) {
          navigatorKey.currentState!.pushReplacement(
            MaterialPageRoute(builder: (context) => const Login()),
          );
        }
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffD4000A),
        title: const Text('Lead Achievements'),
      ),
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: Column(
          children: [
            /// ✅ Drawer Header
            Container(
              height: 150,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.grey.shade100, Colors.grey.shade500],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 70,
                    width: 140,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/logo.png'),
                      ),
                    ),
                  ),
                  Text(
                    "Hii, ${ApiServices.name}",
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 19),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),

            /// ✅ Sidebar Navigation List
            Expanded(
              child: ListView.builder(
                itemCount: titles.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    tileColor:
                        selected == index ? Colors.grey.shade400 : Colors.white,
                    onTap: () {
                      Navigator.pop(context); // ✅ Ensure drawer closes

                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        // if (!mounted) return;

                        if (navigatorKey.currentState != null) {
                          switch (index) {
                            case 0:
                              navigatorKey.currentState!.push(
                                MaterialPageRoute(builder: (context) => const Home()),
                              );
                              break;
                            case 1:
                              navigatorKey.currentState!.push(
                                MaterialPageRoute(builder: (context) => const Profile()),
                              );
                              break;
                            case 2:
                              navigatorKey.currentState!.push(
                                MaterialPageRoute(builder: (context) => const AddStudent()),
                              );
                              break;
                            case 3:
                              navigatorKey.currentState!.push(
                                MaterialPageRoute(builder: (context) => const UploadDataScreen()),
                              );
                              break;
                          }
                        }
                      });
                    },






                    leading: Icon(
                      icons[index],
                      color: selected == index
                          ? const Color(0xffD4000A)
                          : Colors.black,
                    ),
                    title: Text(
                      titles[index],
                      style: TextStyle(
                        color: selected == index
                            ? const Color(0xffD4000A)
                            : Colors.black,
                      ),
                    ),
                  );
                },
              ),
            ),

            /// ✅ Footer Details
            Padding(
              padding: const EdgeInsets.only(left: 18.0, bottom: 10),
              child: Align(
                alignment: Alignment.topLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text("Branch : Andheri",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold)),
                    Text("Batch no: 13",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold)),
                    Text("Roll no: 1",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold))
                  ],
                ),
              ),
            ),
            const Text('\u00a9 Amigo Academy Pvt. Ltd'),
          ],
        ),
      ),

      /// ✅ FutureBuilder for API data
      body: FutureBuilder<Result>(
        future: futureResults,
        builder: (context, snapshot) {
          if (!mounted) return const SizedBox(); // ✅ Prevent UI updates after disposal

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: Color(0xffD4000A)));
          } else if (snapshot.hasError) {
            return const Center(child: Text("Error loading data"));
          } else if (!snapshot.hasData) {
            return const Center(child: Text("No data available"));
          } else {
            if (mounted) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (mounted) {
                  ApiServices.studentId = snapshot.data!.studentId;
                  ApiServices.branch = snapshot.data!.branchId;
                  ApiServices.batchNo = snapshot.data!.batchNo;
                  ApiServices.name = snapshot.data!.name;
                  ApiServices.email = snapshot.data!.emailId;
                  ApiServices.rollNO = snapshot.data!.rollNo;
                  ApiServices.course = snapshot.data!.course;
                  ApiServices.MobileNo = snapshot.data!.mobileNo;
                  ApiServices.profilePic = snapshot.data!.profilePic;
                  print("Student ID: ${snapshot.data!.studentId}");
                }
              });
            }

            return const Lead(); // ✅ Ensure navigation is stable
          }
        },
      ),

    );
  }
}
