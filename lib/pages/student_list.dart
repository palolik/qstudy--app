import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../auth/authmain.dart';
import 'adminhome.dart';
import 'faq2.dart';
import 'package:accordion/accordion.dart';

import 'notifications.dart';

class StudentList extends StatefulWidget {
  const StudentList({super.key});

  @override
  State<StudentList> createState() => _StudentListState();
}

class _StudentListState extends State<StudentList> {
  final Stream<QuerySnapshot> scheduleStream =
      FirebaseFirestore.instance.collection('students').snapshots();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: scheduleStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            print('Something went Wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          final List storedocs = [];
          snapshot.data!.docs.map((DocumentSnapshot document) {
            Map a = document.data() as Map<String, dynamic>;
            storedocs.add(a);
            a['id'] = document.id;
          }).toList();
          return Scaffold(
            appBar: AppBar(
              leadingWidth: 100,
              toolbarHeight: 100,
              backgroundColor: Color.fromARGB(255, 0, 25, 37),
              leading: Image.asset(
                "assets/images/qsw.png",
                color: Color.fromARGB(255, 255, 255, 255),
              ),
              // centerTitle: false, // Ensure title is left-aligned if present
            ),
            bottomNavigationBar: BottomAppBar(
              height: 60,
              padding: EdgeInsets.all(1),
              child: Container(
                color: Color.fromARGB(255, 35, 173, 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.home_outlined,
                        color: Color.fromARGB(255, 255, 216, 0),
                      ),
                      // Replace with your desired icon
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Ahome()));
                      },

                      iconSize: 36.0, // Optional icon size
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.question_mark_rounded,
                        color: Color.fromARGB(255, 255, 216, 0),
                      ),
                      // Replace with your desired icon
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    FaqS2())); // Handle button press here
                      },

                      iconSize: 36.0, // Optional icon size
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.notification_important_outlined,
                        color: Color.fromARGB(255, 255, 216, 0),
                      ),
                      // Replace with your desired icon
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NotiFications()));
                      },
                      iconSize: 36.0, // Optional icon size
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.exit_to_app_rounded,
                        color: Color.fromARGB(255, 255, 216, 0),
                      ),
                      // Replace with your desired icon
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MainPage()));
                      },
                      iconSize: 36.0, // Optional icon size
                    ),
                  ],
                ),
              ),
            ),
            body: Container(
              height: double.infinity,
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
              child: Accordion(
                headerBorderColorOpened: Colors.transparent,
                headerBackgroundColorOpened: Colors.yellow,
                contentBackgroundColor: Colors.white,
                contentBorderColor: Colors.yellow,
                contentBorderWidth: 1,
                contentHorizontalPadding: 10,
                scaleWhenAnimating: true,
                openAndCloseAnimation: true,
                headerPadding:
                    const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
                // sectionOpeningHapticFeedback: SectionHapticFeedback.heavy,
                // sectionClosingHapticFeedback: SectionHapticFeedback.light,
                children: [
                  for (var i = 0; i < storedocs.length; i++) ...[
                    AccordionSection(
                      isOpen: true,
                      contentVerticalPadding: 20,
                      leftIcon: const Icon(Icons.account_circle_outlined,
                          color: Colors.tealAccent),
                      headerBackgroundColor: Colors.black38,
                      headerBackgroundColorOpened: Colors.black54,
                      header: Row(
                        children: [
                          Text(
                            storedocs[i]['firstname'],
                            style: TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255)),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            storedocs[i]['lastname'],
                            style: TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255)),
                          ),
                        ],
                      ),
                      content: Column(
                        children: [
                          Row(
                            children: [
                              Text('Email:'),
                              SizedBox(
                                width: 5,
                              ),
                              Text(storedocs[i]['email']),
                            ],
                          ),
                          Row(
                            children: [
                              Text('Nationality:'),
                              SizedBox(
                                width: 5,
                              ),
                              Text(storedocs[i]['nationality']),
                            ],
                          ),
                          Row(
                            children: [
                              Text('Phone:'),
                              SizedBox(
                                width: 5,
                              ),
                              Text(storedocs[i]['phone']),
                            ],
                          ),
                          Row(
                            children: [
                              Text('Date of Birth:'),
                              SizedBox(
                                width: 5,
                              ),
                              Text(storedocs[i]['phone']),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
          );
        });
  }
}
