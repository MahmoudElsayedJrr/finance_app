import 'package:finance_application/Services/Cubits/fetchData_cubit/fetch_data_cubit.dart';
import 'package:finance_application/Services/Models/finance_model.dart';
import 'package:finance_application/presentation/HomePage/activity_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
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
  void initState() {
    BlocProvider.of<FetchDataCubit>(context).FetchData(date: _selectedDay);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Activity'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: BlocBuilder<FetchDataCubit, FetchDataState>(
          builder: (context, state) {
            List<FinanceModel> list = BlocProvider.of<FetchDataCubit>(context)
                .TodayfinanceData
                .reversed
                .toList();
            return state is FetchDataLoading
                ? Center(child: CircularProgressIndicator())
                : state is FetchDataSuccess
                    ? Column(
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
                              BlocProvider.of<FetchDataCubit>(context)
                                  .FetchData(date: _selectedDay);
                            },
                          ),
                          SizedBox(height: 30),
                          Expanded(
                              child: ListView.builder(
                            itemCount: list.length,
                            physics: BouncingScrollPhysics(),
                            shrinkWrap: true,
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            itemBuilder: (context, index) {
                              return ActivityItem(
                                isPlus: list[index].isPlus,
                                price: list[index].price,
                                Title: list[index].title,
                                date: DateFormat.yMMMEd()
                                    .format(list[index].date),
                              );
                            },
                          ))
                        ],
                      )
                    : Container();
          },
        ),
      ),
    );
  }
}
