import 'dart:ffi';

import 'package:finance_application/Services/Cubits/fetchData_cubit/fetch_data_cubit.dart';
import 'package:finance_application/Services/Models/finance_model.dart';
import 'package:finance_application/core/ColorsConstants.dart';
import 'package:finance_application/presentation/HomePage/All_Activity/see_all_activity.dart';
import 'package:finance_application/presentation/HomePage/DismissibleButton.dart';
import 'package:finance_application/presentation/HomePage/activity_item.dart';
import 'package:finance_application/presentation/HomePage/plusAndMinusButton.dart';
import 'package:finance_application/presentation/HomePage/plus_and_minus_page/plus_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'currancyContainer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<FetchDataCubit>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome, Mahmoud'),
        actions: [
          IconButton(
            icon: Icon(Icons.settings_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: BlocBuilder<FetchDataCubit, FetchDataState>(
        builder: (context, state) {
          List<FinanceModel> list = cubit.financeData.reversed.toList();
          return state is FetchDataLoading
              ? Center(child: CircularProgressIndicator(color: kPrimaryGreen))
              : state is FetchDataSuccess
                  ? Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        children: [
                          currancyContainer(
                              secondryColor: KseconderyPurble,
                              title: 'My Balance',
                              price: cubit.Balance),
                          SizedBox(height: 10),
                          currancyContainer(
                              secondryColor: kSeconderyRed,
                              title: 'Todey',
                              price: cubit.TodayBalance),
                          SizedBox(height: 30),
                          Row(
                            children: [
                              Flexible(
                                child: plusAndMinusButton(
                                  ontap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => PlusPage(
                                                  isPlus: true,
                                                )));
                                  },
                                  color: kSeconderyGreen,
                                  icon: Icons.add_outlined,
                                  name: 'Plus',
                                ),
                              ),
                              SizedBox(width: 10),
                              Flexible(
                                child: plusAndMinusButton(
                                  ontap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => PlusPage(
                                                  isPlus: false,
                                                )));
                                  },
                                  color: kSeconderyRed,
                                  icon: Icons.remove_outlined,
                                  name: 'Minus',
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text('Activity', style: TextStyle(fontSize: 18)),
                              InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SeeAllActivity()));
                                  },
                                  child: Text('See all',
                                      style: TextStyle(fontSize: 18))),
                            ],
                          ),
                          SizedBox(height: 20),
                          Expanded(
                              child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: list.length,
                            keyboardDismissBehavior:
                                ScrollViewKeyboardDismissBehavior.onDrag,
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return DismissibleButton(
                                onDismissed: (direction) async {
                                  if (direction ==
                                      DismissDirection.startToEnd) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => PlusPage(
                                            Model: list[index],
                                            isPlus: list[index].isPlus,
                                          ),
                                        ));
                                  } else if (direction ==
                                      DismissDirection.endToStart) {
                                    list[index].delete();
                                    await BlocProvider.of<FetchDataCubit>(
                                            context)
                                        .FetchData();
                                  }
                                },
                                child: ActivityItem(
                                  isPlus: list[index].isPlus,
                                  price: list[index].price,
                                  Title: list[index].title,
                                  date: DateFormat.yMMMEd()
                                      .format(list[index].date),
                                ),
                              );
                            },
                          )),
                        ],
                      ),
                    )
                  : Container();
        },
      ),
    );
  }
}
