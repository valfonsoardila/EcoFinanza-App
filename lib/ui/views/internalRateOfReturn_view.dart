import 'package:ecofinanza_app/ui/models/internalRateReturn_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InternalRateOfReturnView extends StatefulWidget {
  InternalRateOfReturnView({super.key});

  @override
  State<InternalRateOfReturnView> createState() =>
      _InternalRateOfReturnViewState();
}

class _InternalRateOfReturnViewState extends State<InternalRateOfReturnView> {
  List<_StepAreaData>? chartData;
  List<Color> gradientColors = [Colors.green, Colors.yellow];
  bool _isSwitched = false;
  String incg1 = "";
  String incg2 = "";
  String incg3 = "";
  String incg4 = "";
  TextEditingController inversion = TextEditingController();
  TextEditingController interes = TextEditingController();
  TextEditingController flujo = TextEditingController();
  TextEditingController tir = TextEditingController();
  TextEditingController van = TextEditingController();
  late InternalRateReturnModel intrr;
  List<double> flujosDeCaja = [];
  int indexSelected1 = 0;
  String TiempoSeleccionadoDropd1 = 'Mensual';
  int indexSelected2 = 0;
  int iteraciones = 0;
  String TiempoSeleccionadoDropd2 = 'Mensual';
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
  void addRow() {
    setState(() {
      flujosDeCaja.add(0);
    });
  }

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

  void agregarFlujo() {
    setState(() {
      // Verifica si flujosDeCaja está vacío, si lo está, agrega la inversión inicial
      if (flujosDeCaja.isEmpty) {
        double inversionInicial = double.parse(
                inversion.text.replaceAll('.', '').replaceAll(',', '.')) *
            -1;
        flujosDeCaja.add(inversionInicial);
      }
      // Luego agrega el nuevo flujo ingresado en el campo de texto
      flujosDeCaja.add(
          double.parse(flujo.text.replaceAll('.', '').replaceAll(',', '.')));
      flujo.text = "";
    });
  }

  obtenerIteraciones() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      iteraciones = prefs.getInt('iteraciones') ?? 1000;
    });
  }

  calcularTasaInternaDeRetorno() {
    obtenerIncognita();
    intrr.inversion =
        double.parse(inversion.text.replaceAll('.', '').replaceAll(',', '.'));
    intrr.interes =
        double.parse(interes.text.replaceAll('.', '').replaceAll(',', '.'));
    intrr.iTiempo = indexSelected1;
    intrr.iTiempo = indexSelected2;
    intrr.flujos = flujosDeCaja;
    print("Iteraciones: $iteraciones");
    intrr.iteraciones = iteraciones;
    intrr.criterio();
    inversion.text = FormatoMoneda(intrr.inversion);
    tir.text = FormatoMoneda(intrr.tir);
    van.text = FormatoMoneda(intrr.van);
  }

  obtenerIncognita() {
    if (inversion.text == "") {
      inversion.text = "0";
      setState(() {
        incg1 = "Incognita";
        incg2 = "";
        incg3 = "";
        incg4 = "";
      });
    } else if (interes.text == "") {
      interes.text = "0";
      setState(() {
        incg1 = "";
        incg2 = "Incognita";
        incg3 = "";
        incg4 = "";
      });
    } else if (van.text == "" && tir.text != "") {
      van.text = "0";
      setState(() {
        incg1 = "";
        incg2 = "";
        incg3 = "Incognita";
        incg4 = "";
      });
    } else if (tir.text == "" && van.text != "") {
      tir.text = "0";
      setState(() {
        incg1 = "";
        incg2 = "";
        incg3 = "";
        incg4 = "Incognita";
      });
    } else if (van.text == "" && tir.text == "") {
      setState(() {
        incg1 = "";
        incg2 = "";
        incg3 = "Incognita";
        incg4 = "Incognita";
      });
    }
  }

  numeroDeFlujos() {
    int n = flujosDeCaja.length;
    return n;
  }

  nuevaOperacion() {
    setState(() {
      inversion.text = "";
      interes.text = "";
      tir.text = "";
      van.text = "";
      flujosDeCaja.clear();
      incg1 = "";
      incg2 = "";
    });
  }

  graficar() {
    for (int i = 0; i < flujosDeCaja.length; i++) {
      chartData!
          .add(_StepAreaData(DateTime(2021, i + 1, 1), flujosDeCaja[i], 0));
    }
  }

  @override
  void initState() {
    obtenerIteraciones();
    intrr = InternalRateReturnModel();
    super.initState();
    chartData = <_StepAreaData>[
      _StepAreaData(DateTime(2021, 1, 1), 0, 0),
      _StepAreaData(DateTime(2021, 2, 1), 0, 0),
      _StepAreaData(DateTime(2021, 3, 1), 0, 0),
      _StepAreaData(DateTime(2021, 4, 1), 0, 0),
      _StepAreaData(DateTime(2021, 5, 1), 0, 0),
      _StepAreaData(DateTime(2021, 6, 1), 0, 0),
      _StepAreaData(DateTime(2021, 7, 1), 0, 0),
      _StepAreaData(DateTime(2021, 8, 1), 0, 0),
      _StepAreaData(DateTime(2021, 9, 1), 0, 0),
      _StepAreaData(DateTime(2021, 10, 1), 0, 0),
      _StepAreaData(DateTime(2021, 11, 1), 0, 0),
      _StepAreaData(DateTime(2021, 12, 1), 0, 0),
    ];
  }

  @override
  void dispose() {
    chartData!.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height * 1.1,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/imgs/bg.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          padding: EdgeInsets.symmetric(horizontal: 20),
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  "Tasa Interna de Retorno",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                color: Colors.white,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.3,
                child: SfCartesianChart(
                  plotAreaBorderWidth: 0,
                  title: ChartTitle(text: 'Flujo de caja: '),
                  legend: Legend(isVisible: true),
                  primaryXAxis: DateTimeAxis(
                      majorGridLines: MajorGridLines(width: 0),
                      interval: 1,
                      edgeLabelPlacement: EdgeLabelPlacement.shift),
                  primaryYAxis: NumericAxis(
                    axisLine: AxisLine(width: 0),
                    majorTickLines: MajorTickLines(size: 0),
                  ),
                  series: <ChartSeries<_StepAreaData, DateTime>>[
                    StepAreaSeries<_StepAreaData, DateTime>(
                      dataSource: chartData!,
                      color: Color.fromRGBO(75, 135, 185, 0.6),
                      borderColor: Color.fromRGBO(75, 135, 185, 1),
                      borderWidth: 2,
                      name: 'Cuotas',
                      xValueMapper: (_StepAreaData sales, _) => sales.x,
                      yValueMapper: (_StepAreaData sales, _) => sales.high,
                    ),
                    StepAreaSeries<_StepAreaData, DateTime>(
                      dataSource: chartData!,
                      borderColor: Color.fromRGBO(192, 108, 132, 1),
                      color: Color.fromRGBO(192, 108, 132, 0.6),
                      borderWidth: 2,
                      name: 'Tiempo',
                      xValueMapper: (_StepAreaData sales, _) => sales.x,
                      yValueMapper: (_StepAreaData sales, _) => sales.low,
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                alignment: Alignment.centerLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Datos",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Iteraciones: $iteraciones',
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                  ],
                ),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      width: MediaQuery.of(context).size.width * 0.44,
                      child: TextField(
                        controller: inversion,
                        inputFormatters: [
                          CurrencyTextInputFormatter(
                              locale: 'es-Co', symbol: '', decimalDigits: 2),
                        ],
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          helperText: incg1,
                          helperStyle: TextStyle(
                            color: Colors.red.shade900,
                            fontWeight: FontWeight.bold,
                          ),
                          filled:
                              true, // Esta propiedad indica que el fondo debe estar lleno.
                          fillColor: Color.fromARGB(255, 248, 246, 247),

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
                          labelText: 'Inversion inicial',
                          labelStyle: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.44,
                      height: 54,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 248, 246, 247),
                        border: Border.all(
                          color: Colors.grey
                              .shade500, // Puedes cambiar el color del borde aquí
                          width: 1.0, // Puedes ajustar el grosor del borde aquí
                        ),
                        borderRadius: BorderRadius.circular(
                            8.0), // Puedes ajustar la esquina redondeada aquí
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
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
                              dropdownColor: Colors.white.withOpacity(0.9),
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
                                  indexSelected1 =
                                      Tiempos.indexOf(newValue.toString());
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      width: MediaQuery.of(context).size.width * 0.44,
                      child: TextField(
                        controller: interes,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          helperText: incg2,
                          helperStyle: TextStyle(
                            color: Colors.red.shade900,
                            fontWeight: FontWeight.bold,
                          ),
                          filled:
                              true, // Esta propiedad indica que el fondo debe estar lleno.
                          fillColor: Color.fromARGB(255, 248, 246, 247),

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
                          prefixIcon: Icon(Icons.percent_rounded),
                          labelText: 'Interes',
                          labelStyle: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.44,
                      height: 54,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 248, 246, 247),
                        border: Border.all(
                          color: Colors.grey
                              .shade500, // Puedes cambiar el color del borde aquí
                          width: 1.0, // Puedes ajustar el grosor del borde aquí
                        ),
                        borderRadius: BorderRadius.circular(
                            8.0), // Puedes ajustar la esquina redondeada aquí
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
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
                              dropdownColor: Colors.white.withOpacity(0.9),
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
                                  indexSelected2 =
                                      Tiempos.indexOf(newValue.toString());
                                  print(
                                      indexSelected2); // Actualiza el valor seleccionado
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
                margin: EdgeInsets.symmetric(vertical: 10),
                width: MediaQuery.of(context).size.width * 0.95,
                height: 220,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 5,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 2),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Flujo de caja',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.4,
                              height: 34,
                              child: TextField(
                                controller: flujo,
                                inputFormatters: [
                                  CurrencyTextInputFormatter(
                                      locale: 'es-Co',
                                      symbol: '',
                                      decimalDigits: 2),
                                ],
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  //helperText: incg1,
                                  helperStyle: TextStyle(
                                    color: Colors.red.shade900,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  filled: true,
                                  fillColor: Color.fromARGB(255, 248, 246, 247),
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
                                  labelText: 'Monto',
                                  labelStyle: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                //la primera posicion será el valor de inversion
                                agregarFlujo();
                              },
                              icon: Icon(Icons.add_box_outlined),
                              iconSize: 20,
                              color: Colors.black,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Expanded(
                            child: ListView.builder(
                                itemCount: flujosDeCaja.length,
                                itemBuilder: (context, index) {
                                  return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('${index + 1}',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black)),
                                      Text(
                                        FormatoMoneda2(
                                            flujosDeCaja[index].toInt()),
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          setState(() {
                                            flujosDeCaja.removeAt(index);
                                          });
                                        },
                                        icon: Icon(Icons.delete),
                                        iconSize: 20,
                                        color: Colors.black,
                                      ),
                                    ],
                                  );
                                })),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                child: Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.44,
                      child: TextField(
                        controller: van,
                        inputFormatters: [
                          CurrencyTextInputFormatter(
                              locale: 'es-Co', symbol: '', decimalDigits: 2),
                        ],
                        enabled: false,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          helperText: incg3,
                          helperStyle: TextStyle(
                            color: Colors.red.shade900,
                            fontWeight: FontWeight.bold,
                          ),
                          filled:
                              true, // Esta propiedad indica que el fondo debe estar lleno.
                          fillColor: Color.fromARGB(255, 248, 246, 247),
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
                          labelText: 'VAN (Valor Actual Neto)',
                          labelStyle: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.44,
                      child: TextField(
                        controller: tir,
                        inputFormatters: [
                          CurrencyTextInputFormatter(
                              locale: 'es-Co', symbol: '', decimalDigits: 2),
                        ],
                        enabled: false,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          helperText: incg4,
                          helperStyle: TextStyle(
                            color: Colors.red.shade900,
                            fontWeight: FontWeight.bold,
                          ),
                          filled:
                              true, // Esta propiedad indica que el fondo debe estar lleno.
                          fillColor: Color.fromARGB(255, 248, 246, 247),
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
                          labelText: 'TIR (Tasa Interna de Retorno)',
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
                margin: EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _isSwitched = !_isSwitched;
                            if (_isSwitched != false) {
                              calcularTasaInternaDeRetorno();
                              graficar();
                            } else {
                              nuevaOperacion();
                            }
                          });
                        },
                        child: _isSwitched != false
                            ? Text("Nuevo")
                            : Text("Calcular"),
                        style: ButtonStyle(
                          minimumSize:
                              MaterialStateProperty.all<Size>(Size(160, 40)),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.deepPurple),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
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
                              onPressed: () {},
                              child: Text("Recalcular"),
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
                          )
                        : Container(),
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

/// Private class for storing the step area chart data point.
class _StepAreaData {
  _StepAreaData(this.x, this.high, this.low);
  final DateTime x;
  final double high;
  final double low;
}
