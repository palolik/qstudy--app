import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/pages/student_home.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../auth/authmain.dart';
import 'Eventlist.dart';
import 'eventliststudents.dart';
import 'faq.dart';
import 'notifications.dart';
import 'utils.dart';

class EventCal extends StatefulWidget {
  @override
  _EventCalState createState() => _EventCalState();
}

class _EventCalState extends State<EventCal> {
  Map<DateTime, List<Event>> events = {};
  Future<Map<DateTime, List<Event>>> fetchEvents() async {
    Map<DateTime, List<Event>> events = {};

    FirebaseFirestore.instance.collection('eventschedule').get().then((querySnapshot) {
      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        Timestamp timestamp = doc['selectedDate'];
        String title = doc['name'];

        DateTime date = timestamp.toDate().toUtc();
        events.putIfAbsent(date, () => []).add(Event(title)); // Group events by date
      }
    });

    return events;
  }
  final _formKey = GlobalKey<FormState>();
  var name = "";
  final nameController = TextEditingController();
  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode
      .toggledOff; // Can be toggled on/off by longpressing a date
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;





  TextEditingController _eventController = TextEditingController();
  late final ValueNotifier<List<Event>> _selectedEvents;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;

  @override
  void initState() {
    super.initState();

    _selectedDay = _focusedDay;
    _fetchEvents(); // Call the fetchEvents function
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
  }

  Future<void> _fetchEvents() async {
    events = await fetchEvents(); // Assign the fetched events to the events map
    setState(() {}); // Trigger a rebuild to display the events
  }

  List<Event> _getEventsForDay(DateTime day) {
    return events[day] ?? []; // Retrieve events from the fetched events map
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    nameController.dispose();
    super.dispose();
  }

  clearText() {
    nameController.clear();
  }

  CollectionReference schedule =
      FirebaseFirestore.instance.collection('schedule');

  Future<void> addUser() {
    return schedule
        .add({
          'name': name,
          'settingDate': DateTime.now(),
          'selectedDate': _selectedDay
        })
        .then((value) => print('schedule Added'))
        .catchError((error) => print('Failed to Add user: $error'));
  }



  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _rangeStart = null; // Important to clean those
        _rangeEnd = null;
        _rangeSelectionMode = RangeSelectionMode.toggledOff;
        _selectedEvents.value = _getEventsForDay(selectedDay);
      });
    }
  }
  void signUserOut() {
    FirebaseAuth.instance.signOut();
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MainPage()));
  }
  void _onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
    setState(() {
      _selectedDay = null;
      _focusedDay = focusedDay;
      _rangeStart = start;
      _rangeEnd = end;
      _rangeSelectionMode = RangeSelectionMode.toggledOn;
    });
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
                "Event Calender",
                style: TextStyle(
                  fontSize: 20,
                  color: Color.fromARGB(255, 255, 216, 0),
                ),
              ),
            ),
            TableCalendar<Event>(
              firstDay: DateTime.utc(2013, 3, 15),
              lastDay: DateTime.utc(2030, 3, 15),

              focusedDay: _focusedDay,

              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              // calendarFormat: _calendarFormat,
              eventLoader: _getEventsForDay,
              rangeSelectionMode: RangeSelectionMode.disabled,
              startingDayOfWeek: StartingDayOfWeek.saturday,
              daysOfWeekStyle: DaysOfWeekStyle(
                weekdayStyle: const TextStyle( color: Colors.yellow,fontWeight: FontWeight.w600),
                weekendStyle: const TextStyle( color: Colors.white,fontWeight: FontWeight.w600),
              ),
              headerStyle: HeaderStyle(
                titleCentered: true,
                formatButtonVisible: false,
                titleTextStyle:
                    const TextStyle(fontSize: 17.0, color: Colors.yellow),
                formatButtonTextStyle:
                    const TextStyle(fontSize: 14.0, color: Colors.yellow),
                leftChevronIcon:
                    const Icon(Icons.chevron_left, color: Colors.yellow),
                rightChevronIcon:
                    const Icon(Icons.chevron_right, color: Colors.yellow),
              ),
              calendarStyle: CalendarStyle(
                // rowDecoration: const BoxDecoration(
                //   color: Colors.green
                // ),
                rangeHighlightColor: const Color(0xFFFFC600),
                todayTextStyle: const TextStyle(
                    color: const Color(0xFFFFD800), fontSize: 16.0),
                todayDecoration: const BoxDecoration(
                    color: const Color(0xFF001925), shape: BoxShape.rectangle),
                selectedTextStyle: const TextStyle(
                    color: const Color(0xFF003148), fontSize: 16.0),
                selectedDecoration: const BoxDecoration(
                    color: const Color(0xFFFFD800), shape: BoxShape.rectangle),
                rangeStartTextStyle: const TextStyle(
                    color: const Color(0xFFFAFAFA), fontSize: 16.0),
                rangeStartDecoration: const BoxDecoration(
                    color: const Color(0xFF6699FF), shape: BoxShape.circle),
                rangeEndTextStyle: const TextStyle(
                    color: const Color(0xFFFAFAFA), fontSize: 16.0),
                rangeEndDecoration: const BoxDecoration(
                    color: const Color(0xFF6699FF), shape: BoxShape.circle),
                withinRangeDecoration:
                    const BoxDecoration(shape: BoxShape.circle),
                outsideTextStyle:
                    const TextStyle(color: const Color(0xFFAEAEAE)),
                outsideDecoration: const BoxDecoration(shape: BoxShape.circle),
                disabledTextStyle:
                    const TextStyle(color: const Color(0xFFFF0000)),
                disabledDecoration: const BoxDecoration(shape: BoxShape.circle),
                holidayTextStyle:
                    const TextStyle(color: const Color(0xFFF5F6F8)),
                holidayDecoration: const BoxDecoration(
                    border: const Border.fromBorderSide(const BorderSide(
                        color: const Color(0xFF1A1A1A), width: 1.4)),
                    shape: BoxShape.rectangle),
                weekendTextStyle:
                    const TextStyle(color: const Color(0xFFFFFFFF)),
                weekendDecoration: const BoxDecoration(shape: BoxShape.circle),
                weekNumberTextStyle: const TextStyle(
                    fontSize: 12, color: const Color(0xFFFFD900)),
                withinRangeTextStyle: const TextStyle(
                  color: Colors.white,
                ),
                defaultTextStyle: const TextStyle(
                  color: Colors.yellow,
                ),
                outsideDaysVisible: false,
              ),
              onDaySelected: _onDaySelected,
              onRangeSelected: _onRangeSelected,
              onFormatChanged: (format) {
                if (_calendarFormat != format) {
                  setState(() {
                    _calendarFormat = format;
                  });
                }
              },
              onPageChanged: (focusedDay) {
                _focusedDay = focusedDay;
              },
            ),
            const SizedBox(height: 8.0),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 0, 25, 37),
                // borderRadius: BorderRadius.only(
                //   bottomLeft: Radius.circular(20.0),
                //   bottomRight: Radius.circular(20.0),
                //   topLeft: Radius.zero,
                //   topRight: Radius.zero,
                // ),
              ),
              child: Text(
                "Events List",
                style: TextStyle(
                  fontSize: 20,
                  color: Color.fromARGB(255, 255, 216, 0),
                ),
              ),
            ),
            EventlistStudents(),

          ],
        ),
      ),
      ),
    );
  }
}
