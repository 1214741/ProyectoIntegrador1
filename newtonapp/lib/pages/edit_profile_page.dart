import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:newtonapp/models/user.dart';
import 'package:newtonapp/pages/perfil_page.dart';
import 'package:newtonapp/providers/user_provider.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final UserProvider up = UserProvider();

class EditProfile extends StatefulWidget {
  final String title = 'Editar el Perfil';

  const EditProfile({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _EditPerfil();
}

class _EditPerfil extends State<EditProfile> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _edadController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
        future: up.getUsers(_auth.currentUser!.uid),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasData) {
            Map<String, dynamic>? data =
                snapshot.data!.data() as Map<String, dynamic>;
            return editarPerfil(data);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }

  Widget editarPerfil(Map<String, dynamic> data) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple.shade700,
          title: Text(widget.title),
        ),
        body: Container(
          padding: const EdgeInsets.all(10),
          alignment: Alignment.center,
          child: Column(
            children: <Widget>[
              editarNombre(data),
              editarEdad(data),
              botonActualizar(data),
              botonCancelar()
            ],
          ),
        ));
  }

  Widget editarNombre(data) {
    return Container(
        padding: const EdgeInsets.all(10),
        alignment: Alignment.center,
        child: TextFormField(
            controller: _nameController,
            decoration: InputDecoration(
                labelText: 'Ingresa tu nombre',
                hintText: data['nombre'],
                border: OutlineInputBorder())));
  }

  Widget editarEdad(data) {
    return Container(
        padding: const EdgeInsets.all(10),
        alignment: Alignment.center,
        child: TextFormField(
            controller: _edadController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                labelText: 'Ingresa tu edad',
                hintText: data['edad'],
                border: OutlineInputBorder())));
  }

  Widget botonActualizar(data) {
    return Container(
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
            actualizarDatos(data, _nameController.text, _edadController.text);
            //Navigator.of(context).popAndPushNamed((BuildContext context) => new PerfilUser());
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const PerfilUser()));
            //Navigator.pop(context);
          },
          child: Text(
            'Actualizar',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              //fontWeight: FontWeight.bold,
            ),
          ),
        ));
  }

  Widget botonCancelar() {
    return Container(
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
            Navigator.pop(context);
          },
          child: Text(
            'Cancelar',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              //fontWeight: FontWeight.bold,
            ),
          ),
        ));
  }

  Future<void> actualizarDatos(
      Map<String, dynamic> data, String? name, String? age) async {
    //User user;
    //name ??= data['nombre'];
    if (name == '') {
      name = data['nombre'];
    }
    //age ??= data['edad'];
    if (age == '') {
      age = data['edad'];
    }
    //User(data['correo'], name, age);
    //up.updateUser();
    try {
      return await up
          .getRealTimeUsers(_auth.currentUser!.uid)
          .set({'nombre': name, 'edad': age, 'correo': data['correo']});
    } catch (e) {
      Fluttertoast.showToast(
          msg: "Por favor ingrese todos los datos",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }
}
