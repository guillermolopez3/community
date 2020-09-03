import 'package:cmarcas/bloc/auth_bloc/auth_b.dart';
import 'package:cmarcas/config/colors.dart';
import 'package:cmarcas/config/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=> AuthBloc()..add(AppLaunched()),
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: MyColors.prymaryColor,
          accentColor: MyColors.prymaryColor,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        onGenerateRoute: Routes.generarRutas,
        initialRoute: '/splash',
      ),
    );
  }
}

