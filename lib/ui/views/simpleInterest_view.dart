import 'package:flutter/material.dart';

class SimpleInterestView extends StatefulWidget {
  const SimpleInterestView({super.key});

  @override
  State<SimpleInterestView> createState() => _SimpleInterestViewState();
}

class _SimpleInterestViewState extends State<SimpleInterestView> {
  String TiempoSeleccionadoDropd1 = 'Diario';
  String TiempoSeleccionadoDropd2 =
      'Diario'; // Variable de estado para almacenar el valor seleccionado del género
  var Tiempos = <String>[
    'Diario',
    'Mensual',
    'Bimestral',
    'Trimestral',
    'Semestral',
    'Anual'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/imgs/bg.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          padding: EdgeInsets.symmetric(horizontal: 20),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  "Interes Simple",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                color: Colors.grey.withOpacity(0.5),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.3,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: Row(
                        children: [
                          Text(
                            "Datos",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.44,
                            child: TextField(
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 1.0,
                                  ),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                prefixIcon: Icon(Icons.attach_money),
                                labelText: 'Valor Presente',
                                labelStyle: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.44,
                            child: TextField(
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 1.0,
                                  ),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                prefixIcon: Icon(Icons.attach_money),
                                labelText: 'Valor Futuro',
                                labelStyle: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.44,
                            child: TextField(
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 1.0,
                                  ),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                prefixIcon: Icon(Icons.calendar_today),
                                labelText: 'Periodo',
                                labelStyle: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.44,
                            child: TextField(
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 1.0,
                                  ),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                prefixIcon: Icon(Icons.percent),
                                labelText: 'Interes',
                                labelStyle: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.44,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey
                                    .shade500, // Puedes cambiar el color del borde aquí
                                width:
                                    1.0, // Puedes ajustar el grosor del borde aquí
                              ),
                              borderRadius: BorderRadius.circular(
                                  8.0), // Puedes ajustar la esquina redondeada aquí
                            ),
                            child: Row(
                              children: [
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Icon(Icons.timer),
                                ),
                                Expanded(
                                  child: DropdownButton(
                                    hint: Text(
                                      'Tiempo',
                                      style: TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                    dropdownColor:
                                        Colors.white.withOpacity(0.9),
                                    icon: Icon(
                                      Icons.arrow_drop_down,
                                      color: Colors.black,
                                    ),
                                    iconSize: 36,
                                    isExpanded: true,
                                    underline: SizedBox(),
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                    value: TiempoSeleccionadoDropd1,
                                    onChanged: (newValue) {
                                      setState(() {
                                        TiempoSeleccionadoDropd1 = newValue
                                            .toString(); // Actualiza el valor seleccionado
                                      });
                                    },
                                    items: Tiempos.map((valueItem) {
                                      return DropdownMenuItem(
                                        value: valueItem,
                                        child: Text(valueItem),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.44,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey
                                    .shade500, // Puedes cambiar el color del borde aquí
                                width:
                                    1.0, // Puedes ajustar el grosor del borde aquí
                              ),
                              borderRadius: BorderRadius.circular(
                                  8.0), // Puedes ajustar la esquina redondeada aquí
                            ),
                            child: Row(
                              children: [
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Icon(Icons.timer),
                                ),
                                Expanded(
                                  child: DropdownButton(
                                    hint: Text(
                                      'Tiempo',
                                      style: TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                    dropdownColor:
                                        Colors.white.withOpacity(0.9),
                                    icon: Icon(
                                      Icons.arrow_drop_down,
                                      color: Colors.black,
                                    ),
                                    iconSize: 36,
                                    isExpanded: true,
                                    underline: SizedBox(),
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                    value: TiempoSeleccionadoDropd2,
                                    onChanged: (newValue) {
                                      setState(() {
                                        TiempoSeleccionadoDropd2 = newValue
                                            .toString(); // Actualiza el valor seleccionado
                                      });
                                    },
                                    items: Tiempos.map((valueItem) {
                                      return DropdownMenuItem(
                                        value: valueItem,
                                        child: Text(valueItem),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text("Calcular"),
                      style: ButtonStyle(
                        minimumSize:
                            MaterialStateProperty.all<Size>(Size(200, 40)),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.deepPurple),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
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
      ),
    );
  }
}
