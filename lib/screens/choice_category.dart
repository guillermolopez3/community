import 'package:cmarcas/screens/choice_account_agency.dart';
import 'package:cmarcas/screens/choice_account_cm.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChoiceCategory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
                child: InkWell(
                  onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (_)=>ChoiceAccountAgency() )),
                  child: Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Color(0xffecb22e),Color(0xffebbb4f)],
                            begin: FractionalOffset.topLeft,
                            end: FractionalOffset.bottomRight
                        )
                    ),
                    child: Center(child: Text('Soy Marca', style: GoogleFonts.lato(color: Colors.white, fontSize: 36, fontWeight: FontWeight.w600))),
                  ),
                ),
            ),
            Expanded(
              child: InkWell(
                onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (_)=>ChoiceAccountCM() )),
                child: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Color(0xffe01e5a),Color(0xffe6356b)],
                          begin: FractionalOffset.topLeft,
                          end: FractionalOffset.bottomRight
                      )
                  ),
                  child: Center(child: Text('Soy CM', style: GoogleFonts.lato(color: Colors.white, fontSize: 36, fontWeight: FontWeight.w600))),
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}
