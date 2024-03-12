import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// import 'package:crud/pages/update_student_page.dart';
import 'package:intl/intl.dart';


class PickupList extends StatefulWidget {
  PickupList({Key? key}) : super(key: key);

  @override
  _PickupListState createState() => _PickupListState();
}

class _PickupListState extends State<PickupList> {
  final Stream<QuerySnapshot> scheduleStream =
  FirebaseFirestore.instance.collection('pickupdates').snapshots();


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
                          Text(storedocs[i]['airport'],
                              style: TextStyle(fontSize: 18.0,color: Colors.white)),
                          Text(storedocs[i]['landingtime'],
                              style: TextStyle(fontSize: 18.0,color: Colors.white)),
                          Text(
                            DateFormat('EEE, d.M.y').format(storedocs[i]['dop'].toDate()), // Format selectedDate
                            style: TextStyle(fontSize: 18.0,color: Colors.white),
                          ),
                          // Text(
                          //   DateFormat('dd/MM/yyyy').format(storedocs[i]['settingDate'].toDate()), // Format settingDate
                          //   style: TextStyle(fontSize: 18.0),),
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
