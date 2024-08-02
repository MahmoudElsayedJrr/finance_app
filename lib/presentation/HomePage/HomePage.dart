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
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'currancyContainer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    doSomeAsyncStuff();
  }

  void doSomeAsyncStuff() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('name') ?? " ";
    });
  }

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<FetchDataCubit>(context);

    return ValueListenableBuilder(
      valueListenable: Hive.box('darkModeBox').listenable(),
      builder: (context, box, child) {
        var darkmood = box.get('darkMode', defaultValue: false);
        return Scaffold(
          appBar: AppBar(
            title: Text('Welcome, ${username}'),
          ),
          drawer: newDrawer(
            darkmood: darkmood,
            onChanged: (p0) {
              box.put('darkMode', !darkmood);
            },
          ),
          body: BlocBuilder<FetchDataCubit, FetchDataState>(
            builder: (context, state) {
              List<FinanceModel> list = cubit.financeData.reversed.toList();
              return state is FetchDataLoading
                  ? Center(
                      child: CircularProgressIndicator(color: kPrimaryGreen))
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
                                      TextandIconColor: kPrimaryGreen,
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
                                      TextandIconColor: kPrimaryRed,
                                      color: kSeconderyRed,
                                      icon: Icons.remove_outlined,
                                      name: 'Minus',
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text('Activity',
                                      style: TextStyle(fontSize: 18)),
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
      },
    );
  }
}

class newDrawer extends StatelessWidget {
  const newDrawer({
    super.key,
    required this.darkmood,
    required this.onChanged,
  });
  final darkmood;
  final void Function(bool)? onChanged;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          DrawerHeader(
              child: Column(
            children: <Widget>[
              CircleAvatar(
                radius: 30,
                child: Text('${username![0]}'),
              ),
              SizedBox(height: 10),
              Text(
                '${username}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            ],
          )),
          Expanded(
            child: ListView(
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              children: [
                ListTile(
                  title: Text('Dark Mode'),
                  trailing: Switch(
                    value: darkmood,
                    onChanged: onChanged,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SeeAllActivity(),
                        ));
                  },
                  child: ListTile(
                      title: Text('All Activity'),
                      trailing: Icon(
                        Icons.list_rounded,
                        size: 30,
                      )),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
