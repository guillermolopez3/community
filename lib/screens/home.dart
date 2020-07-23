import 'package:cmarcas/screens/actividad.dart';
import 'package:cmarcas/screens/perfil.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  final pantallas = [
    Actividad(),
    Perfil()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pantallas[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
          onTap: (idx){
            setState(() {
              _currentIndex = idx;
            });
          },
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.dashboard),
                title: Text('Actividad')
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_circle),
                title: Text('Perfil')
            )
          ]
      ),
    );
  }
}
