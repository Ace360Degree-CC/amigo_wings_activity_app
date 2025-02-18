import 'package:amigo_academy/api_services/api_service.dart';
import 'package:amigo_academy/model/user_model.dart';
import 'package:amigo_academy/screens/lead.dart';
import 'package:amigo_academy/screens/login.dart';
import 'package:amigo_academy/screens/profile.dart';
import 'package:amigo_academy/shared_preferences/user_status.dart';

import 'package:flutter/material.dart';

import 'add_student.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => HomeState();
}

class HomeState extends State<Home> {
  List<String> titles = ['Home', 'Profile', 'Add Lead'];
  List<IconData> icons = [Icons.home, Icons.person, Icons.add_box];
  late Future<Result> futureResults;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadUserPhoneNumber();

    // futureResults = ApiServices().fetchData(9004266110);
  }

  Future<void> _loadUserPhoneNumber() async {
    String? phone =
        await UserStatus().getPhoneNumber(); // ✅ Retrieve stored phone number
    if (phone != null) {
      setState(() {
        futureResults =
            ApiServices().fetchData(phone); // ✅ Use dynamic phone number
      });
    } else {
      print("No phone number found, redirecting to login...");
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Login()));
    }
  }

  int selected = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffD4000A),
        title: Text('Lead Achievements'),
      ),
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: Column(
          children: [
            Container(
              height: 150,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.grey.shade100, Colors.grey.shade500],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 70,
                    width: 140,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/logo.png'))),
                  ),
                  Text(
                    "Hii, " + ApiServices.name,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 19),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return ListTile(
                      tileColor:
                          index == 0 ? Colors.grey.shade400 : Colors.white,
                      onTap: () {
                        setState(() {
                          selected = index;
                        });
                        Navigator.pop(context);
                        if (index == 0) {
                          null;
                        }
                        index == 1
                            ? Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Profile()))
                            : null;

                        index == 2
                            ? Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AddStudent()))
                            : null;
                      },
                      leading: Icon(icons[index],
                          color: index == 0 ? Color(0xffD4000A) : Colors.black),
                      title: Text(
                        titles[index],
                        style: TextStyle(
                            color:
                                index == 0 ? Color(0xffD4000A) : Colors.black),
                      ),
                    );
                  }),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 18.0, bottom: 10),
              child: Align(
                alignment: Alignment.topLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Branch : Andheri",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Batch no: 13",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Roll no: 1",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ),
            const Text('\u00a9 Amigo Academy Pvt. Ltd '),
          ],
        ),
      ),
      body: FutureBuilder<Result>(
          future: futureResults,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              ApiServices.studentId = snapshot.data!.studentId;
              ApiServices.branch = snapshot.data!.branchId; // ✅ Use 'branchId'
              ApiServices.batchNo = snapshot.data!.batchNo;
              ApiServices.name = snapshot.data!.name;
              ApiServices.email = snapshot.data!.emailId; // ✅ Use 'emailId'
              ApiServices.rollNO = snapshot.data!.rollNo;
              ApiServices.course = snapshot.data!.course;
              ApiServices.MobileNo = snapshot.data!.mobileNo;
              ApiServices.profilePic =
                  snapshot.data!.profilePic; // ✅ Profile Picture
              print(snapshot.data!.studentId);

              return Lead();
            } else {
              return Center(
                child: CircularProgressIndicator(color: Color(0xffD4000A)),
              );
            }
          }),
    );
  }
}
