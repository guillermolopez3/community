import 'package:cmarcas/config/routes.dart';
import 'package:cmarcas/screens/choice_account_cm.dart';
import 'package:cmarcas/screens/choice_category.dart';
import 'package:cmarcas/screens/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      onGenerateRoute: Routes.generarRutas,
      initialRoute: '/splash',
    );
  }
}

