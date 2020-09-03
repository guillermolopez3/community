import 'package:carousel_slider/carousel_slider.dart';
import 'package:cmarcas/config/colors.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Welcome extends StatefulWidget {

  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  static final List<String> imgList = [
    'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
  ];

  var tituloImg = [
    'Descripción 1',
    'Descripción 2',
    'Descripción 3',
  ];

  int _current = 0;
  static double ancho;


  @override
  Widget build(BuildContext context) {
    ancho = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: MyColors.prymaryColor,
      body: Padding(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            SizedBox(height: 15,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  'Community.',
                  style: GoogleFonts.montserratAlternates(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 34
                  ),
                ),
              ),
            ),
            SizedBox(height: 10,),
            Text(
              'Encontrá el community manager para tu negocio',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white
              ),
            ),
            SizedBox(height: 10,),
            _slider(),
            SizedBox(height: 10,),
            RaisedButton(
              color: Colors.white,
              padding: EdgeInsets.only(top: 15, bottom: 15),
              child: Text(
                'Crear Cuenta',
                style: TextStyle(color: MyColors.prymaryColor,),
              ),
              onPressed: (){
                Navigator.of(context).pushNamed('/register');
              },
            ),
            SizedBox(height: 15,),
            _ingresar()
          ],
        ),
      ),
    );
  }

  _ingresar() => Center(
    child: RichText(text: TextSpan(
        text: '¿Ya tenés una cuenta? ',
        style: TextStyle(color: Colors.white ,fontSize: 14),
        children: [
          TextSpan(
              text: 'Entrar',
              style: TextStyle(fontSize: 14, decoration: TextDecoration.underline, color: Colors.white),
              recognizer: TapGestureRecognizer()..onTap = (){
                Navigator.of(context).pushReplacementNamed('/home');
              }
          )
        ]
    )),
  );

  _slider(){
    return Column(
        children: [
          CarouselSlider(
            items: imageSliders,
            options: CarouselOptions(
                height: 250,
                autoPlay: true,
                enlargeCenterPage: true,
                aspectRatio: 2.0,
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                }
            ),
          ),
          SizedBox(height: 10,),
          Center(
            child: Text(tituloImg[_current], style: TextStyle(color: Colors.white, fontSize: 18),),
          ),
          SizedBox(height: 5,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: imgList.map((url) {
              int index = imgList.indexOf(url);
              return Container(
                width: 8.0,
                height: 8.0,
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _current == index
                      ? Color.fromRGBO(255, 255, 255, 0.9)
                      : Color.fromRGBO(255, 255, 255, 0.4),
                ),
              );
            }).toList(),
          ),
        ]
    );
  }

  final List<Widget> imageSliders = imgList.map((item) => Container(
    child: Container(
      margin: EdgeInsets.all(5.0),
      child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          child: Image.network(item, fit: BoxFit.cover, width: ancho,)
      ),
    ),
  )).toList();
}
