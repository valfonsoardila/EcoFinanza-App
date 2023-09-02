import 'package:ecofinanza_app/ui/models/simpleInterest_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:convert';

class SimpleInterestView extends StatefulWidget {
  const SimpleInterestView({super.key});

  @override
  State<SimpleInterestView> createState() => _SimpleInterestViewState();
}

class _SimpleInterestViewState extends State<SimpleInterestView> {
  List<Color> gradientColors = [
    Color(0xff23b6e6),
    Color(0xff02d39a),
  ];
  //Instancia de la clase SimpleInterestModel
  late SimpleInterestModel ins;
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

  calcularInteresSimple() {
    validar();
    ins.p = double.parse(p.text.replaceAll('.', '').replaceAll(',', '.'));
    ins.f = double.parse(f.text.replaceAll('.', '').replaceAll(',', '.'));
    ins.n = double.parse(n.text);
    ins.i = double.parse(i.text);
    ins.criterio();
    p.text = FormatoMoneda(ins.p);
    f.text = FormatoMoneda(ins.f);
    n.text = textoFormato(ins.n);
    i.text = textoFormato(ins.i);
    setState(() {
      double k = ins.f - ins.p;
      incg4 = FormatoMoneda(k);
    });
  }

  validar() {
    if (p.text == "") {
      p.text = "0";
      setState(() {
        incg1 = "Incognita";
        incg2 = "";
        incg3 = "";
        incg4 = "";
      });
    } else if (f.text == "") {
      f.text = "0";
      setState(() {
        incg1 = "";
        incg2 = "Incognita";
        incg3 = "";
        incg4 = "";
      });
    } else if (n.text == "") {
      n.text = "0";
      setState(() {
        incg3 = "Incognita";
        incg2 = "";
        incg1 = "";
        incg4 = "";
      });
    } else if (i.text == "") {
      i.text = "0";
      setState(() {
        incg4 = "Incognita";
        incg2 = "";
        incg3 = "";
        incg1 = "";
      });
    } else {
      //alerta
    }
  }

  nuevo() {
    p.clear();
    f.clear();
    n.clear();
    i.clear();
    TiempoSeleccionadoDropd1 = "Diario";
    TiempoSeleccionadoDropd2 = "Diario";
    incg1 = "";
    incg2 = "";
    incg3 = "";
    incg4 = "";
  }

  graficar() {
    nCuota = ins.n.toString();
    interestValue = ins.f - ins.p;
    nInterest = interestValue / ins.n;
    List<double> cuotas = [];
    for (int i = 0; i < ins.n; i++) {
      if (i == 0) {
        cuotas.add(ins.p * -1);
      } else {
        cuotas.add(ins.p + (nInterest * i));
      }
    }
    print(cuotas);
  }

  @override
  void initState() {
    super.initState();
    ins = SimpleInterestModel(p: 0, f: 0, i: 0, n: 0, iTiempo: 1, nTiempo: 1);
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
                  "Interes Simple",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                color: Colors.white,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.3,
                child: Stack(children: [
                  LineChart(
                    LineChartData(
                      // read about it in the LineChartData section
                      backgroundColor: Colors.transparent,
                      showingTooltipIndicators: [],
                      clipData: FlClipData.all(),
                      borderData: FlBorderData(
                          show: true,
                          border: Border(
                              bottom: BorderSide(color: Colors.black),
                              left: BorderSide(color: Colors.black),
                              right: BorderSide(color: Colors.transparent),
                              top: BorderSide(color: Colors.transparent))),
                      baselineX: 0,
                      baselineY: 0,
                      maxX: 12,
                      maxY: 12,
                      minX: 0,
                      minY: 0,
                      lineBarsData: [
                        LineChartBarData(
                          show: true,
                          shadow: Shadow(blurRadius: 2, color: Colors.purple),
                          spots: [
                            FlSpot(0, 0),
                            FlSpot(5, 5),
                            FlSpot(7, 6),
                            FlSpot(8, 4),
                          ],
                          isCurved: true,
                          curveSmoothness: 0.5,
                          barWidth: 3,
                          showingIndicators: [0, 1, 2, 3],
                          dashArray: [2, 2],
                          aboveBarData: BarAreaData(
                            show: true,
                            cutOffY: 0,
                            applyCutOffY: true,
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: gradientColors
                                  .map((color) => color.withOpacity(0.3))
                                  .toList(),
                              transform: GradientRotation(90),
                            ),
                            spotsLine: BarAreaSpotsLine(
                              show: true,
                              flLineStyle: FlLine(
                                color: Colors.purple,
                                strokeWidth: 1,
                              ),
                              checkToShowSpotLine: (spot) {
                                if (spot.x == 0 ||
                                    spot.x == 5 ||
                                    spot.x == 7 ||
                                    spot.x == 8) {
                                  return true;
                                } else {
                                  return false;
                                }
                              },
                            ),
                          ),
                          belowBarData: BarAreaData(
                            show: true,
                            cutOffY: 0,
                            applyCutOffY: true,
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: gradientColors
                                  .map((color) => color.withOpacity(0.3))
                                  .toList(),
                              transform: GradientRotation(90),
                            ),
                            spotsLine: BarAreaSpotsLine(
                              show: true,
                              flLineStyle: FlLine(
                                color: Colors.purple,
                                strokeWidth: 1,
                              ),
                              checkToShowSpotLine: (spot) {
                                if (spot.x == 0 ||
                                    spot.x == 5 ||
                                    spot.x == 7 ||
                                    spot.x == 8) {
                                  return true;
                                } else {
                                  return false;
                                }
                              },
                            ),
                          ),
                          dotData: FlDotData(
                            show: true,
                            getDotPainter: (spot, percent, barData, index) {
                              return FlDotCirclePainter(
                                radius: 5,
                                color: Colors.purple,
                                strokeWidth: 1,
                                strokeColor: Colors.purple,
                              );
                            },
                          ),
                          lineChartStepData: LineChartStepData(
                            stepDirection: 12,
                          ),
                          preventCurveOverShooting: true,
                          preventCurveOvershootingThreshold: 1,
                        )
                      ],
                      lineTouchData: LineTouchData(
                        enabled: true,
                        touchTooltipData: LineTouchTooltipData(
                          tooltipBgColor: Colors.purple,
                          getTooltipItems: (touchedSpots) {
                            return touchedSpots.map((e) {
                              return LineTooltipItem(
                                e.y.toString(),
                                TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              );
                            }).toList();
                          },
                        ),
                        longPressDuration: Duration(
                            milliseconds:
                                500), //tiempo que se mantiene presionado para mostrar el tooltip
                        getTouchedSpotIndicator:
                            (LineChartBarData barData, List<int> spotIndexes) {
                          return spotIndexes.map((spotIndex) {
                            final FlSpot spot = barData.spots[spotIndex];
                            if (spot.x == 0 ||
                                spot.x == 5 ||
                                spot.x == 7 ||
                                spot.x == 8) {
                              return TouchedSpotIndicatorData(
                                FlLine(
                                  color: Colors.purple,
                                  strokeWidth: 2,
                                ),
                                FlDotData(
                                  show: true,
                                  getDotPainter:
                                      (spot, percent, barData, index) {
                                    return FlDotCirclePainter(
                                      radius: 5,
                                      color: Colors.purple,
                                      strokeWidth: 1,
                                      strokeColor: Colors.purple,
                                    );
                                  },
                                ),
                              );
                            } else {
                              return TouchedSpotIndicatorData(
                                FlLine(
                                  color: Colors.transparent,
                                ),
                                FlDotData(
                                  show: false,
                                ),
                              );
                            }
                          }).toList();
                        },
                      ),
                      gridData: FlGridData(
                        show: false,
                      ),
                      titlesData: FlTitlesData(
                        show: true,
                        topTitles: AxisTitles(
                          axisNameSize: 22,
                          axisNameWidget: Container(
                            child: Text(
                              "Flujo de caja",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                          sideTitles: SideTitles(
                            showTitles: false,
                            interval: 1,
                          ),
                        ),
                        bottomTitles: AxisTitles(
                          axisNameSize: 18,
                          axisNameWidget: Container(
                            child: Text(
                              "Meses del año",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                          drawBelowEverything: true,
                          sideTitles: SideTitles(
                            reservedSize: 30,
                            interval: 1,
                            showTitles: true,
                            getTitlesWidget: (value, index) {
                              // Aquí agregamos un segundo argumento 'meta'
                              switch (value.toInt()) {
                                case 0:
                                  return Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 7, vertical: 5),
                                    child: Text(
                                      "Ene",
                                    ),
                                  );
                                case 1:
                                  return Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 7, vertical: 5),
                                    child: Text(
                                      "Feb",
                                    ),
                                  );
                                case 2:
                                  return Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 7, vertical: 5),
                                    child: Text(
                                      "Mar",
                                    ),
                                  );
                                case 3:
                                  return Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 7, vertical: 5),
                                    child: Text(
                                      "Abr",
                                    ),
                                  );
                                case 4:
                                  return Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 7, vertical: 5),
                                    child: Text(
                                      "May",
                                    ),
                                  );
                                case 5:
                                  return Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 7, vertical: 5),
                                    child: Text(
                                      "Jun",
                                    ),
                                  );
                                case 6:
                                  return Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 7, vertical: 5),
                                    child: Text(
                                      "Jul",
                                    ),
                                  );
                                case 7:
                                  return Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 7, vertical: 5),
                                    child: Text(
                                      "Ago",
                                    ),
                                  );
                                case 8:
                                  return Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 7, vertical: 5),
                                    child: Text(
                                      "Sep",
                                    ),
                                  );
                                case 9:
                                  return Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 7, vertical: 5),
                                    child: Text(
                                      "Oct",
                                    ),
                                  );
                                case 10:
                                  return Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 7, vertical: 5),
                                    child: Text(
                                      "Nov",
                                    ),
                                  );
                                case 11:
                                  return Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 7, vertical: 5),
                                    child: Text(
                                      "Dic",
                                    ),
                                  );
                                default:
                                  return Text(
                                      ""); // Devolvemos un widget vacío en caso de que no haya una coincidencia
                              }
                            },
                          ),
                        ),
                        leftTitles: AxisTitles(
                          axisNameSize: 18,
                          axisNameWidget: Container(
                            child: Text(
                              "Ingresos",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                          drawBelowEverything: true,
                          sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 32,
                              interval: 1,
                              getTitlesWidget: (value, meta) {
                                switch (value.toInt()) {
                                  case 0:
                                    return Text("0.5m");
                                  case 1:
                                    return Text("1m");
                                  case 2:
                                    return Text("1.5m");
                                  case 3:
                                    return Text("2m");
                                  case 4:
                                    return Text("2.5m");
                                  case 5:
                                    return Text("3m");
                                  case 6:
                                    return Text("3.5m");
                                  case 7:
                                    return Text("4m");
                                  case 8:
                                    return Text("4.5m");
                                  case 9:
                                    return Text("5m");
                                  case 10:
                                    return Text("5.5m");
                                  case 11:
                                    return Text("6m");
                                  default:
                                    return Text("");
                                }
                              } // Aquí agregamos un segundo argumento 'meta'
                              ),
                        ),
                        rightTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: false,
                            interval: 1,
                          ),
                        ),
                      ),
                    ),
                    duration: Duration(milliseconds: 150), // Optional
                    curve: Curves.linear, // Optional
                  )
                ]),
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
                                setState(() {
                                  _isSwitched = !_isSwitched;
                                  if (_isSwitched != false) {
                                    calcularInteresSimple();
                                    graficar();
                                  } else {
                                    nuevo();
                                  }
                                });
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
                                      calcularInteresSimple();
                                      graficar();
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
