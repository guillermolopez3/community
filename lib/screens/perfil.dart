import 'package:cmarcas/bloc/auth_bloc/auth_b.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Perfil extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RaisedButton(
          child: Text('Cerrar Sesion'),
          onPressed: (){
            BlocProvider.of<AuthBloc>(context).add(LoggedOut());
          },
        ),
      ),
    );
  }
}
