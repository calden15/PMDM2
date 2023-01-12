import 'package:flutter/material.dart';
import 'package:practicafinal2/src/pages/personal_page.dart';
import 'package:practicafinal2/src/pages/widget_page.dart';
import 'package:practicafinal2/src/resources/persona.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("SPPMMD")),
      ),
      body: Center(
          child: Text(
        "Triau una opció:",
        style: TextStyle(fontSize: 20),
      )),
      floatingActionButton: Row(
        children: [
          SizedBox(width: 30),
          ElevatedButton(
              onPressed: () {
                _mostrarWidgetPage(context);
              },
              child: Text("WIDGET")),
          Expanded(child: SizedBox()),
          FloatingActionButton(
            onPressed: () {
              _mostrarPersonalPage(context);
            },
            child: Icon(Icons.account_circle),
          ),
        ],
      ),
    );
  }

  //Mètode que invoca la pàgina PersonalPage però espera una resposta
  Future<void> _mostrarPersonalPage(BuildContext context) async {
    final result =
        await Navigator.push(context, new MaterialPageRoute(builder: (context) {
      //Definim una persona per defecte i l'enviam a la classe PersonalPage
      var persona = new Persona("Toni", "Caldentey Salvà",
          new DateTime(1998, 11, 7), "tcaldenteysalva@gmail.com", "1234");
      return PersonalPage(persona: persona);
    }));

    //Esperam el retorn i si el que rebem no és null mostram un snackbar amb el
    //nom de la persona
    if (!mounted) return;
    if (result != null) {
      Persona persona = result;
      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(
              'Benvingut ${persona.nom}!',
              textAlign: TextAlign.center,
            ),
          ),
        );
    }
  }

//Mètode que invoca la pàgina WidgetPage
  void _mostrarWidgetPage(BuildContext context) {
    Navigator.push(context, new MaterialPageRoute(builder: (context) {
      return WidgetPage();
    }));
  }
}
