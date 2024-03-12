import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '/intro_screens/ip1.dart';
import '/intro_screens/ip2.dart';
import '/intro_screens/ip3.dart';
import '/auth/authmain.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();

  bool onLastScreen = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
              controller: _controller,
              onPageChanged: (index) {
                setState(() {
                  onLastScreen = (index == 2);
                });
              },
              children: const [
                IntroPage1(),
                IntroPage2(),
                IntroPage3(),
              ]),
          //dot inndicator
          Container(
            alignment: const Alignment(0.5, 0.85),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //skip
                GestureDetector(
                  onTap: () {
                    _controller.jumpToPage(2);
                  },
                  child: const Text(
                    'Skip',
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.amber,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Raleway',
                    ),
                  ),
                ),
                SmoothPageIndicator(
                  controller: _controller,
                  count: 3,
                  axisDirection: Axis.horizontal,
                  effect: const SlideEffect(
                      spacing: 8.0,
                      radius: 4.0,
                      dotWidth: 22.0,
                      dotHeight: 14.0,
                      paintStyle: PaintingStyle.stroke,
                      strokeWidth: 1.5,
                      dotColor: Color.fromARGB(255, 255, 156, 156),
                      activeDotColor: Colors.amber),
                ),
                //next
                onLastScreen
                    ? GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return const MainPage();
                              },
                            ),
                          );
                        },
                        child: const Text(
                          'END',
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.amber,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Raleway',
                          ),
                        ),
                      )
                    : GestureDetector(
                        onTap: () {
                          _controller.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeIn,
                          );
                        },
                        child: const Text(
                          'NEXT',
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.amber,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Raleway',
                          ),
                        )),
              ],
            ),
          )
        ],
      ),
    );
  }
}
