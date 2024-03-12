import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu'),
      ),
      body: GridView.count(
        crossAxisCount: 2, // Number of columns in the grid
        crossAxisSpacing: 16.0, // Spacing between columns
        mainAxisSpacing: 16.0, // Spacing between rows
        padding: EdgeInsets.all(16.0),
        children: [
          HomeBlock(
            title: 'Check Visa Status',
            onTap: () {
              // Implement the action for checking visa status
              print('Checking Visa Status');
            },
          ),
          HomeBlock(
            title: 'EMGS Status',
            onTap: () {
              // Implement the action for checking EMGS status
              print('Checking EMGS Status');
            },
          ),
          HomeBlock(
            title: 'Contact a Counsellor',
            onTap: () {
              // Implement the action for contacting counsellor
              print('Contact a Counsellor');
            },
          ),
          HomeBlock(
            title: 'Upcoming Events',
            onTap: () {
              // Implement the action for viewing events
              print('Showing Events');
            },
          ),
          HomeBlock(
            title: 'Share my location',
            onTap: () {
              // Implement the action for sharing location
              print('Contact a Counsellor');
            },
          ),
          HomeBlock(
            title: 'Select Your Flight Date',
            onTap: () {
              // Implement the action for selecting flight date
              print('Flight date selected');
            },
          ),
        ], // <-- Add a comma here
      ),
    );
  }
}

class HomeBlock extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const HomeBlock({required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 3.0,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.assignment,
                size: 40.0,
                color: Colors.blue,
              ),
              SizedBox(height: 8.0),
              Text(
                title,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
