import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Event {
  final String title;

  const Event(this.title);

  @override
  String toString() => title;
}

// Function to fetch events from Firestore and create the events map
Future<Map<DateTime, List<Event>>> fetchEvents() async {
  Map<DateTime, List<Event>> events = {};

  await FirebaseFirestore.instance
      .collection('eventschedule')
      .get()
      .then((querySnapshot) {
    for (QueryDocumentSnapshot doc in querySnapshot.docs) {
      Timestamp timestamp = doc['selectedDate'];
      String title = doc['name'];

      DateTime date = timestamp.toDate().toUtc();
      events.putIfAbsent(date, () => []).add(Event(title)); // Group events by date
    }
  });

  return events;
}


