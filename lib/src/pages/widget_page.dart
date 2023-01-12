import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class WidgetPage extends StatefulWidget {
  const WidgetPage({super.key});

  @override
  State<WidgetPage> createState() => _WidgetPageState();
}

class _WidgetPageState extends State<WidgetPage> {
  late IconData _icona;
  final double sizeIcon = 150;
  //Color del icona
  Color _color = Colors.black;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //Triam un icona per defecte
    _icona = Icons.star;
    //Dibuixam el primer icona central
    _dibuixarIcona(_icona);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("WIDGET")),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.zero,
          child: _dibuixarIcona(_icona),
        ),
      ),
      //Llista a la part superior dreta de la pantalla
      endDrawer: DrawerTheme(
        child: Drawer(
          child: ListView(
            children: [
              SizedBox(
                child: DrawerHeader(
                  child: Text(
                    "FIGURES",
                    style: TextStyle(
                      //Modificam el títol
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  decoration:
                      BoxDecoration(color: Color.fromARGB(255, 98, 62, 139)),
                ),
                height: 60,
              ),
              //Definim tots els icones de la llista de figures
              iconaDrawer(Icons.square, context),
              Divider(height: 20),
              iconaDrawer(Icons.circle, context),
              Divider(height: 20),
              iconaDrawer(Icons.call, context),
              Divider(height: 20),
              iconaDrawer(Icons.remove_road, context),
              Divider(height: 20),
              iconaDrawer(Icons.picture_in_picture, context),
              Divider(height: 20),
              iconaDrawer(Icons.account_balance, context),
              Divider(height: 20),
              iconaDrawer(Icons.transcribe, context),
              Divider(height: 20),
              iconaDrawer(Icons.search, context),
              Divider(height: 20),
              iconaDrawer(Icons.snowboarding, context),
              Divider(height: 20),
              iconaDrawer(Icons.face, context),
            ],
          ),
          width: 100,
        ),
        //Canviam el color del Drawer
        data: DrawerThemeData(
            backgroundColor: Color.fromARGB(255, 168, 117, 197)),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(width: 30),
          FloatingActionButton(
            child: Icon(Icons.palette),
            onPressed: () {
              triarColor(context);
            },
          ),
        ],
      ),
    );
  }

  //Mètode que defineix l'icona central segons les variables de classe
  //i l'IconData rebut
  Widget _dibuixarIcona(IconData icona) {
    return Icon(
      icona,
      size: sizeIcon,
      color: _color,
    );
  }

  //Mètode que dibuixa l'icona al Drawer i l'hi afegeix una funcionalitat
  Widget iconaDrawer(IconData icona, BuildContext context) {
    return ListTile(
      leading: IconButton(
        onPressed: () {
          _icona = icona;
          setState(() {
            _dibuixarIcona(icona);
          });
          Navigator.pop(context);
        },
        icon: Icon(icona),
        iconSize: 50,
      ),
    );
  }

  //Mètode encarregat de mostrar el palette de colors i actualitzar l'icona
  void triarColor(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Tria un color"),
            content: SingleChildScrollView(
              child: ColorPicker(
                  pickerColor: Colors.black,
                  onColorChanged: (Color color) {
                    _color = color;
                  }),
            ),
            actions: <Widget>[
              ElevatedButton(
                child: const Text('Aplicar'),
                onPressed: () {
                  setState(() {
                    _dibuixarIcona(_icona);
                  });
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
}
