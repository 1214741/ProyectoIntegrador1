import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_signin_button/button_builder.dart';

class IndexPage extends StatelessWidget {
  @override
   Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('La Newton App Re-Loco'),
        backgroundColor: Colors.blueAccent,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            //Texto inicial en la App
            padding: const EdgeInsets.all(10),
            alignment: Alignment.center,
            child: Text('Elija a donde quere ir'),
          ),          
          Container(// Boton para ir a la zona de Aprendizaje
            padding: const EdgeInsets.all(10),
            alignment: Alignment.center,            
            child: SignInButtonBuilder(
                //Aqui esta las config del Boton
                icon: Icons.verified_user,
                backgroundColor: Colors.orange,
                text: 'Aprendizaje',
                onPressed: () {
                  /*Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignInPage()));*/
                },
                ),
                
          ),
          Container(//Boton para ir a los Retos de la App
              padding: const EdgeInsets.all(10),
              alignment: Alignment.center,
              child: SignInButtonBuilder(
                  //Aqui esta las config del Boton
                  icon: Icons.person_add,
                backgroundColor: Colors.indigo,
                text: 'Retos',
                  onPressed: () {
                    /*Navigator.push(context,
                        MaterialPageRoute(builder: (context) => RegisterPage()));*/
                  },
                  )
          ),
        ],
      ),
      backgroundColor: Colors.purple.shade200,//Color de Fondo
    );
  }
}