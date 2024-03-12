import 'package:flutter/material.dart';
import 'package:mobile_app/pages/adminhome.dart';
import 'package:mobile_app/pages/student_home.dart';
import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FaqS2 extends StatefulWidget {
  const FaqS2({super.key});

  @override
  State<FaqS2> createState() => _FaqS2State();
}

class _FaqS2State extends State<FaqS2> {
  final Stream<QuerySnapshot> scheduleStream =
  FirebaseFirestore.instance.collection('faq').snapshots();
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
            backgroundColor: Color.fromARGB(255, 1, 62, 91),

            appBar: AppBar(
              leadingWidth: 100,
              toolbarHeight: 80,
              backgroundColor: Color.fromARGB(255, 0, 25, 37),
              leading: Image.asset(
                "assets/images/qsw.png",
                color: Color.fromARGB(255, 255, 255, 255),
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
                      icon: Icon(
                        Icons.home_outlined,
                        color: Color.fromARGB(255, 255, 216, 0),
                      ), // Replace with your desired icon
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Ahome()));
                      },

                      iconSize: 36.0, // Optional icon size
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.question_mark_rounded,
                        color: Color.fromARGB(255, 255, 216, 0),),

                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FaqS2()));
                      },

                      iconSize: 36.0, // Optional icon size
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.notification_important_outlined,
                        color: Color.fromARGB(255, 255, 216, 0),
                      ), // Replace with your desired icon
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => FaqS2()));
                      },
                      iconSize: 36.0, // Optional icon size
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.exit_to_app_sharp,
                        color: Color.fromARGB(255, 255, 216, 0),
                      ), // Replace with your desired icon
                      onPressed: () {
                        // Handle button press here
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
                sectionOpeningHapticFeedback: SectionHapticFeedback.heavy,
                sectionClosingHapticFeedback: SectionHapticFeedback.light,
                children: [
                  for (var i = 0; i < storedocs.length; i++) ...[
                    AccordionSection(
                      isOpen: true,
                      contentVerticalPadding: 20,
                      leftIcon: const Icon(Icons.text_fields_rounded,
                          color: Colors.tealAccent),
                      headerBackgroundColor: Colors.black38,

                      headerBackgroundColorOpened: Colors.black54,
                      header: Text(storedocs[i]['fquestion'],style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),),
                      content: Text(storedocs[i]['fanswer']),
                    ),
                  ],
                ],
              ),
            ),
            // bottomNavigationBar: ,
          );
        });
  }
}
