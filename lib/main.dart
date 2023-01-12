import 'package:flutter/material.dart';
import 'package:practicafinal2/src/pages/home_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      //Canviam el color del tema de blau a lila
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      //Definim els idiomes que podrem emplear encara que només empleam Català
      supportedLocales: [
        Locale('en', ''), // Anglés
        Locale('es', ''), // Castellà
        Locale('ca', ''), // Català
      ],
    );
  }
}
