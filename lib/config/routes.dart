import 'package:cmarcas/screens/home.dart';
import 'package:cmarcas/screens/splash.dart';
import 'package:cmarcas/screens/welcome.dart';
import 'package:flutter/material.dart';

class Routes{
  static Route<dynamic> generarRutas(RouteSettings settings){
    final arguments = settings.arguments;
    switch(settings.name){
      case '/splash':
        return MaterialPageRoute(builder: (_)=> Splash());
      case '/home':
        return MaterialPageRoute(builder: (_)=> Home());
      case '/welcome':
        return MaterialPageRoute(builder: (_)=> Welcome());
      case '/detalleNota':
        //return MaterialPageRoute(builder: (_)=> NotaDetalle(notaModel: arguments,));
      default:
        print('error');
    }
  }
}