import 'package:ecofinanza_app/ui/models/compoundInterest_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:convert';

class CompoundInterestView extends StatefulWidget {
  const CompoundInterestView({super.key});

  @override
  State<CompoundInterestView> createState() => _CompoundInterestViewState();
}

class _CompoundInterestViewState extends State<CompoundInterestView> {
  List<Color> gradientColors = [
    Color(0xff23b6e6),
    Color(0xff02d39a),
  ];
  //Instancia de la clase SimpleInterestModel
  late CompoundInterestModel ins;
  //Controladores de los campos de texto
  TextEditingController p = TextEditingController();
  TextEditingController f = TextEditingController();
  TextEditingController i = TextEditingController();
  TextEditingController n = TextEditingController();
  //Variables de control
  bool _isSwitched = false;
  String TiempoSeleccionadoDropd1 = 'Diario';
  String TiempoSeleccionadoDropd2 = 'Diario';
  int indexSelected1 = 0;
  int indexSelected2 = 0;
  String incg1 = "";
  String incg2 = "";
  String incg3 = "";
  String incg4 = "";
  double interestValue = 0;
  double nInterest = 0;
  String nCuota = "";
  //Lista de tiempos
  var Tiempos = <String>[
    'Diario',
    'Mensual',
    'Bimestral',
    'Trimestral',
    'Semestral',
    'Anual'
  ];
  //Funciones
  String FormatoMoneda(double numero) {
    NumberFormat f = NumberFormat("#,###.00#", "es_COP");
    String result = f.format(numero);
    return result;
  }

  String FormatoMoneda2(int numero) {
    NumberFormat f = NumberFormat("#,###.00#", "es_COP");
    String result = f.format(numero);
    return result;
  }

  String textoFormato(double n) {
    double i = n;
    String s = i.toStringAsFixed(2).split(".")[1];
    int h = int.parse(s);
    if (h == 0) {
      return i.toStringAsFixed(2).split(".")[0];
    } else {
      return i.toString();
    }
  }

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
                  "Interes Compuesto",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                color: Colors.white,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.3,
                child: Stack(children: []),
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
                              controller: p,
                              inputFormatters: [
                                CurrencyTextInputFormatter(
                                    locale: 'es-Co',
                                    symbol: '',
                                    decimalDigits: 2),
                              ],
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                helperText: incg1,
                                helperStyle: TextStyle(
                                  color: Colors.red.shade900,
                                ),
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
                              controller: f,
                              inputFormatters: [
                                CurrencyTextInputFormatter(
                                    locale: 'es-Co',
                                    symbol: '',
                                    decimalDigits: 2),
                              ],
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                helperText: incg2,
                                helperStyle: TextStyle(
                                  color: Colors.red.shade900,
                                ),
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
                            padding: EdgeInsets.only(top: 20),
                            child: TextField(
                              controller: n,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                helperText: incg3,
                                filled:
                                    true, // Esta propiedad indica que el fondo debe estar lleno.
                                fillColor: Color.fromARGB(255, 248, 246,
                                    247), // Establece el color de fondo en blanco.
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
                            height: 60,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 248, 246, 247),
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
                                        TiempoSeleccionadoDropd1 =
                                            newValue.toString();
                                        indexSelected1 = Tiempos.indexOf(
                                            newValue.toString());
                                        print(
                                            indexSelected1); // Actualiza el valor seleccionado
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
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.44,
                            padding: EdgeInsets.only(top: 20),
                            child: TextField(
                              controller: i,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                helperText: "Valor interes: $incg4",
                                filled:
                                    true, // Esta propiedad indica que el fondo debe estar lleno.
                                fillColor: Color.fromARGB(255, 248, 246,
                                    247), // Establece el color de fondo en blanco.
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
                          Container(
                            width: MediaQuery.of(context).size.width * 0.44,
                            height: 60,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 248, 246,
                                  247), // Establece el color de fondo en blanco.
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
                                        TiempoSeleccionadoDropd2 =
                                            newValue.toString();
                                        indexSelected2 = Tiempos.indexOf(
                                            newValue.toString());
                                        print(indexSelected2);
                                        // Actualiza el valor seleccionado
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
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            child: ElevatedButton(
                              onPressed: () {
                                // setState(() {
                                //   _isSwitched = !_isSwitched;
                                //   if (_isSwitched != false) {
                                //     calcularInteresSimple();
                                //     graficar();
                                //   } else {
                                //     nuevo();
                                //   }
                                // });
                              },
                              child: _isSwitched != false
                                  ? Text("Nuevo")
                                  : Text("Calcular"),
                              style: ButtonStyle(
                                minimumSize: MaterialStateProperty.all<Size>(
                                    Size(160, 40)),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.deepPurple),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          _isSwitched != false
                              ? Container(
                                  padding: EdgeInsets.symmetric(horizontal: 5),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      // calcularInteresSimple();
                                      // graficar();
                                    },
                                    child: Text("Recalcular"),
                                    style: ButtonStyle(
                                      minimumSize:
                                          MaterialStateProperty.all<Size>(
                                              Size(160, 40)),
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.deepPurple),
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : Container(),
                        ],
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
