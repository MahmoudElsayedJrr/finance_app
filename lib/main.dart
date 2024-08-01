import 'package:finance_application/Services/Cubits/fetchData_cubit/fetch_data_cubit.dart';
import 'package:finance_application/Services/Models/finance_model.dart';
import 'package:finance_application/core/ColorsConstants.dart';
import 'package:finance_application/presentation/HomePage/HomePage.dart';
import 'package:finance_application/presentation/onBordingScreens/YouName.dart';
import 'package:finance_application/presentation/onBordingScreens/onBoardingScreen.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  isOnBorded = prefs.getBool('onbordedone');
  await Hive.initFlutter();
  Hive.registerAdapter(FinanceModelAdapter());
  await Hive.openBox<FinanceModel>("FinanceBox");
  await Hive.openBox("darkModeBox");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FetchDataCubit()..FetchData(),
      child: ValueListenableBuilder(
        valueListenable: Hive.box('darkModeBox').listenable(),
        builder: (context, box, child) {
          var darkmood = box.get('darkMode', defaultValue: false);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            themeMode: darkmood ? ThemeMode.dark : ThemeMode.light,
            darkTheme: ThemeData.dark(useMaterial3: true),
            home: isOnBorded == true ? HomePage() : OnBoardingScreen(),
          );
        },
      ),
    );
  }
}
