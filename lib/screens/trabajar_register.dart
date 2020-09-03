import 'package:cmarcas/bloc/auth_bloc/auth_b.dart';
import 'package:cmarcas/bloc/auth_bloc/auth_event.dart';
import 'package:cmarcas/config/colors.dart';
import 'package:cmarcas/screens/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class TrabajarRegister extends StatefulWidget {
  @override
  _TrabajarRegisterState createState() => _TrabajarRegisterState();
}

class _TrabajarRegisterState extends State<TrabajarRegister> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    loadListCategoria();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: MyColors.prymaryColor,
        appBar: AppBar(elevation: 0,),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left:10.0, right: 10),
                child: Text(
                  'Registrate para trabajar',
                  style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 40,),
              Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _myTextForm('Teléfono', 'Teléfono *', type: TextInputType.emailAddress),
                    _myTextForm('Nombre', 'Nombre *'),
                    Padding(
                      padding: const EdgeInsets.only(top:15.0),
                      child: Text('Categoría', style: TextStyle(color: Colors.white, fontSize: 12),),
                    ),
                    _myDropDown(),
                    _myTextForm('Contraseña', 'Contraseña *'),
                    SizedBox(height: 20,),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left:15.0, right: 15),
                            child: OutlineButton(
                              padding: EdgeInsets.only(top: 15, bottom: 15),
                              borderSide: BorderSide(color: Colors.white),
                              child: Text('Crear cuenta', style: TextStyle(color: Colors.white),),
                              onPressed: (){
                                /*if(_formKey.currentState.validate()){
                                  Scaffold.of(context).showSnackBar(SnackBar(content: Text('Enviando Data'),));
                                }else{
                                  Scaffold.of(context).showSnackBar(SnackBar(content: Text('Todos los campos con * son obligatorios'),));
                                  print('error');
                                }*/
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => Home()),
                                );
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15,),
              Center(
                child: Text('o mediante redes sociales', style: TextStyle(color: Colors.white),),
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  RaisedButton(
                    padding: EdgeInsets.all(15),
                    child: Row(
                      children: <Widget>[
                        Image.asset('assets/img/facebook.png', height: 24,),
                        SizedBox(width: 10,),
                        Text('Facebook',style: TextStyle(color: Colors.white),),
                      ],
                    ),
                    color: MyColors.facebook,
                    onPressed: (){},
                  ),
                  RaisedButton(
                    padding: EdgeInsets.all(15),
                    child: Row(
                      children: <Widget>[
                        Image.asset('assets/img/google_l.png', height: 24,),
                        SizedBox(width: 10,),
                        Text('Google')
                      ],
                    ),
                    color: Colors.white,
                    onPressed: (){
                      return BlocProvider.of<AuthBloc>(context).add(LoggedInWithGoogle());
                    },
                  )
                ],
              ),
              SizedBox(height: 25,),
              _tyc(context)
            ],
          ),
        )
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
  _myTextForm(String hint, String text, {TextInputType type, int maxLine})=> TextFormField(
    style: TextStyle(color: Colors.white),
    decoration: InputDecoration(
        hintStyle: TextStyle(color: Colors.white),
        labelStyle: TextStyle(color: Colors.white),
        errorStyle: TextStyle(color: Colors.yellow),
        hintText: hint,
        labelText: text,
        enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.yellow))
    ),
    validator: (value)=> validarVacio(value),
    keyboardType: type != null ? type : TextInputType.text,
    maxLines: maxLine!= null ? maxLine : 1,
  );

  String validarVacio(String value){
    if(value.isEmpty){
      return 'Campo Obligatorio';
    }
    return null;
  }

  List<DropdownMenuItem<int>> listaCategoria = [];
  int _tipoCategoriaSeleccionado = 0;
  List<String> _tituloCategoria = [
    'Restaurante',
    'Indumentaria y accesorios',
    'Belleza, cosmética y cuidado perdonal',
    'Odontología',
    'Hotel, hostería y alojamiento',
    'Viajes y transporte',
    'Estudio jurídico y abogados',
    'Educación',
    'Organización sin fines de lucro'
  ];

  _myDropDown()=> DropdownButton(
    hint: Text('Categoría'),
    style: TextStyle(color: Colors.white),
    dropdownColor: MyColors.prymaryColor,
    underline: Container(color: Colors.white,height: 1,),
    iconEnabledColor: Colors.white,
    items: listaCategoria,
    value: _tipoCategoriaSeleccionado ,
    onChanged: (value){
      setState(() {
        _tipoCategoriaSeleccionado = value;
      });
    },
    isExpanded: true,
  );
  void loadListCategoria(){
    listaCategoria = [];
    listaCategoria.add(DropdownMenuItem(
      child: Text(_tituloCategoria[0]),
      value: 0,
    ));
    listaCategoria.add(DropdownMenuItem(
      child: Text(_tituloCategoria[1]),
      value: 1,
    ));
    listaCategoria.add(DropdownMenuItem(
      child: Text(_tituloCategoria[2]),
      value: 2,
    ));
    listaCategoria.add(DropdownMenuItem(
      child: Text(_tituloCategoria[3]),
      value: 3,
    ));
    listaCategoria.add(DropdownMenuItem(
      child: Text(_tituloCategoria[4]),
      value: 4,
    ));
    listaCategoria.add(DropdownMenuItem(
      child: Text(_tituloCategoria[5]),
      value: 5,
    ));
    listaCategoria.add(DropdownMenuItem(
      child: Text(_tituloCategoria[6]),
      value: 6,
    ));
    listaCategoria.add(DropdownMenuItem(
      child: Text(_tituloCategoria[7]),
      value: 7,
    ));
    listaCategoria.add(DropdownMenuItem(
      child: Text(_tituloCategoria[8]),
      value: 8,
    ));
  }


}
