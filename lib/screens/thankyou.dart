import 'package:amigo_academy/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ThankYouScreen extends StatefulWidget {
  const ThankYouScreen({super.key});

  @override
  State<ThankYouScreen> createState() => _ThankYouScreenState();
}

class _ThankYouScreenState extends State<ThankYouScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xffD4000A),
        leading: IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Home()));
            },
            icon: const Icon(Icons.menu)),
        elevation: 0,
        title: const Text('Amigo Academy wings'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(children: [
          const SizedBox(height: 10),
          const Text(
            'THANK YOU!',
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 30,
                letterSpacing: 2),
          ),
          const SizedBox(height: 15),
          const Text(
            "AMIGO ACADEMY",
            style: TextStyle(
                color: Color(0xffD4000A),
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
          Container(
            padding: const EdgeInsets.only(left: 14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                    'India’s No.1 Air Hostess and Hospitality Training Insitute'),
              ],
            ),
          ),
          const SizedBox(height: 7),
          Container(
            height: 40,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.only(left: 14, top: 12),
            color: const Color(0xffD4000A),
            child: const Text(
              'WISHES YOU GOOD LUCK WITH YOUR EXAMS',
              style: TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          const Text(
            'Your Free of Charge Career Pass',
            style: TextStyle(
                color: Color(0xffD4000A), fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 22,
          ),
          Container(
              padding: const EdgeInsets.only(left: 14, right: 8),
              child: Column(children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 47,
                  child: const Text(
                    'AMIGO ACADEMY is a highly sought-after institute for air hostess training. Our success can be attributed to the fact that we deliver customized training to meet the unique needs of every student.',
                    style: TextStyle(fontSize: 12.5),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 61,
                  child: const Text(
                    'Amigo Academy provides training for Aviation, hospitality, travel, and customer service through highly qualified professionals with long-standin  experience in the airline, hospitality, and customer service industries.',
                    style: TextStyle(fontSize: 12.5),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 48,
                  child: const Text(
                    'Our Alumni work with reputable brands like Indigo, Air India, Akasa Air, Adani International Airport, BWFS, MSC Europa Cruise, Qatar International Airport, and many others.',
                    style: TextStyle(fontSize: 12.5),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 80,
                  child: const Text(
                    'Known for providing top-notch training, some of the outstanding awards that we have received are the National Pride and Excellence Award and the "Dr. APJ Abdul Kalam Memorial Excellence Award" for outstanding achievement & distinguished service.',
                    style: TextStyle(fontSize: 12.5),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Benefits of Becoming a Flight Attendant : ",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 14),
                  ),
                ),
              ])),
          Container(
            padding: const EdgeInsets.only(left: 23),
            child: Column(
              children: [
                Row(
                  children: [
                    const Text(
                      '•',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                    const Text('  High paid salary.')
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      '•',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                    const Text(' Stay at luxurious 5-star hotels worldwide.',
                        style: TextStyle(fontSize: 13))
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      '•',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                    const Text(' Traveling across the globe for free.',
                        style: TextStyle(fontSize: 13))
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      '•',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                    const Text(
                      ' Free or Discounted flight tickets for your family and friends.',
                      style: TextStyle(fontSize: 13),
                    )
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                width: 85,
                height: 65,
                child: Image.asset(
                  'assets/s1.png',
                  fit: BoxFit.fill,
                ),
              ),
              Container(
                width: 80,
                height: 60,
                child: Image.asset(
                  'assets/s3.png',
                  fit: BoxFit.fill,
                ),
              ),
              Container(
                width: 85,
                height: 65,
                child: Image.asset(
                  'assets/s4.png',
                  fit: BoxFit.fill,
                ),
              ),
              Container(
                width: 85,
                height: 65,
                child: Image.asset(
                  'assets/s2.png',
                  fit: BoxFit.fill,
                ),
              ),
            ],
          )
        ]),
      ),
    );
  }
}
