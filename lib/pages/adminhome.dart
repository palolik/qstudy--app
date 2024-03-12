import 'package:flutter/material.dart';
import 'package:mobile_app/auth/login_page.dart';
import 'package:mobile_app/pages/addfaq.dart';
import 'package:mobile_app/pages/eventcal.dart';
import 'package:mobile_app/pages/faq2.dart';
import 'package:mobile_app/pages/pickupreq.dart';

import '../auth/authmain.dart';
import 'add_event.dart';
import 'chat/chatbox.dart';
import 'notifications.dart';
import 'student_list.dart';
import 'utils.dart';

class Ahome extends StatefulWidget {
  const Ahome({super.key});

  @override
  State<Ahome> createState() => _AhomeState();
}

class _AhomeState extends State<Ahome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 100,
        toolbarHeight: 80,
        backgroundColor: Color.fromARGB(255, 0, 25, 37),
        leading: Image.asset(
          "assets/images/qsw.png",
          color: Color.fromARGB(255, 255, 255, 255),
        ),

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
            // Container(
            //   margin: new EdgeInsets.only(top: 50.0, left: 10.0, right: 10.0),
            //   alignment: AlignmentDirectional.topStart,
            //   width: double.maxFinite,
            //   height: 100,
            //   decoration: const BoxDecoration(),
            //   child: Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //       children: [
            //         Image.asset(
            //           "assets/images/qsw.png",
            //           height: 80,
            //           width: 100,
            //         ),
            //       ]),
            // ),
            Container(
              height: 600,
              margin: EdgeInsets.all(10),
              child: ListView(
                // This next line does the trick.
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => StudentList()));
                    },
                    child: Container(

                      margin: EdgeInsets.only(bottom: 10),
                      padding: EdgeInsets.only(left: 20),
                      height: 80,
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 250,
                            child: Text(
                              'Student List',
                              style: TextStyle(
                                fontSize: 25,
                              ),
                            ),
                          ),
                          ClipRRect(
                            child: Image.asset(
                              "assets/images/slist.png",
                              height: 60,
                            ),
                          ),
                          SizedBox(width: 5,)
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      fetchEvents().then((fetchedEvents) {
                        // Use the fetchedEvents map here
                        print(fetchedEvents);
                      });
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => AddEventPage()));
                    },
                    child: Container(
                      padding: EdgeInsets.only(left: 20),
                      margin: EdgeInsets.only(bottom: 10),
                      height: 80,
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 250,
                            child: Text(
                              'Event Calender',
                              style: TextStyle(
                                fontSize: 25,
                              ),
                            ),
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(25.0),
                            child: Image.asset(
                              "assets/images/event.png",
                              height: 60,
                            ),
                          ),
                          SizedBox(width: 5,)
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => EventCal()));
                    },
                    child: Container(
                      padding: EdgeInsets.only(left: 20),
                      margin: EdgeInsets.only(bottom: 10),
                      height: 80,
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 250,
                            child: Text(
                              'Student Query',
                              style: TextStyle(
                                fontSize: 25,
                              ),
                            ),
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(25.0),
                            child: Image.asset(
                              "assets/images/que.png",
                              height: 60,
                            ),
                          ),
                          SizedBox(width: 5,)
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => AddFaq()));
                    },
                    child: Container(
                      padding: EdgeInsets.only(left: 20),
                      margin: EdgeInsets.only(bottom: 10),
                      height: 80,
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 250,
                            child: Text(
                              'Add FAQ',
                              style: TextStyle(
                                fontSize: 25,
                              ),
                            ),
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(25.0),
                            child: Image.asset(
                              "assets/images/addfaq.png",
                              height: 60,
                            ),
                          ),
                          SizedBox(width: 5,)
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => PickupReq()));
                    },
                    child: Container(
                      padding: EdgeInsets.only(left: 20),
                      height: 80,
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 250,
                            child: Text(
                              'Pick Up Requests',
                              style: TextStyle(
                                fontSize: 25,
                              ),
                            ),
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(25.0),
                            child: Image.asset(
                              "assets/images/pickup.png",
                              height: 60,
                            ),
                          ),
                          SizedBox(width: 5,)
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
                          builder: (context) => Ahome()));

                },

                iconSize: 36.0, // Optional icon size
              ),
              IconButton(
                icon: Icon(Icons.question_mark_rounded,color: Color.fromARGB(255, 255, 216, 0),), // Replace with your desired icon
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => FaqS2()));
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
                onPressed:() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const MainPage();
                      },
                    ),
                  );
                },
                iconSize: 36.0, // Optional icon size
              ),

            ],
          ),
        ),
      ),
    );
  }
}
