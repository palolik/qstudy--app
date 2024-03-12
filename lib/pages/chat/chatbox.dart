import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../auth/authmain.dart';
import '../adminhome.dart';
import '../faq.dart';
import '../notifications.dart';
import '../student_home.dart';

class ChatBox extends StatefulWidget {
  const ChatBox({super.key});

  @override
  State<ChatBox> createState() => _ChatBoxState();
}

class _ChatBoxState extends State<ChatBox> {
  var fquestion = "";
  final fquestionController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  DocumentReference faq = FirebaseFirestore.instance.collection('chatbox').doc('chat1');

  Future<void> addChat() {
    return faq
        .set({
      'fquestion': fquestion,
    })
        .then((value) => print('question Added'))
        .catchError((error) => print('Failed to Add question: $error'));
  }

  void signUserOut() {
    FirebaseAuth.instance.signOut();
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => MainPage()));
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

        // actions: [
        //   Container(
        //     margin: EdgeInsets.only(right:20),
        //     decoration: const BoxDecoration(
        //       color: Color.fromARGB(255, 35, 173, 4),
        //       borderRadius: BorderRadius.all(Radius.circular(5)),
        //     ),
        //     child: TextButton(
        //         style: TextButton.styleFrom(
        //             fixedSize: const Size(120, 40)),
        //         onPressed: (){},
        //         child: const Text(
        //           "Consultancy",
        //           style: TextStyle(
        //             fontSize: 15,
        //             color: Colors.white,
        //           ),
        //         )),
        //   ),
        // ],
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
                height: 600,
                alignment: Alignment.center,
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Color.fromARGB(0, 0, 25, 37),

                ),

              ),


              Form(
                  key: _formKey,
                  child:
              Container(
                child: Row(
                  children:[
                    Container(
                      width:350,
                     child: TextField(
                         controller: fquestionController,
                        style: TextStyle(color: Colors.white),
                        cursorColor: Colors.cyan,
                        decoration: InputDecoration(
                          labelStyle: TextStyle(
                              color: Colors.white), // Change label color

                          labelText: 'Enter the Question',
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 1.0),
                      child: GestureDetector(
                        onTap: () {
                          // Validate returns true if the form is valid, otherwise false.
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              fquestion = fquestionController.text;
                              // fanswer = fanswerController.text;
                              //
                              addChat();
                            });
                          }

                        },
                        child: Container(
                          padding: const EdgeInsets.all(10.0),

                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 35, 173, 4),
                          ),
                          child: const Center(
                            child: Text(
                              'Add ',
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
                  ]
                  ),
              )

              )

            ],
          ),
        ),
      ),
    );
  }
}
