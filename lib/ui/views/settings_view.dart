import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingView extends StatefulWidget {
  const SettingView({super.key});

  @override
  State<SettingView> createState() => _SettingViewState();
}

class _SettingViewState extends State<SettingView> {
  //creare un popup para guardar el valor de la moneda
  _showDialogMoney() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Currency'),
          // content:
        );
      },
    );
  }

  //creare un popup para guardar el valor del idioma
  _showDialogLanguage() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Language'),
          // content:
        );
      },
    );
  }

  //creare un popup para guardar ajustar variables
  _showDialogVariables() {
    TextEditingController yearController = TextEditingController();
    TextEditingController iteracionesController = TextEditingController();
    guardarIteraciones() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int iteraciones = int.parse(iteracionesController.text);
      prefs.setInt('iteraciones', iteraciones);
    }

    guardarYear() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int year = int.parse(yearController.text);
      prefs.setInt('year', year);
    }

    cargarIteraciones() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int iteraciones = prefs.getInt('iteraciones') ?? 1000;
      setState(() {
        iteracionesController.text = iteraciones.toString();
      });
    }

    cargarYear() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int year = prefs.getInt('year') ?? 360;
      setState(() {
        yearController.text = year.toString();
      });
    }

    //llamo a las funciones para cargar los valores
    cargarIteraciones();
    cargarYear();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Ajustar Variables'),
          content: Container(
            height: 300,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: Text(
                    'Valores Globales',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 5),
                        child: Row(
                          children: [
                            Flexible(
                              child: TextField(
                                controller: yearController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor:
                                      const Color.fromARGB(255, 248, 246, 247),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                      color: Colors.black,
                                      width: 1.0,
                                    ),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  prefixIcon: const Icon(Icons.date_range),
                                  labelText: 'Valor de año laboral',
                                  labelStyle: const TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Text(
                    'Tasa interna de retorno',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 5),
                        child: Row(
                          children: [
                            Flexible(
                              child: TextField(
                                controller: iteracionesController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor:
                                      const Color.fromARGB(255, 248, 246, 247),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                      color: Colors.black,
                                      width: 1.0,
                                    ),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  prefixIcon: const Icon(Icons.loop),
                                  labelText: 'Numero de iteraciones',
                                  labelStyle: const TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                guardarIteraciones();
                guardarYear();
                Navigator.pop(context);
              },
              child: Text('Guardar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/imgs/bg.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
              margin: EdgeInsets.only(top: 10),
              padding: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.white.withOpacity(.9),
                    Colors.white.withOpacity(.1),
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Settings",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Icon(
                        Icons.settings,
                        color: Colors.black,
                        size: 30,
                      ),
                    ],
                  ),
                  SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton.icon(
                          onPressed: () {},
                          icon: Icon(
                            //quiero un icono que indique variable para agregar aqui
                            Icons.notifications,
                          ),
                          label: Text(
                            "Notificación",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          style: TextButton.styleFrom(
                            alignment: Alignment.centerLeft,
                            minimumSize: Size(
                                MediaQuery.of(context).size.width * 0.7, 50),
                            foregroundColor: Colors.black,
                          )),
                      Switch(
                        value: true,
                        onChanged: (value) {},
                        activeColor: Colors.black.withOpacity(.5),
                        activeTrackColor: Colors.black.withOpacity(.3),
                        inactiveThumbColor: Colors.white,
                        inactiveTrackColor: Colors.white.withOpacity(.5),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      TextButton.icon(
                          onPressed: () {
                            _showDialogVariables();
                          },
                          icon: Icon(
                            //quiero un icono que indique variable para agregar aqui
                            Icons.code,
                          ),
                          label: Text(
                            "Ajustar Varaibles",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          style: TextButton.styleFrom(
                            alignment: Alignment.centerLeft,
                            minimumSize: Size(
                                MediaQuery.of(context).size.width * 0.9, 50),
                            foregroundColor: Colors.black,
                          )),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      TextButton.icon(
                          onPressed: () {},
                          icon: Icon(
                            //quiero un icono que indique variable para agregar aqui
                            Icons.language,
                          ),
                          label: Text(
                            "Idioma",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          style: TextButton.styleFrom(
                            alignment: Alignment.centerLeft,
                            minimumSize: Size(
                                MediaQuery.of(context).size.width * 0.9, 50),
                            foregroundColor: Colors.black,
                          )),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      TextButton.icon(
                          onPressed: () {},
                          icon: Icon(
                            //quiero un icono que indique variable para agregar aqui
                            Icons.monetization_on_outlined,
                          ),
                          label: Text(
                            "Moneda",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          style: TextButton.styleFrom(
                            alignment: Alignment.centerLeft,
                            minimumSize: Size(
                                MediaQuery.of(context).size.width * 0.9, 50),
                            foregroundColor: Colors.black,
                          )),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                            onPressed: () {},
                            child: Text(
                              "Privacy",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            style: TextButton.styleFrom(
                              alignment: Alignment.centerLeft,
                              minimumSize: Size(
                                  MediaQuery.of(context).size.width * 0.9, 50),
                              foregroundColor: Colors.black,
                            ))
                      ]),
                  SizedBox(height: 20),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                            onPressed: () {},
                            child: Text(
                              "Terms & Conditions",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            style: TextButton.styleFrom(
                              alignment: Alignment.centerLeft,
                              minimumSize: Size(
                                  MediaQuery.of(context).size.width * 0.9, 50),
                              foregroundColor: Colors.black,
                            ))
                      ]),
                  SizedBox(height: 20),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                            onPressed: () {},
                            child: Text(
                              "About Us",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            style: TextButton.styleFrom(
                              alignment: Alignment.centerLeft,
                              minimumSize: Size(
                                  MediaQuery.of(context).size.width * 0.9, 50),
                              foregroundColor: Colors.black,
                            ))
                      ]),
                ],
              )),
        ),
      ),
    );
  }
}
