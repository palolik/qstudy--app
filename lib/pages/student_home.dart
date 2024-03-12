import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_app/auth/auth_page.dart';
import 'package:mobile_app/auth/authmain.dart';
import 'package:mobile_app/pages/chat/screens/chat_screen.dart';
import 'package:mobile_app/pages/eventcal.dart';
import 'package:mobile_app/pages/student_registration.dart';
import '/auth/login_page.dart';
import 'chat/chatbox.dart';
import 'checkvisabox.dart';
import 'faq.dart';
import 'notifications.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'Deperturedate.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser!;

  void signUserOut() {
    FirebaseAuth.instance.signOut();
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MainPage()));
  }

  @override
  Widget build(BuildContext context)


  {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 100,
        toolbarHeight: 80,
        backgroundColor: Color.fromARGB(255, 0, 25, 37),
        leading: Image.asset(
          "assets/images/qsw.png",

          color: Color.fromARGB(255, 255, 255, 255),
        ),

        actions: [
          Container(
            margin: EdgeInsets.only(right:20),
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 35, 173, 4),
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            child: TextButton(
                style: TextButton.styleFrom(
                    fixedSize: const Size(120, 40)),
                onPressed:  () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ChatScreen()));
                },
                child: const Text(
                  "Consultancy",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                  ),
                )),
          ),
        ],
      ),
      body: Container(
        alignment: AlignmentDirectional.center,
        decoration: const BoxDecoration(

          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            stops: [0.5, 0.9],
            colors: [
              Color.fromARGB(255, 1, 62, 91),
              Color.fromARGB(255, 0, 25, 37)
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height:10),
             Container(
                    height: 90.0,
                    margin: EdgeInsets.only(left:10,right:10,bottom:5),


               decoration: const BoxDecoration(
                 borderRadius: BorderRadius.all(Radius.circular(10)),

                 gradient: LinearGradient(
                   begin: Alignment.topRight,
                   end: Alignment.bottomLeft,
                   stops: [0.5, 0.9],
                   colors: [
                     Color.fromARGB(255, 0, 25, 37),
                     Color.fromARGB(255, 0, 49, 72)

                   ],
                 ),
               ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(width:10),
                        // ClipRRect(
                        //     borderRadius: BorderRadius.circular(10.0),
                        //     child: Image.asset(
                        //       "assets/intro/intropic.png",
                        //       height: 70,
                        //       width: 70,
                        //     )),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Azizul Alam',
                              style: TextStyle(fontSize: 20, color: Colors.white,),
                            ),
                            Container(
                              height: 35,
                              padding: EdgeInsets.all(0),
                              decoration: const BoxDecoration(
                                color: Color.fromARGB(0, 35, 173, 4),
                                borderRadius: BorderRadius.all(Radius.circular(2)),
                              ),
                              child: TextButton(

                                  onPressed:  () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => RegisterStudent()));
                                  },
                                  child: const Text(
                                    "Complete profile",
                                    style: TextStyle(

                                      fontSize: 12,
                                      color: Colors.white,
                                    ),
                                  )),
                            ),
                          ],
                        ),
                      ],
                    ),
             ),
             SizedBox(height:10),
             Expanded(
              child: ListView(
                // This next line does the trick.
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CheckVisaBox()));
                    },
                    child: Container(
                      margin: EdgeInsets.only(left:10,right:10,bottom:5),
                      padding: EdgeInsets.only(left: 20),
                      height: 120,
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 255, 216, 0),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                          topLeft: Radius.circular(0),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'Check VISA Status',
                            style: TextStyle(
                              fontSize: 25,
                            ),
                          ),
                          ClipRRect(
                            child: Image.asset(
                              "assets/images/visa.png",
                              height: 80,
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EventCal()));
                    },
                    child: Container(
                      padding: EdgeInsets.only(left: 20),
                      margin: EdgeInsets.only(left:10,right:10,bottom:5),
                      height: 120,
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 255, 216, 0),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                          topLeft: Radius.circular(0),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: 250,
                            child: Text(
                              'Upcoming Events',
                              style: TextStyle(
                                fontSize: 25,
                              ),
                            ),
                          ),
                          ClipRRect(
                            child: Image.asset(
                              "assets/images/event.png",
                              height: 80,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FlightCal()));
                    },
                    child: Container(
                      padding:EdgeInsets.only(left: 20),
                      margin: EdgeInsets.only(left:10,right:10,bottom:5),
                      height: 120,
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 255, 216, 0),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                          topLeft: Radius.circular(0),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: 250,
                            child: Text(
                              'Select Deperture date',
                              style: TextStyle(
                                fontSize: 25,
                              ),
                            ),
                          ),
                          ClipRRect(
                            child: Image.asset(
                              "assets/images/plane.png",
                              height: 80,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 60,
        color: Color.fromARGB(255, 0, 0, 0),
        padding: EdgeInsets.only(top:2),
        child: Container(
          color: Color.fromARGB(255, 0, 25, 37),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [

              IconButton(
                icon: Icon(Icons.home_outlined,color: Color.fromARGB(255, 255, 216, 0),), // Replace with your desired icon
                onPressed: () {

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HomePage()));

                },

                iconSize: 36.0, // Optional icon size
              ),
              IconButton(
                icon: Icon(Icons.question_mark_rounded,color: Color.fromARGB(255, 255, 216, 0),), // Replace with your desired icon
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => FaqS()));
                },
                iconSize: 36.0, // Optional icon size
              ),
              IconButton(
                icon: Icon(Icons.notification_important_outlined,
                  color: Color.fromARGB(255, 255, 216, 0),), // Replace with your desired icon
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => NotiFications()));
                },
                iconSize: 36.0, // Optional icon size
              ),
              IconButton(
                icon: Icon(Icons.exit_to_app_rounded
                  ,color: Color.fromARGB(255, 255, 216, 0),), // Replace with your desired icon
                onPressed: signUserOut,
                iconSize: 36.0, // Optional icon size
              ),

            ],
          ),
        ),
      ),
    );
  }
}
