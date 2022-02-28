import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:newtonapp/pages/retos/resultado_page.dart';
import 'package:newtonapp/providers/prueba_provider.dart';

class PruebasZone extends StatelessWidget {
  const PruebasZone({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: PruebasProvider(uid: 'prueba').getPrueba(),
      builder: (context, snapshot) {
        if(snapshot.hasData){
          Map<String, dynamic>? data =
                snapshot.data!.data() as Map<String, dynamic>;
          List<dynamic> mydata = List<dynamic>.from([data]);
          return PruebaPreguntas(mydata: mydata);
        } else {
            return const Center(child: CircularProgressIndicator());
        }
      });
    // String ruta = "/preguntas/preguntas.json";
    // return FutureBuilder(
    //     future: DefaultAssetBundle.of(context).loadString(ruta, cache: false),
    //     builder: (context, snapshot) {
    //       if (!snapshot.hasData) {
    //         return const Center(child: CircularProgressIndicator());
    //       } else {
    //       var mydata = jsonDecode(snapshot.data.toString());
    //         return PruebaPreguntas(
    //           mydata: mydata,
    //         );
    //       }
    //     });
  }
}

class PruebaPreguntas extends StatefulWidget {
  final List mydata;
  const PruebaPreguntas({Key? key, required this.mydata}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<PruebaPreguntas> createState() => _PruebaPreguntasState(mydata);
}

class _PruebaPreguntasState extends State<PruebaPreguntas> {
  final List mydata;
  _PruebaPreguntasState(this.mydata);

  // Tiempo inicial
  String showtimer = '0';
  int timer = 0;
  // Validaciones del tiempo
  bool canceltimer = false;
  bool disableAnswer = false;
  // Preguntas
  int puntaje = 0;
  //List pregunta = [];
  int resp = 0;
  int i = 1;
  int numPregunta = 1;
  late bool statusButtom;
  // Para analisis de la prueba
  int aciertos = 0;
  int errores = 0;
  DateTime? date;

  // Mapeo de colores de los botones
  Map<String, Color> btncolor = {
    "a": const Color.fromRGBO(0, 180, 216, 1),
    "b": const Color.fromRGBO(0, 180, 216, 1),
    "c": const Color.fromRGBO(0, 180, 216, 1),
    "d": const Color.fromRGBO(0, 180, 216, 1),
  };

  @override
  void initState() {
    date = DateTime.now();
    statusButtom = false;
    //_isDisabled = false;
    // Inicializar valores del timer
    iniciarTimer();
    starttimer();
    // Crear primera pregunta
    //hacerPregunta();
    super.initState();
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  void iniciarTimer() {
    showtimer = '10';
    timer = 10;
  }

  void starttimer() async {
    const onesec = Duration(seconds: 1);
    Timer.periodic(onesec, (Timer t) {
      setState(() {
        if (timer < 1) {
          t.cancel();
          nextquestion();
        } else if (canceltimer == true) {
          t.cancel();
        } else {
          timer = timer - 1;
        }
        showtimer = timer.toString();
      });
    });
  }

  hacerPregunta() {}

  void nextquestion() {
    canceltimer = false;
    timer = 10;
    setState(() {
      if (numPregunta < 8) {
        i = mydata[numPregunta];
        numPregunta++;
      } else {
        navegarPuntaje();
      }
      btncolor["a"] = const Color.fromRGBO(0, 180, 216, 1);
      btncolor["b"] = const Color.fromRGBO(0, 180, 216, 1);
      btncolor["c"] = const Color.fromRGBO(0, 180, 216, 1);
      btncolor["d"] = const Color.fromRGBO(0, 180, 216, 1);
      disableAnswer = false;
    });
    starttimer();
  }

  void navegarPuntaje() {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
            builder: (BuildContext context) => Resultado(
                puntaje: puntaje.toString(),
                lvl: "0",
                operacion: "Pruebas",
                tipo: "Prueba",
                aciertos: aciertos.toString(),
                errores: errores.toString(),
                cantPreg: "8",
                date: date.toString())),
        (route) => false);
  }

  void checkAnswer(String k) {
    Color color;
    if (mydata[2][i.toString()] == mydata[1][i.toString()][k]) {
      color = Colors.green;
      puntaje = puntaje + 5;
      aciertos++;
    } else {
      color = Colors.red;
      errores++;
    }
    setState(() {
      statusButtom = !statusButtom;
      btncolor[k] = color;
      canceltimer = true;
      disableAnswer = true;
    });
    Timer(const Duration(seconds: 1), nextquestion);
  }

  Widget respuestas(String k){
    return MaterialButton(
      onPressed: () {
        
      },
      child: Text(
        mydata[1][i.toString()][k]
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
                flex: 3,
                child: Center(
                  child: Text(
                    mydata[0][i.toString()],
                  ),
                )),
            Expanded(
                flex: 5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    respuestas('a'),
                    respuestas('b'),
                    respuestas('c'),
                    respuestas('d'),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: <Widget>[
                    //     respuestas('a'),
                    //     respuestas('b'),
                    //   ],
                    // ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: <Widget>[
                    //     respuestas('c'),
                    //     respuestas('d'),
                    //   ],
                    // )
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
