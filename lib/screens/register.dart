import 'package:cmarcas/bloc/auth_bloc/auth_b.dart';
import 'package:cmarcas/config/colors.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  final _mail = TextEditingController();
  final _pass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: MyColors.prymaryColor,
        appBar: AppBar(elevation: 0,),
        body: BlocListener<AuthBloc, AuthState>(
          listener: (context, state){
            if(state is AuthInProgress){
              Scaffold.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Enviando...'),
                        CircularProgressIndicator(),
                      ],
                    ),
                  ),
                );
            }
            if(state is Authenticated){
              Navigator.of(context).pushNamedAndRemoveUntil('/choiceAccount', (route) => false);
            }
            if(state is AuthError){
              Scaffold.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Text('Error al registrar usuario'), Icon(Icons.error)],
                    ),
                  ),
                );
            }
          },
          child: _body()
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

  _body(){
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left:10.0, right: 10),
            child: Text(
              'Registrate',
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
                _myTextForm('Correo Electrónico', 'Correo Electrónico *',_mail ,type: TextInputType.emailAddress),
                _myTextForm('Contraseña', 'Contraseña *', _pass,isPass: true),
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
                            if(_formKey.currentState.validate()){
                                  BlocProvider.of<AuthBloc>(context).add(CreateUserWithMail(_mail.text, _pass.text));
                            }else{
                                  Scaffold.of(context).showSnackBar(SnackBar(content: Text('Todos los campos con * son obligatorios'),));
                                  print('error');
                            }
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
                  BlocProvider.of<AuthBloc>(context).add(LoggedInWithGoogle());
                },
              )
            ],
          ),
          SizedBox(height: 25,),
          _tyc(context)
        ],
      ),
    );
  }

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
  _myTextForm(String hint, String text, TextEditingController control, {TextInputType type, int maxLine, isPass:false})=> TextFormField(
    style: TextStyle(color: Colors.white),
    controller: control,
    obscureText: isPass,
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



}
