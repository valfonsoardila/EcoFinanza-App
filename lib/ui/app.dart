import 'package:ecofinanza_app/ui/anim/introSimple_app.dart';
import 'package:ecofinanza_app/ui/home/navegation_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'EcoFinanza App',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      initialRoute: '/',
      routes: {
        "/": (context) => IntroSimple(),
        "/principal": (context) => NavegationScreen(),
      },
    );
  }
}
