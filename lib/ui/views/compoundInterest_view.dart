import 'package:ecofinanza_app/ui/models/compoundInterest_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CompoundInterestView extends StatefulWidget {
  const CompoundInterestView({super.key});

  @override
  State<CompoundInterestView> createState() => _CompoundInterestViewState();
}

class _CompoundInterestViewState extends State<CompoundInterestView> {
  late List<dynamic> data;
  late TooltipBehavior _tooltip;
  List<Color> gradientColors = [Colors.blue, Colors.purple];
  //Instancia de la clase SimpleInterestModel
  late CompoundInterestModel inc;
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
  double min = 0;
  double max = 1000;
  List<double> cuotas = [];
  List<String> Meses = [
    'Ene',
    'Feb',
    'Mar',
    'Abr',
    'May',
    'Jun',
    'Jul',
    'Ago',
    'Sep',
    'Oct',
    'Nov',
    'Dic'
  ];
  List<String> dias = [
    'Lunes',
    'Martes',
    'Miercoles',
    'Jueves',
    'Viernes',
    'Sabado',
    'Domingo'
  ];
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

  calcularInteresCompuesto() {
    validar();
    inc.p = double.parse(p.text.replaceAll('.', '').replaceAll(',', '.'));
    inc.f = double.parse(f.text.replaceAll('.', '').replaceAll(',', '.'));
    inc.n = double.parse(n.text);
    inc.i = double.parse(i.text);
    inc.criterio();
    p.text = FormatoMoneda(inc.p);
    f.text = FormatoMoneda(inc.f);
    n.text = textoFormato(inc.n);
    i.text = textoFormato(inc.i);
    setState(() {
      double k = inc.f - inc.p;
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
    cuotas.clear();
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
    data = [
      _ChartData('Ene', 0),
      _ChartData('Feb', 0),
      _ChartData('Mar', 0),
      _ChartData('Abr', 0),
      _ChartData('May', 0),
      _ChartData('Jun', 0),
      _ChartData('Jul', 0),
      _ChartData('Ago', 0),
      _ChartData('Sep', 0),
      _ChartData('Oct', 0),
      _ChartData('Nov', 0),
      _ChartData('Dic', 0),
    ];
    _tooltip = TooltipBehavior(enable: true);
  }

  calcularCuotas() {
    cuotas.clear();
    nCuota = inc.n.toString();
    interestValue = inc.f - inc.p;
    nInterest = interestValue / inc.n;
    for (int i = 0; i < inc.n; i++) {
      if (i == 0) {
        cuotas.add(inc.p * -1);
      } else {
        cuotas.add(inc.p + (nInterest * i));
      }
    }
    min = cuotas[0];
    max = cuotas[cuotas.length - 1];
    print(cuotas);
  }

  graficar() {
    data.clear();
    for (int i = 0; i < cuotas.length; i++) {
      data.add(_ChartData(Meses[i], cuotas[i]));
    }
    print(data);
  }

  @override
  void initState() {
    super.initState();
    inc = CompoundInterestModel(p: 0, f: 0, i: 0, n: 0, iTiempo: 1, nTiempo: 1);
    data = [
      _ChartData('Ene', 0),
      _ChartData('Feb', 0),
      _ChartData('Mar', 0),
      _ChartData('Abr', 0),
      _ChartData('May', 0),
      _ChartData('Jun', 0),
      _ChartData('Jul', 0),
      _ChartData('Ago', 0),
      _ChartData('Sep', 0),
      _ChartData('Oct', 0),
      _ChartData('Nov', 0),
      _ChartData('Dic', 0),
    ];
    _tooltip = TooltipBehavior(enable: true);
    super.initState();
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
                  height: MediaQuery.of(context).size.height * 0.35,
                  child: SfCartesianChart(
                      plotAreaBorderWidth: 0,
                      title: ChartTitle(text: 'Flujo de caja: $incg4'),
                      legend: Legend(isVisible: false),
                      primaryXAxis: CategoryAxis(
                        labelPlacement: LabelPlacement.onTicks,
                        majorGridLines: MajorGridLines(width: 0),
                        name: 'Meses',
                        title: AxisTitle(text: 'Meses'),
                        axisLine: AxisLine(width: 0),
                        arrangeByIndex: true,
                        labelIntersectAction: AxisLabelIntersectAction.rotate45,
                      ),
                      primaryYAxis: NumericAxis(
                          name: 'Valor',
                          title: AxisTitle(text: 'Valor'),
                          minimum: min,
                          maximum: max,
                          interval: max / 10),
                      series: <ChartSeries<dynamic, String>>[
                        AreaSeries<dynamic, String>(
                          dataSource: data,
                          xValueMapper: (dynamic data, _) => data.x,
                          yValueMapper: (dynamic data, _) => data.y,
                          name: 'Gold',
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: gradientColors,
                          ),
                          color: Color.fromRGBO(255, 255, 255, 0.3),
                        )
                      ])),
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
                                  fontWeight: FontWeight.bold,
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
                                  fontWeight: FontWeight.bold,
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
                                helperStyle: TextStyle(
                                  color: Colors.red.shade900,
                                  fontWeight: FontWeight.bold,
                                ),
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
                                helperStyle: TextStyle(
                                  color: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: gradientColors,
                                  ).colors[1],
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                ),
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
                                    calcularInteresCompuesto();
                                    calcularCuotas();
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
                                      calcularInteresCompuesto();
                                      calcularCuotas();
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

class _ChartData {
  _ChartData(this.x, this.y);

  final String x;
  final double y;
}
