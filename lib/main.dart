import 'package:flutter/material.dart';
import 'package:cek_penyakit/src/app.dart';
import 'package:cek_penyakit/src/screen/resultKesehatan.dart';
import 'package:cek_penyakit/src/screen/splashScreen.dart';
import 'package:cek_penyakit/src/blocs/kesehatanBloc.dart';
import 'package:cek_penyakit/src/resources/blocProvider.dart';

void main() {
  runApp(
    BlocProvider(
      bloc: KesehatanBloc(),
      child: MyApp(),
    ),
  );
}

ThemeData themeData = ThemeData(
  primarySwatch: Colors.purple,
  primaryColor: Color(0xFFf3c1c6),
  accentColor: Color(0xFFd8a6ab),
  brightness: Brightness.light,
);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cek Penyakit',
      theme: themeData,
      debugShowCheckedModeBanner: false,
      routes: {
        "/home": (context) => HomeApp(),
        "/splashscreen": (context) => SplashScreen(),
        "/hasilkesehatan": (context) => ResultKesehatan(),
      },
      home: InitApp(),
    );
  }
}

class InitApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future(() {
      Navigator.of(context).pushReplacementNamed("/splashscreen");
    });
    return Scaffold();
  }
}
