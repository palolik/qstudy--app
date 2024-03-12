import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/pages/student_home.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../auth/authmain.dart';
import 'faq.dart';
import 'notifications.dart';
import 'utils.dart';
import 'package:intl/intl.dart';

class FlightCal extends StatefulWidget {
  @override
  _FlightCalState createState() => _FlightCalState();
}

class _FlightCalState extends State<FlightCal> {
  final _formKey = GlobalKey<FormState>();

  var name = "";
  var landingtime = "";
  var airport = "";
  var dop = "";
  final nameController = TextEditingController();
  final landingtimeController = TextEditingController();
  final airportController = TextEditingController();
  final dopController = TextEditingController();

  Future<void> pickDate(BuildContext context) async {
    final initialDate = DateTime.now();
    final firstDate = DateTime(2023);
    final lastDate = DateTime(2030);

    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );

    if (pickedDate != null) {
      dopController.text =
          DateFormat('yyyy-MM-dd').format(pickedDate); // Format as needed
    }
  }

  void signUserOut() {
    FirebaseAuth.instance.signOut();
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => MainPage()));
  }

  clearText() {
    nameController.clear();
    landingtimeController.clear();
    airportController.clear();
    dopController.clear();
  }

  CollectionReference pickups =
      FirebaseFirestore.instance.collection('pickupdates');

  Future<void> addPickUp() {
    final Timestamp dopTimestamp =
        Timestamp.fromDate(DateFormat('yyyy-MM-dd').parse(dopController.text));

    return pickups
        .add({
          'name': name,
          'landingtime': landingtime,
          'airport': airport,
          'dop': dopTimestamp, // Set the dop as a Timestamp
        })
        .then((value) => print('Pickup Added'))
        .catchError((error) => print('Failed to Add pickup: $error'));
  }

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
        // centerTitle: false, // Ensure title is left-aligned if present
      ),
      bottomNavigationBar: BottomAppBar(
        height: 60,
        color: Color.fromARGB(255, 0, 0, 0),
        padding: EdgeInsets.only(top: 2),
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
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomePage()));
                },

                iconSize: 36.0, // Optional icon size
              ),
              IconButton(
                icon: Icon(
                  Icons.question_mark_rounded,
                  color: Color.fromARGB(255, 255, 216, 0),
                ), // Replace with your desired icon
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => FaqS()));
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
                      MaterialPageRoute(builder: (context) => NotiFications()));
                },
                iconSize: 36.0, // Optional icon size
              ),
              IconButton(
                icon: Icon(
                  Icons.exit_to_app_sharp,
                  color: Color.fromARGB(255, 255, 216, 0),
                ), // Replace with your desired icon
                onPressed: signUserOut,
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
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 0, 25, 37),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20.0),
                    bottomRight: Radius.circular(20.0),
                    topLeft: Radius.zero,
                    topRight: Radius.zero,
                  ),
                ),
                child: Text(
                  "Airport Pickup",
                  style: TextStyle(
                    fontSize: 20,
                    color: Color.fromARGB(255, 255, 216, 0),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TextFormField(
                        controller: nameController,
                        style: TextStyle(color: Colors.white),
                        cursorColor: Colors.cyan,
                        decoration: InputDecoration(
                          labelStyle: TextStyle(
                              color: Colors.white), // Change label color

                          labelText: 'Enter the Name',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20), // Add spacing between fields
                      TextFormField(
                        controller: dopController,
                        readOnly: true,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          labelStyle: TextStyle(color: Colors.white),
                          labelText: 'Set pickup Date',
                          suffixIcon: Icon(
                            Icons.calendar_today,
                            color: Colors.white,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter date';
                          }
                          return null;
                        },
                        onTap: () => pickDate(context),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: landingtimeController,
                        style: TextStyle(color: Colors.white),
                        cursorColor: Colors.cyan,
                        decoration: InputDecoration(
                          labelStyle: TextStyle(
                              color: Colors.white), // Change label color

                          labelText: 'Enter Flight Landing Time',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter landing time';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: airportController,
                        style: TextStyle(color: Colors.white),
                        cursorColor: Colors.cyan,
                        decoration: InputDecoration(
                          labelStyle: TextStyle(
                              color: Colors.white), // Change label color

                          labelText: 'Airport Location',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter airport name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20), // Add spacing between fields
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: GestureDetector(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) {


                           return AlertDialog(
                                    backgroundColor:
                                        Color.fromARGB(255, 0, 0, 0),
                                    scrollable: true,
                                    content: Column(
                                      children: [
                                        Text(
                                          "Pickup request has been sent",
                                          style: TextStyle(
                                              fontSize: 20.0,
                                              color: Colors.white),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        ElevatedButton(
                                            onPressed: () {
                                              // Validate returns true if the form is valid, otherwise false.

                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          HomePage()));
                                            },
                                            child: Text("Back to home"))
                                      ],
                                    ),
                                  );
                                });

                            // Validate returns true if the form is valid, otherwise false.
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                dop = dopController.text;
                                name = nameController.text;
                                landingtime = landingtimeController.text;
                                airport = airportController.text;
                                addPickUp();
                                clearText();
                              });
                            }
                            // Navigator.push(context,
                            //     MaterialPageRoute(builder: (context) => Ahome()));
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 35, 173, 4),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Center(
                              child: Text(
                                'Set Pickup Request',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
