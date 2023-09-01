import 'dart:ui';

import 'package:ecofinanza_app/ui/views/settings_view.dart';
import 'package:ecofinanza_app/ui/views/simpleInterest_view.dart';
import 'package:flutter/material.dart';

class NavegationScreen extends StatefulWidget {
  const NavegationScreen({super.key});

  @override
  State<NavegationScreen> createState() => _NavegationScreenState();
}

class _NavegationScreenState extends State<NavegationScreen> {
  final List<Widget> _widgetOptions = <Widget>[
    SimpleInterestView(),
    SettingView(),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _widgetOptions.length, // Cambio la longitud del TabController
      child: Scaffold(
        appBar: AppBar(
          leading: CircleAvatar(
            backgroundColor: Colors.white,
            backgroundImage: AssetImage('assets/icon/icon.png'),
            radius: 25,
          ),
          title: Text(
            'EcoFinanza App',
          ),
          titleTextStyle: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          backgroundColor: Colors.transparent, // Hacer el fondo transparente
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF884ED9), Color.fromARGB(255, 51, 20, 94)],
                // Colores del gradiente
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          elevation: 0,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight + 10),
            child: Container(
              // color: Colors.amberAccent, // Color de fondo del TabBar
              child: TabBar(
                dividerColor: Colors.transparent,
                splashBorderRadius: BorderRadius.circular(20),
                labelColor: Colors.white,
                indicatorSize: TabBarIndicatorSize.label,
                indicatorWeight: 5,
                indicatorColor: LinearGradient(
                  colors: [Color(0xFF0D0D0D), Color(0xFFF2A35E)],
                  // Colores del gradiente
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ).colors[1],
                tabs: [
                  Tab(
                    icon: Icon(Icons.calculate),
                    text: 'Interes Simple',
                  ),
                  Tab(
                    icon: Icon(Icons.settings),
                    text: 'Configuración',
                  ),
                ],
              ),
            ),
          ),
        ),
        body: TabBarView(children: _widgetOptions),
      ),
    );
  }
}
