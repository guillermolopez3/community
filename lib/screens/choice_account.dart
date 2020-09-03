import 'package:cmarcas/config/colors.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ChoiceAccount extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.prymaryColor,
      appBar: AppBar(
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left:35, right: 35, top: 8, bottom: 8),
        child: Stack(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Seleccioná tipo \n de cuenta',
                  style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 30,),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: OutlineButton(
                        borderSide: BorderSide(color: Colors.white),
                        highlightedBorderColor: MyColors.primaryDarkColor,
                        padding: EdgeInsets.all(15),
                        child: Text('Quiero contratar community', style: TextStyle(color: Colors.white),),
                        onPressed: (){
                          Navigator.of(context).pushNamed('/contratar');
                        },
                      ),
                    )
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: OutlineButton(
                        padding: EdgeInsets.all(15),
                        borderSide: BorderSide(color: Colors.white),
                        highlightedBorderColor: MyColors.primaryDarkColor,
                        child: Text('Estoy buscando trabajo', style: TextStyle(color: Colors.white),),
                        onPressed: (){
                          Navigator.of(context).pushNamed('/trabajar');
                        },
                      ),
                    )
                  ],
                )
              ],
            ),
            Positioned(
              bottom: 10,
                left: 0,
                right: 0,
                child: _tyc(context)
            ),
          ],
        )
      ),
    );
  }

  //TODO llevar al sitio de tyc
  _tyc(BuildContext context) => RichText(text: TextSpan(
      text: 'Al registrarme, acepto los ',
      style: TextStyle(color: Colors.white ,fontSize: 14),
      children: [
        TextSpan(
            text: 'Términos de servicio de Community',
            style: TextStyle(fontSize: 14, decoration: TextDecoration.underline, color: Colors.white),
            recognizer: TapGestureRecognizer()..acceptGesture(12)
              ..onTap = () => _launchUrl()

        )
      ]
  ));

  _launchUrl() async{
    print('launch');
    String url = 'https://www.wasapeame.com/terminos-y-condiciones';
    try{
      if (await canLaunch(url)) {
        print('into');
        await launch(url);
      } else {
        throw 'No se pudo abrir la url  $url';
      }
    }
    catch(error){
      print('error $error');
    }

  }
}
