import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AcercaDe extends StatelessWidget {
  const AcercaDe({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            iconSize: 40.0,
            icon: const Icon(Icons.arrow_back_rounded),
            color: Colors.purple.shade700,
            onPressed: () => Navigator.of(context)
                .pushNamedAndRemoveUntil('index', ModalRoute.withName('index')),
          )
        ],
        title: const Text('Acerca De Nosotros'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          /*Container(
            padding: const EdgeInsets.all(10),
            alignment: Alignment.center,
            child: MaterialButton(
              minWidth: 230.0,
              height: 60.0,
              color: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
              onPressed: () async {
                Navigator.of(context).pushNamed('ComingSoon');
              },
              child: const Text(
                'Donaciones',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  //fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),*/
          Container(
            padding: const EdgeInsets.all(10),
            alignment: Alignment.center,
            child: MaterialButton(
              minWidth: 230.0,
              height: 60.0,
              color: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
              onPressed: () async {
                Navigator.of(context).pushNamed('comentarios');
              },
              child: const Text(
                'Dejanos tu Comentario',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  //fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            alignment: Alignment.center,
            child: const Text(
              'Aplicaci??n creada por\n'
              'Juan Fernando Tamayo Zapata\n'
              'Deyber Sepulveda Tuberquia\n'
              'Johnatan Andr??s G??mez Monsalve\n'
              '\nEstudiantes de Ingenier??a de Sistemas\n'
              'En la Universidad de Antioqu??a\n'
              '\nPara el Proyecto Integrador 1\ny el Proyecto Integrador 2\n'
              '\nSupervisado por\n'
              'Fernando Mora\n'
              'Oscar Ortega',
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
