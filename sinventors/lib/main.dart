//import 'package:sinventors/splashscreen_view.dart';
import 'package:sinventors/Beranda.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
 
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return new MaterialApp(
      title: 'SInventors',
      theme: new ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: new Beranda(),
    );
      
  }
}

  // run App(MaterialApp(
  //   debugShowCheckedModeBanner: false,
  //   title: 'Splash Screen',
  //   home: SplashScreenPage(),
  // ));