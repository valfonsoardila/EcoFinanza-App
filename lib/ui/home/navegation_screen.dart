import 'package:flutter/material.dart';

class NavegationScreen extends StatefulWidget {
  const NavegationScreen({super.key});

  @override
  State<NavegationScreen> createState() => _NavegationScreenState();
}

class _NavegationScreenState extends State<NavegationScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          leading: Image.asset('assets/icon/icon.png'),
          title: Text('EcoFinanza App'),
          bottom: TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.home),
                text: "Interes simple",
              ),
              // Tab(
              //   icon: Icon(Icons.video_call),
              //   text: "Interes Compuesto",
              // ),
              Tab(
                icon: Icon(Icons.settings),
                text: "Ajustes",
              )
            ],
          ),
        ),
      ),
    );
  }
}
