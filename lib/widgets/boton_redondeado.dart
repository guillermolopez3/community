import 'package:flutter/material.dart';

class BotonRedondeado extends StatefulWidget {

  final VoidCallback pressed;
  final Color textColor;
  final Color backColor;
  final String texto;
  final bool llevaIcono;
  final String pathIcono;

  BotonRedondeado({Key key, @required this.pressed, this.textColor = Colors.white,
    @required this.texto, this.llevaIcono= false, this.pathIcono, this.backColor});

  @override
  _BotonRedondeadoState createState() => _BotonRedondeadoState();
}

class _BotonRedondeadoState extends State<BotonRedondeado> {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
        onPressed: widget.pressed,
        color: widget.backColor ??  Colors.amber,
        shape: StadiumBorder(),
        child: widget.llevaIcono ? _botonConImagen() : _botonSinImagen()
    );
  }

  _texto() => Text(widget.texto, style: TextStyle(color: widget.textColor, fontFamily: 'helvetica_bold'),);

  _botonSinImagen()=> _texto();

  _botonConImagen() => Row(
    children: <Widget>[
      Image.asset(widget.pathIcono, width: 36, height: 36,),
      _texto()
    ],
  );
}