import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// import 'package:crud/pages/update_student_page.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';


class EventlistStudents extends StatefulWidget {
  EventlistStudents({Key? key}) : super(key: key);

  @override

  _EventlistStudentsState createState() => _EventlistStudentsState();
}
Future<void>? _launched;

Future<void> _launchInBrowser(Uri url) async {
  if (!await launchUrl(
    url,
    mode: LaunchMode.externalApplication,
  )) {
    throw Exception('Could not launch $url');
  }
}
class _EventlistStudentsState extends State<EventlistStudents> {
  final Stream<QuerySnapshot> scheduleStream =
  FirebaseFirestore.instance.collection('eventschedule').snapshots();


  @override

  Widget build(BuildContext context) {
    final Uri toLaunch =Uri(scheme: 'https', host: 'app.samscrm.co.uk', path: 's/b7RpeVZ38q3dfr0RvxJoaWEQ9');

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

          return Container(

            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  for (var i = 0; i < storedocs.length; i++) ...[
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.0),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Color.fromARGB(65, 0, 106, 161)),
                      child: Column(
                        children: [
                          Text(storedocs[i]['name'],
                              style: TextStyle(fontSize: 18.0,color: Colors.yellow)),
                          Text(storedocs[i]['vanue'],
                              style: TextStyle(fontSize: 18.0,color: Colors.white)),
                          Text(
                            DateFormat('EEE, d.M.y').format(storedocs[i]['selectedDate'].toDate()), // Format selectedDate
                            style: TextStyle(fontSize: 18.0,color: Colors.white),
                          ),
                          // Text(
                          //   DateFormat('dd/MM/yyyy').format(storedocs[i]['settingDate'].toDate()), // Format settingDate
                          //   style: TextStyle(fontSize: 18.0),),
                          GestureDetector(
                            onTap: () => setState(() {
                              _launched = _launchInBrowser(toLaunch);
                            }),
                            child: Container(

                              padding: EdgeInsets.all(5),
                              margin: EdgeInsets.all(5),
                              height: 30,
                              decoration: const BoxDecoration(
                                color: Color.fromARGB(160, 0, 49, 72),

                              ),
                              child:
                                  Text(
                                    'Sign up on this',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                    ),
                                  ),


                              ),
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
