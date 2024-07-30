import 'package:finance_application/presentation/HomePage/activity_item.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class SeeAllActivity extends StatefulWidget {
  const SeeAllActivity({super.key});

  @override
  State<SeeAllActivity> createState() => _SeeAllActivityState();
}

class _SeeAllActivityState extends State<SeeAllActivity> {
  DateTime _selectedDay = DateTime.now(), _focusedDay = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.week;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Activity'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            TableCalendar(
              firstDay: DateTime.utc(2024, 6, 1),
              lastDay: DateTime.now(),
              focusedDay: DateTime.now(),
              currentDay: _selectedDay,
              calendarFormat: _calendarFormat,
              onFormatChanged: (format) {
                setState(() {
                  _calendarFormat = format;
                });
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              },
            ),
            SizedBox(height: 30),
            Expanded(
                child: ListView.builder(
              itemCount: 8,
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(horizontal: 8),
              itemBuilder: (context, index) {
                return ActivityItem(
                  isPlus: true,
                  price: 70.00,
                  Title: 'Salary',
                  date: 'Mon, Oct 16, 2023',
                );
              },
            ))
          ],
        ),
      ),
    );
  }
}
