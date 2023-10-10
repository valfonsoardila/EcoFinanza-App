import 'package:ecofinanza_app/ui/models/simpleInterest_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SimpleInterestView extends StatefulWidget {
  const SimpleInterestView({super.key});

  @override
  State<SimpleInterestView> createState() => _SimpleInterestViewState();
}

class _SimpleInterestViewState extends State<SimpleInterestView> {
  late List<dynamic> data;
  late TooltipBehavior _tooltip;
  List<Color> gradientColors = [Colors.green, Colors.yellow];
  //Instancia de la clase SimpleInterestModel
  late SimpleInterestModel ins;
  //Controladores de los campos de texto
  TextEditingController diasController = TextEditingController();
  TextEditingController mesesController = TextEditingController();
  TextEditingController anosController = TextEditingController();
  TextEditingController p = TextEditingController();
  TextEditingController f = TextEditingController();
  TextEditingController i = TextEditingController();
  TextEditingController n = TextEditingController();
  //Variables de control
  bool _isSwitched = false;
  String TiempoSeleccionadoDropd1 = 'Mensual';
  String TiempoSeleccionadoDropd2 = 'Mensual';
  int indexSelected1 = 1;
  int indexSelected2 = 1;
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
  int diasTotales = 0;
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

  calcularInteresSimple() {
    obtenerIncognita();
    ins.p = double.parse(p.text.replaceAll('.', '').replaceAll(',', '.'));
    ins.f = double.parse(f.text.replaceAll('.', '').replaceAll(',', '.'));
    ins.n = double.parse(n.text);
    ins.i = double.parse(i.text);
    ins.iTiempo = indexSelected2;
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

  obtenerIncognita() {
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
    diasTotales = 0;
    cuotas.clear();
    p.clear();
    f.clear();
    n.clear();
    i.clear();
    anosController.text = "0";
    mesesController.text = "0";
    diasController.text = "0";
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
    nCuota = ins.n.toString();
    interestValue = ins.f - ins.p;
    nInterest = interestValue / ins.n;
    for (int i = 0; i < ins.n; i++) {
      if (i == 0) {
        cuotas.add(ins.p * -1);
      } else {
        cuotas.add(ins.p + (nInterest * i));
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

  convertirADias() {
    var dias = int.parse(diasController.text);
    var meses = int.parse(mesesController.text);
    var anos = int.parse(anosController.text);
    diasTotales = (dias + (meses * 30) + (anos * 360));
    n.text = diasTotales.toString();
  }

  @override
  void initState() {
    super.initState();
    ins = SimpleInterestModel(p: 0, f: 0, i: 0, n: 0, iTiempo: 1, nTiempo: 1);
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
    diasController.text = "0";
    mesesController.text = "0";
    anosController.text = "0";
    super.initState();
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
                  "Interes Simple",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                  color: Colors.white,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: SfCartesianChart(
                      plotAreaBorderWidth: 0,
                      title: ChartTitle(text: 'Flujo de caja: $incg4'),
                      primaryXAxis: CategoryAxis(
                        labelPlacement: LabelPlacement.onTicks,
                        majorGridLines: const MajorGridLines(width: 0),
                        name: 'Meses',
                        title: AxisTitle(text: 'Meses'),
                        axisLine: const AxisLine(width: 0),
                        arrangeByIndex: true,
                        labelIntersectAction: AxisLabelIntersectAction.rotate45,
                      ),
                      primaryYAxis: NumericAxis(
                          name: 'Valor',
                          title: AxisTitle(text: 'Valor'),
                          minimum: min,
                          maximum: max,
                          interval: max / 10),
                      tooltipBehavior: _tooltip,
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
                          color: const Color.fromRGBO(255, 255, 255, 0.3),
                        )
                      ])),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.62,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: const Row(
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
                      padding: const EdgeInsets.symmetric(vertical: 5),
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
                                  borderSide: const BorderSide(
                                    color: Colors.black,
                                    width: 1.0,
                                  ),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                prefixIcon: const Icon(Icons.attach_money),
                                labelText: 'Valor Presente',
                                labelStyle: const TextStyle(
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
                                  borderSide: const BorderSide(
                                    color: Colors.black,
                                    width: 1.0,
                                  ),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                prefixIcon: const Icon(Icons.attach_money),
                                labelText: 'Valor Futuro',
                                labelStyle: const TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Container(
                    //   decoration: BoxDecoration(
                    //     color: Colors.grey[200],
                    //     border: Border.all(
                    //       color: Colors.grey.shade700,
                    //       width: 1.0,
                    //     ),
                    //     borderRadius: BorderRadius.circular(10),
                    //   ),
                    //   child: ListView.builder(
                    //       itemCount: 1,
                    //       shrinkWrap: true,
                    //       itemBuilder: (context, index) {
                    //         return Container(
                    //           height: _height,
                    //           child: ExpansionTile(
                    //             leading: Icon(Icons.calendar_today),
                    //             childrenPadding: EdgeInsets.all(10),
                    //             title: Text(
                    //                 incg3 != "Incognita"
                    //                     ? diasTotales > 0
                    //                         ? "Periodo: $diasTotales dias"
                    //                         : "Selecione el periodo"
                    //                     : "Tiempo: ${n.text}",
                    //                 style: TextStyle(color: Colors.black)),
                    //             subtitle: Text(
                    //               incg3,
                    //               style: TextStyle(
                    //                   color: incg3 != "Incognita"
                    //                       ? Colors.black
                    //                       : Colors.red.shade900),
                    //             ),
                    //             onExpansionChanged: (bool expanding) =>
                    //                 setState(() => _height = expanding
                    //                     ? 255
                    //                     : 66), // Changes the height of the container
                    //             children: [
                    //               TextFormField(
                    //                 controller: anosController,
                    //                 keyboardType: TextInputType.number,
                    //                 decoration: InputDecoration(
                    //                   border: OutlineInputBorder(
                    //                     borderRadius: BorderRadius.circular(10),
                    //                   ),
                    //                   labelText: 'Años',
                    //                   labelStyle: TextStyle(
                    //                     color: Colors.black,
                    //                   ),
                    //                 ),
                    //                 onChanged: (value) {
                    //                   setState(() {
                    //                     if (value != "") {
                    //                       convertirADias();
                    //                     }
                    //                   });
                    //                 },
                    //               ),
                    //               TextFormField(
                    //                 controller: mesesController,
                    //                 keyboardType: TextInputType.number,
                    //                 decoration: InputDecoration(
                    //                   border: OutlineInputBorder(
                    //                     borderRadius: BorderRadius.circular(10),
                    //                   ),
                    //                   labelText: 'Meses',
                    //                   labelStyle: TextStyle(
                    //                     color: Colors.black,
                    //                   ),
                    //                 ),
                    //                 onChanged: (value) {
                    //                   setState(() {
                    //                     if (value != "") {
                    //                       convertirADias();
                    //                     }
                    //                   });
                    //                 },
                    //               ),
                    //               TextFormField(
                    //                 controller: diasController,
                    //                 keyboardType: TextInputType.number,
                    //                 decoration: InputDecoration(
                    //                   border: OutlineInputBorder(
                    //                     borderRadius: BorderRadius.circular(10),
                    //                   ),
                    //                   labelText: 'Dias',
                    //                   labelStyle: TextStyle(
                    //                     color: Colors.black,
                    //                   ),
                    //                 ),
                    //                 onChanged: (value) {
                    //                   setState(() {
                    //                     if (value != "") {
                    //                       convertirADias();
                    //                     }
                    //                   });
                    //                 },
                    //               ),
                    //             ],
                    //           ),
                    //         );
                    //       }),
                    // ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 3),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.44,
                            padding: const EdgeInsets.only(top: 20),
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
                            height: 54,
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
                      padding: const EdgeInsets.symmetric(vertical: 3),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.44,
                            padding: const EdgeInsets.only(top: 20),
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
                                  ).colors[0],
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                ),
                                filled:
                                    true, // Esta propiedad indica que el fondo debe estar lleno.
                                fillColor: const Color.fromARGB(255, 248, 246,
                                    247), // Establece el color de fondo en blanco.
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
                                prefixIcon: const Icon(Icons.percent),
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
                              color: const Color.fromARGB(255, 248, 246,
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
                                const Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Icon(Icons.timer),
                                ),
                                Expanded(
                                  child: DropdownButton(
                                    hint: const Text(
                                      'Tiempo',
                                      style: TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                    dropdownColor:
                                        Colors.white.withOpacity(0.9),
                                    icon: const Icon(
                                      Icons.arrow_drop_down,
                                      color: Colors.black,
                                    ),
                                    iconSize: 36,
                                    isExpanded: true,
                                    underline: const SizedBox(),
                                    style: const TextStyle(
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
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  _isSwitched = !_isSwitched;
                                  if (_isSwitched != false) {
                                    calcularInteresSimple();
                                    calcularCuotas();
                                    graficar();
                                  } else {
                                    nuevo();
                                  }
                                });
                              },
                              child: _isSwitched != false
                                  ? const Text("Nuevo")
                                  : const Text("Calcular"),
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
                          ),
                          _isSwitched != false
                              ? Container(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      ins.n = 0.0;
                                      ins.p = 0.0;
                                      ins.f = 0.0;
                                      ins.i = 0.0;
                                      calcularInteresSimple();
                                      calcularCuotas();
                                      graficar();
                                    },
                                    child: const Text("Recalcular"),
                                    style: ButtonStyle(
                                      minimumSize:
                                          MaterialStateProperty.all<Size>(
                                              const Size(160, 40)),
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
