import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:newtonapp/pages/retos/level_page.dart';
import 'package:newtonapp/shared/icons.dart';
import 'package:newtonapp/shared/drawer_menu.dart';

class Retos extends StatelessWidget {
  final List crearReto;
  const Retos({Key? key, required this.crearReto}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
    return WillPopScope(
      onWillPop: () async{
        return false;
      },
      child: Scaffold(
              appBar: myAppBar(context), // Organizar
      drawer: DrawerMenu(),
        backgroundColor: Colors.white,
        //backgroundColor: Colors.purple.shade700, //Fondo de la pantalla
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            //crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              titulo(context),
              //botones(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget titulo(context) {
    return Container(
      //color: Colors.amber[600],
      width: double.infinity,
      //height:MediaQuery.of(context).size.height*.5,
      padding: const EdgeInsets.all(50),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Escoja la\nOperación',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 30.0,
              ),
            ),
            botonesRetos(context, 'suma', MyIcons.add),
            botonesRetos(context, 'resta', MyIcons.minus),
            botonesRetos(context, 'mult', MyIcons.mult),
            botonesRetos(context, 'div', MyIcons.divide),
            //botonCancelar(context),
          ]),
    );
  }

  
  Widget botonesRetos(context, String zona, IconData icono) {
    // crearReto.add(zona);
    return Container(
        padding: const EdgeInsets.all(10),
        alignment: Alignment.center,
        child: MaterialButton(
          minWidth: 90.0,
          height: 90.0,
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.0),
          ),
          onPressed: () {
            crearReto.add(zona);
            Navigator.push(
                context, MaterialPageRoute(
                    builder: (BuildContext context) =>
                        Level(crearReto: crearReto)));
          },
          child: Icon(
            icono,
            color: Colors.purple.shade700,
            size: 35,
          ),
        ));
  }

  Widget botonCancelar(context) {
    return Container(
        padding: const EdgeInsets.all(10),
        alignment: Alignment.center,
        child: MaterialButton(
          minWidth: 220.0,
          height: 60.0,
          color: const Color.fromRGBO( 7, 194, 184, 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          onPressed: () {
           Navigator.of(context).pushNamedAndRemoveUntil('retosZone', ModalRoute.withName('index'));
          },
          child: const Text(
            'Cancelar',
            style: TextStyle(
              fontFamily: 'QRegular',
              color: Colors.white,
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ));
  }

  PreferredSizeWidget? myAppBar(context) {
    return AppBar(
      backgroundColor:  const Color.fromRGBO( 0, 180, 216, 1),
      elevation: 0.0,
      leading: Builder(builder: (context) {
        return IconButton(
          iconSize: 40.0,
          icon: const Icon(Icons.more_vert),
          color: Colors.white,
          onPressed: () => Scaffold.of(context).openDrawer(),
        );
      }),
      actions: <Widget>[
        IconButton(
          //atras
          iconSize: 40.0,
          onPressed: ()  {
Navigator.of(context).pushNamedAndRemoveUntil('retosZone', ModalRoute.withName('index'));
            /*await _authS.logOut();
            Navigator.of(context)
                .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);*/
          },
          icon: const Icon(Icons.close_rounded),
          color: Colors.white,
        ),
      ],
    );
  }

    Widget botones(context) {
    return Container(
      // color: Colors.white60,
      width: double.infinity,
      //height:MediaQuery.of(context).size.height*.5,
      padding: const EdgeInsets.all(30),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
               // botonSuma(context),
               // botonDiv(context),
                     ]
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
             // botonMult(context),
            
           // botonResta(context),
              ]
            ),
           
          ]),
    );
  }
}
