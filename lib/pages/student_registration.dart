import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobile_app/pages/student_home.dart';


class RegisterStudent extends StatefulWidget {
  const RegisterStudent({super.key});

  @override
  State<RegisterStudent> createState() => _RegisterStudentState();
}
final _dateController = TextEditingController();



class _RegisterStudentState extends State<RegisterStudent> {
  final _formKey = GlobalKey<FormState>();

  var firstname = "";
  var lastname = "";
  var email = "";
  var phone = "";
  var dob ="";
  var nationality ="";

  final firstnameController = TextEditingController();
  final lastnameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final dobController = TextEditingController();
  final nationalityController = TextEditingController();
  Future<void> pickDate(BuildContext context) async {
    final initialDate = DateTime.now();
    final firstDate = DateTime(1900);
    final lastDate = DateTime.now();

    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );

    if (pickedDate != null) {
      dobController.text = DateFormat('yyyy-MM-dd').format(pickedDate); // Format as needed
    }
  }
  CollectionReference students =
  FirebaseFirestore.instance.collection('students');

  Future<void> addUser() {
    return students
        .add({'firstname': firstname,'lastname': lastname, 'email': email, 'phone': phone,'dob': dob , 'nationality': nationality})
        .then((value) => print('User Added'))
        .catchError((error) => print('Failed to Add user: $error'));
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
      body:  Form(
      key: _formKey,
        child: Container(
          decoration: const BoxDecoration(

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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
               padding: EdgeInsets.all(10),

               decoration:  BoxDecoration(
                 color: Color.fromARGB(255, 0, 25, 37),
                 borderRadius: BorderRadius.only(
                   bottomLeft: Radius.circular(40.0),
                   bottomRight: Radius.circular(40.0),
                   topLeft: Radius.zero,
                   topRight: Radius.zero,
                 ),

               ),
               child: Text("Register Account",style: TextStyle(
                 fontSize: 25,
                 color: Color.fromARGB(255, 255, 216, 0),
               ),),
              ),
              Container(
                margin: EdgeInsets.only(left: 20,right: 20),

                child: Column(

                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    TextFormField(

                      controller: firstnameController,
                      decoration: InputDecoration(labelText: 'First Name'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your first name';
                        }
                        return null;
                      },
                    ),

                SizedBox(
                  height: 10,
                ),
                TextFormField(
                 controller: lastnameController,
                  decoration: InputDecoration(labelText: 'Last Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your last name';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: dobController,
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: 'Birthdate',
                    suffixIcon: Icon(Icons.calendar_today),
                  ),
                  onTap: () => pickDate(context),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                   controller: emailController,
                  decoration: InputDecoration(labelText: 'Email'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Email';
                    } else if (!value.contains('@')) {
                      return 'Please Enter Valid Email';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                IntlPhoneField(
                  controller: phoneController,
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                  ),
                  languageCode: "en",
                  onChanged: (phone) {
                    // phoneController=phone.completeNumber;
                    // print(phone.completeNumber);
                  },
                  onCountryChanged: (country) {
                    print('Country changed to: ' + country.name);
                  },
                ),
                SizedBox(
                  height: 10,
                ),

                TextFormField(
                  // name , dob , nationality ,email ,phone number..
                  controller: nationalityController,
                  decoration: InputDecoration(labelText: 'Nationality'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your Nationality';
                    }
                    return null;
                  },
                ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                          width: 400,
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 1, 62, 91),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: TextButton(
                          style: TextButton.styleFrom(
                              fixedSize: const Size(120, 40)),
                           onPressed: (){
                             // Validate returns true if the form is valid, otherwise false.
                             if (_formKey.currentState!.validate()) {
                               setState(() {
                                 firstname = firstnameController.text;
                                 lastname = lastnameController.text;
                                 dob = dobController.text;
                                 nationality = nationalityController.text;
                                 email = emailController.text;
                                 phone = phoneController.text;
                                 addUser();
                               });
                             }
                             Navigator.push(
                                 context,
                                 MaterialPageRoute(
                                     builder: (context) => HomePage()));
                           },
                          child: const Text(
                            "Register Now",
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                            ),
                          )),
                    ),
                  ],
                ),
              ),
              ],
          ),
        ),

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
                icon: Icon(Icons.home,color: Color.fromARGB(255, 255, 216, 0),), // Replace with your desired icon
                onPressed: () {
                  // Handle button press here
                },

                iconSize: 36.0, // Optional icon size
              ),
              IconButton(
                icon: Icon(Icons.notification_important_outlined,
                  color: Color.fromARGB(255, 255, 216, 0),), // Replace with your desired icon
                onPressed: () {
                  // Handle button press here
                },
                iconSize: 36.0, // Optional icon size
              ),
              IconButton(
                icon: Icon(Icons.exit_to_app_sharp
                  ,color: Color.fromARGB(255, 255, 216, 0),), // Replace with your desired icon
                onPressed: () {
                  // Handle button press here
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
