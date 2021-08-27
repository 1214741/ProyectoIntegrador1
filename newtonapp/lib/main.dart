import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_signin_button/button_builder.dart';
import 'package:newtonapp/pages/register_page.dart';
import 'package:newtonapp/pages/signin_page.dart';

void main() {
  runApp(
    MaterialApp(
      initialRoute: '/',
      routes: {
        '/':  (context) => const MyApp(),
        'login': (context) => const SignInPage(),
        'register': (context) => const RegisterPage()
      }
    ),
    );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // desaparecer el cosito de debug arriba
      title: 'Newton APP',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Conquistaras a tu crush'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          titulo(),
          botonLogin(),
          botonRegister(),
        ],
      ),
      backgroundColor: Colors.purple.shade700, //Fonde de la pantalla
    );
  }

  Widget titulo() {
  return Container(
    padding: const EdgeInsets.all(10),
                alignment: Alignment.center,
                child: const Text('Bienvenido a Newton App',
                style: TextStyle(
                  color: Colors.white,
                )),
  );
  }
  Widget botonLogin() {
  return Container(
            //Boton Para ir al Login de la App
            padding: const EdgeInsets.all(10),
            alignment: Alignment.center,
            child: SignInButtonBuilder(
              //Aqui esta las config del Boton
              icon: Icons.verified_user,
              iconColor: Colors.purple.shade700,
              backgroundColor: Colors.white,
              text: 'Login',
              textColor: Colors.purple.shade700,
              onPressed: () {
                //Navigator.pushNamed(context, 'login');
                Navigator.push(context, MaterialPageRoute(builder: (context) => const SignInPage()));
              },
            ),
          );
}
  Widget botonRegister() {
    return Container(
              //Boton para ir al Registro de la App
              padding: const EdgeInsets.all(10),
              alignment: Alignment.center,
              child: SignInButtonBuilder(
                //Aqui esta las config del boton
                icon: Icons.person_add,
                iconColor: Colors.purple.shade700,
                backgroundColor: Colors.white,
                textColor: Colors.purple.shade700,
                text: 'Register',
                onPressed: () {
                  //Navigator.pushNamed(context, 'register');
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterPage()));
                },
              )
              );
  }
}


