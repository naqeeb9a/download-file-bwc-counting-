import 'package:downloadfile/MVVM/View%20models/details_model_view.dart';
import 'package:downloadfile/MVVM/View%20models/login_model_view.dart';
import 'package:downloadfile/MVVM/View%20models/society_model_view.dart';
import 'package:downloadfile/Provider/captured_files.dart';
import 'package:downloadfile/Provider/user_data_provider.dart';
import 'package:downloadfile/Screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UserDataProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => SelectedSoceityProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => SocietyModelView(),
        ),
        ChangeNotifierProvider(
          create: (context) => CapturedFiles(),
        ),
        ChangeNotifierProvider(
          create: (context) => DetailsModelView(),
        ),
        ChangeNotifierProvider(
          create: (context) => LoginModelView(),
        )
      ],
      child: MaterialApp(
        title: 'BWC Image Scanner',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
