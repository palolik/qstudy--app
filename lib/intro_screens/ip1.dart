import 'package:flutter/material.dart';

class IntroPage1 extends StatelessWidget {
  const IntroPage1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          stops: [0.5, 0.9],
          colors: [
            Color.fromARGB(255, 1, 62, 91),
            Color.fromARGB(255, 0, 25, 37),
          ],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
          Image.asset(
            "assets/images/qsw.png",
            height: 350,
            width: 0.7 * width,
          ),
         // SizedBox(height: 5),
          const Text("Welcome to Q Study",
              style: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                  fontWeight: FontWeight.bold)),
          const SizedBox(
            height: 20,
          ),
          const Text(
              "Your one-stop university replacement center",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              )),
        ],
      ),
    );
  }
}
