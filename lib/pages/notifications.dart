import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/pages/student_home.dart';

import '../auth/authmain.dart';
import 'faq.dart';

class NotiFications extends StatefulWidget {
  const NotiFications({super.key});

  @override
  State<NotiFications> createState() => _NotiFicationsState();
}

class _NotiFicationsState extends State<NotiFications> {
  void signUserOut() {
    FirebaseAuth.instance.signOut();
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MainPage()));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leadingWidth: 100,
          toolbarHeight: 100,
          backgroundColor: Color.fromARGB(255, 0, 25, 37),
          leading: Image.asset(
            "assets/images/qsw.png",
            color: Color.fromARGB(255, 255, 255, 255),
          ),
          actions: [
            Container(
              margin: EdgeInsets.only(right: 20),
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 35, 173, 4),
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
              child: TextButton(
                  style:
                  TextButton.styleFrom(fixedSize: const Size(120, 40)),
                  onPressed: () {},
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
                            builder: (context) => HomePage()));
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
                        context,
                        MaterialPageRoute(
                            builder: (context) => FaqS()));
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
        child: ListView(
          children: [

          ],
        ),
      )
      // bottomNavigationBar: ,
    );
  }
}
