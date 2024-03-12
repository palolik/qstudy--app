import 'package:flutter/material.dart';

class IntroPage2 extends StatelessWidget {
  const IntroPage2({Key? key}) : super(key: key);

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
            "assets/intro/world.png",
            height: 400,
            width: 0.9 * width,
          ),
          SizedBox(height: 25),
          const Text("Q Study World Network",
              style: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                  fontWeight: FontWeight.bold)),
          const SizedBox(
            height: 15,
          ),
          const Text(
"Q Study is currently working with 16 countries worldwide",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                color: Colors.amber,
                  fontWeight: FontWeight.bold
              )),
        ],
      ),
    );
  }
}
