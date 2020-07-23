import 'package:cmarcas/screens/home.dart';
import 'package:cmarcas/widgets/boton_redondeado.dart';
import 'package:flutter/material.dart';

class ChoiceAccountAgency extends StatefulWidget {
  @override
  _ChoiceAccountAgencyState createState() => _ChoiceAccountAgencyState();
}

class _ChoiceAccountAgencyState extends State<ChoiceAccountAgency> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xffecb22e),Color(0xffebbb4f)],
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
                      child: Text('Soy Marca',style: TextStyle(fontSize: 30, color: Colors.white),),
                    ),
                  ),
                  SizedBox(height: 20,),
                  Text('Registrate como marca', style: TextStyle(color: Colors.white),
                  ),
                  Divider(color: Colors.white,),
                  Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        _myTextForm('Nombre de la Empresa', 'Nombre Empresa *'),
                        _myTextForm('Mail', 'Mail *', type: TextInputType.emailAddress),
                        _myTextForm('Categoría', 'Categoría *'),
                        SizedBox(height: 20,),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left:15.0, right: 15),
                                child: BotonRedondeado(
                                    backColor: Colors.redAccent,
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
                                    texto: 'Quiero un CM'
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
}

class lala extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Container(
            color: Colors.red,
            child: ListView(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top:30.0, left: 10, right: 10),
                  child: Center(
                    child: Text('Soy CM',style: TextStyle(fontSize: 30),),
                  ),
                )
              ],
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            FlatButton.icon(
              label: Icon(Icons.arrow_forward),
              icon: Text('Soy Marca'),
              onPressed: (){},
            )
          ],
        )
      ],
    );
  }
}
