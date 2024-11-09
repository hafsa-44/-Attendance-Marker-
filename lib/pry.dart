import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'screen3.dart'; // Import screen3.dart to use in the Students tab

class Event {
  final String title;
  Event(this.title);
}

class CalendarPage extends StatefulWidget {
  @override
   _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> with SingleTickerProviderStateMixin {
  late final ValueNotifier<List<Event>> _selectedEvents;
  late final CalendarFormat _calendarFormat;
  late DateTime _focusedDay;
  late DateTime _selectedDay;
  late TabController _tabController;

 String title = 'Default Title'; // Default title
  String subtitle = 'Default Subtitle'; // Default sub
 // Default title

  final Map<DateTime, List<Event>> _events = {}; // Sample events map

  @override
  void initState() {
    super.initState();
    _focusedDay = DateTime.now();
    _selectedDay = _focusedDay;
    _calendarFormat = CalendarFormat.month;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay));
    _tabController = TabController(length: 3, vsync: this);
  }
 @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Cast arguments as Map<String, String?>? to handle nullable values
    final arguments = ModalRoute.of(context)?.settings.arguments as Map<String, String?>?;
    
    // Use null-aware operator to assign values with fallbacks
    title = arguments?['title'] ?? 'Default Title';
    subtitle = arguments?['subtitle'] ?? 'Default Subtitle';
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    _tabController.dispose();
    super.dispose();
  }

  List<Event> _getEventsForDay(DateTime day) {
    final normalizedDay = DateTime(day.year, day.month, day.day);
    return _events[normalizedDay] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: const Color.fromARGB(255, 67, 157, 160),
          automaticallyImplyLeading: false,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.orange,
          tabs: const [
            Tab(text: 'Attendance'),
            Tab(text: 'Students'),
            Tab(text: 'History'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Attendance tab content (Calendar with events)
          Column(
            children: [
              TableCalendar(
                firstDay: DateTime.utc(2020, 1, 1),
                lastDay: DateTime.utc(2030, 12, 31),
                focusedDay: _focusedDay,
                selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                    _selectedEvents.value = _getEventsForDay(selectedDay);
                  });
                },
                onPageChanged: (focusedDay) {
                  _focusedDay = focusedDay;
                },
                calendarFormat: _calendarFormat,
                onFormatChanged: (format) {
                  setState(() {
                    _calendarFormat = format;
                  });
                },
                eventLoader: _getEventsForDay,
              ),
              Expanded(
                child: ValueListenableBuilder<List<Event>>(
                  valueListenable: _selectedEvents,
                  builder: (context, events, _) {
                    return ListView.builder(
                      itemCount: events.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(events[index].title),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
             AddStudentPage(),
          // Students tab content (using screen3.dart)
      // Replaces the body of the Students tab with Screen3

          // History tab content
          Center(
            child: Text("History Content Here"),
          ),
        ],
      ),
    );
  }
}
