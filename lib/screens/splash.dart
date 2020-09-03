import 'dart:async';

import 'package:cmarcas/bloc/auth_bloc/auth_b.dart';
import 'package:cmarcas/config/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.prymaryColor,
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (ctx,state){
          if (state is Uninitialized) {
            return _splshLogo();
          }
          if (state is AuthInProgress) {
            return _splshLogo();
          }
          if(state is Unauthenticated){
            irAlWelcome();
          }
          if(state is Authenticated){
            estaAutenticado();
          }
          return _splshLogo();
        },
      )
    );
  }

  void estaAutenticado(){
    Timer(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacementNamed('/home');
    });
  }
  void irAlWelcome(){
    Timer(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacementNamed('/welcome');
    });
  }
  _splshLogo() {
    return Center(
      child: Text(
        'Community.',
        style: GoogleFonts.montserratAlternates(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 34
        ),
      ),
    );
  }


}



