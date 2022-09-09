
import 'package:flutter/material.dart';

import 'Screens/Home Screen.dart';



void main() => runApp( MyApp());


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'TASK ORGANISER',
        debugShowCheckedModeBanner: false,
        home:  HomeScreen()
    );
  }
}
