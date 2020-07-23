import 'dart:async';

import 'package:cmarcas/config/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacementNamed('/welcome');
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.prymaryColor,
      body: Center(
        child: Text(
          'Community.',
          style: GoogleFonts.montserratAlternates(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 34
          ),
        ),
      ),
    );
  }
}
