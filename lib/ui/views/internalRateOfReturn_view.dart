import 'package:ecofinanza_app/ui/models/internalRateReturn_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class InternalRateOfReturnView extends StatefulWidget {
  const InternalRateOfReturnView({super.key});

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
  TextEditingController inver = TextEditingController();
  TextEditingController inter = TextEditingController();
  TextEditingController flujo = TextEditingController();
  TextEditingController tir = TextEditingController();
  TextEditingController van = TextEditingController();
  late InternalRateReturnModel intrr;
  List<double> flujosDeCaja = [];
  int indexSelected1 = 0;
  String TiempoSeleccionadoDropd1 = 'Mensual';
  int indexSelected2 = 0;
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
        flujosDeCaja.add(
            double.parse(inver.text.replaceAll('.', '').replaceAll(',', '.')));
      }
      // Luego agrega el nuevo flujo ingresado en el campo de texto
      flujosDeCaja.add(
          double.parse(flujo.text.replaceAll('.', '').replaceAll(',', '.')));
      flujo.text = "";
    });
  }

  calcularTasaInternaDeRetorno() {
    obtenerIncognita();
    intrr.inver =
        double.parse(inver.text.replaceAll('.', '').replaceAll(',', '.'));
    intrr.inter =
        double.parse(inter.text.replaceAll('.', '').replaceAll(',', '.'));
    intrr.iTiempo = indexSelected1;
    intrr.iTiempo = indexSelected2;
    intrr.flujos = flujosDeCaja;
    intrr.criterio();
    inver.text = FormatoMoneda(intrr.inver);
    tir.text = FormatoMoneda(intrr.tir);
    van.text = FormatoMoneda(intrr.van);
  }

  obtenerIncognita() {
    if (inver.text == "") {
      inver.text = "0";
      setState(() {
        incg1 = "Incognita";
        incg2 = "";
        incg3 = "";
        incg4 = "";
      });
    } else if (inter.text == "") {
      inter.text = "0";
      setState(() {
        incg1 = "";
        incg2 = "Incognita";
        incg3 = "";
        incg4 = "";
      });
    } else if (van.text == "") {
      van.text = "0";
      setState(() {
        incg1 = "";
        incg2 = "";
        incg3 = "Incognita";
        incg4 = "";
      });
    } else if (tir.text == "") {
      tir.text = "0";
      setState(() {
        incg1 = "";
        incg2 = "";
        incg3 = "";
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
      inver.text = "";
      inter.text = "";
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
    intrr = InternalRateReturnModel();
    super.initState();
    //chartData  tendra valores iniciales en 0 para que no se vea vacio
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
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/imgs/bg.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: const Text(
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
                      majorGridLines: const MajorGridLines(width: 0),
                      interval: 1,
                      edgeLabelPlacement: EdgeLabelPlacement.shift),
                  primaryYAxis: NumericAxis(
                    axisLine: const AxisLine(width: 0),
                    majorTickLines: const MajorTickLines(size: 0),
                  ),
                  series: <ChartSeries<_StepAreaData, DateTime>>[
                    StepAreaSeries<_StepAreaData, DateTime>(
                      dataSource: chartData!,
                      color: const Color.fromRGBO(75, 135, 185, 0.6),
                      borderColor: const Color.fromRGBO(75, 135, 185, 1),
                      borderWidth: 2,
                      name: 'High',
                      xValueMapper: (_StepAreaData sales, _) => sales.x,
                      yValueMapper: (_StepAreaData sales, _) => sales.high,
                    ),
                    StepAreaSeries<_StepAreaData, DateTime>(
                      dataSource: chartData!,
                      borderColor: const Color.fromRGBO(192, 108, 132, 1),
                      color: const Color.fromRGBO(192, 108, 132, 0.6),
                      borderWidth: 2,
                      name: 'Low',
                      xValueMapper: (_StepAreaData sales, _) => sales.x,
                      yValueMapper: (_StepAreaData sales, _) => sales.low,
                    )
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                alignment: Alignment.centerLeft,
                child: const Text(
                  "Datos",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      width: MediaQuery.of(context).size.width * 0.44,
                      child: TextField(
                        controller: inver,
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
                            borderSide: const BorderSide(
                              color: Colors.black,
                              width: 1.0,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          prefixIcon: const Icon(Icons.attach_money),
                          labelText: 'Inversion inicial',
                          labelStyle: const TextStyle(
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
                      margin: const EdgeInsets.only(top: 20),
                      width: MediaQuery.of(context).size.width * 0.44,
                      child: TextField(
                        controller: inter,
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
                            borderSide: const BorderSide(
                              color: Colors.black,
                              width: 1.0,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          prefixIcon: const Icon(Icons.percent_rounded),
                          labelText: 'Interes',
                          labelStyle: const TextStyle(
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
                margin: const EdgeInsets.symmetric(vertical: 10),
                width: MediaQuery.of(context).size.width * 0.95,
                height: 220,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 5,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 2),
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
                                    borderSide: const BorderSide(
                                      color: Colors.black,
                                      width: 1.0,
                                    ),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  prefixIcon: const Icon(Icons.attach_money),
                                  labelText: 'Monto',
                                  labelStyle: const TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                //la primera posicion será el valor de inver
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
                          borderSide: const BorderSide(
                            color: Colors.black,
                            width: 1.0,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        prefixIcon: const Icon(Icons.attach_money),
                        labelText: 'VAN (Valor Actual Neto)',
                        labelStyle: const TextStyle(
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
                          borderSide: const BorderSide(
                            color: Colors.black,
                            width: 1.0,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        prefixIcon: const Icon(Icons.attach_money),
                        labelText: 'TIR (Tasa Interna de Retorno)',
                        labelStyle: const TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              )),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
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
                            ? const Text("Nuevo")
                            : const Text("Calcular"),
                        style: ButtonStyle(
                          minimumSize: MaterialStateProperty.all<Size>(
                              const Size(160, 40)),
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
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: ElevatedButton(
                              onPressed: () {},
                              child: const Text("Recalcular"),
                              style: ButtonStyle(
                                minimumSize: MaterialStateProperty.all<Size>(
                                    const Size(160, 40)),
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
