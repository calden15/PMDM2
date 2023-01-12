import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../resources/persona.dart';

class PersonalPage extends StatefulWidget {
  final Persona persona;
  PersonalPage({required this.persona});

  @override
  State<PersonalPage> createState() => _PersonalPageState();
}

class _PersonalPageState extends State<PersonalPage> {
  //Atributs de persona
  late Persona _persona;
  late String _nom;
  late String _cognoms;
  late DateTime _dataNaixament;
  late String _email;
  late String _password;
  //Si la contrassenya és visible
  late bool _passwordVisible;

  //Controladors
  TextEditingController _inputFieldNomController = TextEditingController();
  TextEditingController _inputFieldCognomsController = TextEditingController();
  TextEditingController _inputFieldDataController = TextEditingController();
  TextEditingController _inputFieldEmailController = TextEditingController();
  TextEditingController _inputFieldPasswordController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    //Inicialitzam persona
    _persona = widget.persona;
    _nom = widget.persona.nom;
    _cognoms = widget.persona.cognoms;
    _dataNaixament = widget.persona.dataNaixament;
    _email = widget.persona.email;
    _password = widget.persona.password;
    //Posam la contrasenya que no sigui visible
    _passwordVisible = false;
    //Inicialitzam els controladors
    _inputFieldNomController = new TextEditingController(text: _persona.nom);
    _inputFieldCognomsController =
        new TextEditingController(text: _persona.cognoms);
    _inputFieldDataController = new TextEditingController(
        text: DateFormat("dd-MM-yyyy").format(_persona.dataNaixament));
    _inputFieldEmailController =
        new TextEditingController(text: _persona.email);
    _inputFieldPasswordController =
        new TextEditingController(text: _persona.password);
    super.initState();
  }

  @override
  void dispose() {
    _inputFieldNomController.dispose();
    _inputFieldCognomsController.dispose();
    _inputFieldDataController.dispose();
    _inputFieldEmailController.dispose();
    _inputFieldPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Caldentey")),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
        children: [
          _crearNom(),
          Divider(),
          _crearCognom(),
          Divider(),
          _crearData(context),
          Divider(),
          _crearCorreu(),
          Divider(),
          _crearPassword(),
          SizedBox(height: 150),
          Row(
            children: [
              //Botó de guardar
              FloatingActionButton(
                onPressed: () {
                  _actualitzarPersona();
                  Navigator.pop(context, _persona);
                },
                child: Icon(Icons.check),
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.end,
          ),
        ],
      ),
    );
  }

  Widget _crearNom() {
    return TextField(
      textCapitalization: TextCapitalization.words,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        labelText: "Nom",
        hintText: "Nom",
        icon: Icon(Icons.account_circle),
      ),
      controller: _inputFieldNomController,
      onChanged: (valor) {
        //Guardam el valor a la variable de classe
        _nom = valor;
      },
      onTap: () => _inputFieldNomController.clear(),
    );
  }

  Widget _crearCognom() {
    return TextField(
      textCapitalization: TextCapitalization.words,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        labelText: "Cognoms",
        hintText: "Cognoms",
        icon: Icon(Icons.account_box),
      ),
      controller: _inputFieldCognomsController,
      onChanged: (valor) {
        //Guardam el valor a la variable de classe
        _cognoms = valor;
      },
      onTap: () => _inputFieldCognomsController.clear(),
    );
  }

  Widget _crearData(BuildContext context) {
    return TextField(
      enableInteractiveSelection: false,
      controller: _inputFieldDataController,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        labelText: "Data Naixament",
        hintText: "Data Naixament",
        icon: Icon(Icons.calendar_today),
      ),
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
        _seleccionaData(context);
      },
    );
  }

  Widget _crearCorreu() {
    return TextField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        labelText: "Correu Electrònic",
        hintText: "Correu Electrònic",
        icon: Icon(Icons.email),
      ),
      controller: _inputFieldEmailController,
      onChanged: (valor) {
        _email = valor;
      },
      onTap: () => _inputFieldEmailController.clear(),
    );
  }

  Widget _crearPassword() {
    return TextFormField(
      obscureText: !_passwordVisible,
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          labelText: "Contrassenya",
          hintText: "Contrassenya",
          icon: Icon(Icons.lock),
          suffixIcon: IconButton(
            icon: Icon(
                _passwordVisible ? Icons.visibility : Icons.visibility_off),
            onPressed: () {
              setState(() {
                _passwordVisible = !_passwordVisible;
              });
            },
          )),
      controller: _inputFieldPasswordController,
      onChanged: (valor) {
        _password = valor;
      },
      onTap: () => _inputFieldPasswordController.clear(),
    );
  }

  Future<void> _seleccionaData(BuildContext context) async {
    DateTime? picked = await showDatePicker(
        context: context,
        //Posam l'idioma a catlà
        locale: Locale("ca", "ES"),
        initialDate: _persona.dataNaixament,
        firstDate: DateTime(1900),
        lastDate: DateTime(2022));
    if (picked != null) {
      setState(() {
        //Guardam el valor a la variable de classe
        _dataNaixament = picked;
        //Canviam el format al que volem mostrar
        _inputFieldDataController.text =
            DateFormat("dd-MM-yyyy").format(_dataNaixament);
      });
    }
  }

  //Mètode que actualitza l'objecte Persona
  void _actualitzarPersona() {
    _persona.nom = _nom;
    _persona.cognoms = _cognoms;
    _persona.dataNaixament = _dataNaixament;
    _persona.email = _email;
    _persona.password = _password;
  }
}
