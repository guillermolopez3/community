import 'dart:io';

import 'package:cmarcas/screens/home.dart';
import 'package:cmarcas/widgets/boton_redondeado.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ChoiceAccountCM extends StatefulWidget {
  @override
  _ChoiceAccountCMState createState() => _ChoiceAccountCMState();
}

class _ChoiceAccountCMState extends State<ChoiceAccountCM> {
  final _formKey = GlobalKey<FormState>();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
   double ancho=0;

  @override
  Widget build(BuildContext context) {
    ancho = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        body: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xffe01e5a),Color(0xffe6356b)],
                    begin: FractionalOffset.topLeft,
                    end: FractionalOffset.bottomRight
                )
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ListView(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top:30.0, left: 10, right: 10),
                    child: Center(
                      child: Text('Soy CM',style: TextStyle(fontSize: 30, color: Colors.white),),
                    ),
                  ),
                  SizedBox(height: 20,),
                  Text('Resgistrate como CM para que las marcas te encuentren', style: TextStyle(color: Colors.white),
                  ),
                  Divider(color: Colors.white,),
                  _seccionImagen(),
                  Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        _myTextForm('Tu Nombre', 'Tu Nombre *'),
                        _myTextForm('Teléfono', 'Teléfono *'),
                        _myTextForm('Categoría', 'Categoría *'),
                        SizedBox(height: 20,),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left:15.0, right: 15),
                                child: BotonRedondeado(
                                    pressed: (){
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
                                    texto: 'Quiero Trabajar'
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: FlatButton.icon(
                label: Text('Volver', style: TextStyle(color: Colors.white),),
                icon: Icon(Icons.arrow_back, color: Colors.white,),
                onPressed: (){
                  Navigator.pop(context);
                },
              ),
            )
          ],
        )
      ),
    );
  }
  _myTextForm(String hint, String text, {TextInputType type, int maxLine})=> TextFormField(
    style: TextStyle(color: Colors.white),
    decoration: InputDecoration(
        hintStyle: TextStyle(color: Colors.white),
        labelStyle: TextStyle(color: Colors.white),
        errorStyle: TextStyle(color: Colors.yellow),
        hintText: hint,
        labelText: text,
      enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white))
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

  ImagePicker _picker = ImagePicker();
  String _pathImg = 'assets/img/account.png';

  _seccionImagen()=> Container(
    height: 180,
    child: Stack(

      children: <Widget>[
        Align(
          alignment: Alignment(0,0),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child:_pathImg.contains('assets') ? Image.asset(_pathImg, height: 150, width: 150, fit: BoxFit.cover,)
                  : Image.file(File(_pathImg), height: 150,width: 150, fit: BoxFit.cover,)
          ),
        ),
        Align(
            alignment: Alignment(0.45, 0.60),
            child: Container(
              height: 45, width: 45,
              decoration: BoxDecoration(
                  color: Colors.amber,
                  shape: BoxShape.circle
              ),
              child: IconButton(
                onPressed: (){
                  showModal(context);
                  //getImage(context);
                },
                icon: Icon(Icons.photo_camera, color: Colors.white,),
              ),
            )
        )
      ],
    ),
  );

  Future getImage(String source) async {
    var pickedFile;

    if(source== 'camara'){
      pickedFile = await _picker.getImage(source: ImageSource.camera);
    }else if (source == 'galeria'){
      pickedFile = await _picker.getImage(source: ImageSource.gallery);
    }
    
    setState(() {
      _pathImg = pickedFile.path;
    });
  }

  showModal(BuildContext ctx) => _scaffoldKey.currentState.showBottomSheet((ctx){
    return Container(
      margin: const EdgeInsets.only(top: 5, left: 15, right: 15),
      decoration: BoxDecoration(
          borderRadius: new BorderRadius.only(
            topLeft: const Radius.circular(40.0),
            topRight: const Radius.circular(40.0),
          )
      ),
      height: 160,
      width: ancho,
      child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlatButton(
              child: Text('Cámara'),
              onPressed: () {
                Navigator.pop(ctx);
                getImage('camara');
              },
            ),
            FlatButton(
              child: Text('Galería'),
              onPressed: () {
                Navigator.pop(ctx);
                getImage('galeria');
              },
            )
          ]
      ),
    );
  }
  );

}

