import 'package:ecofinanza_app/ui/models/ascendingGradient_model.dart';
import 'package:ecofinanza_app/ui/models/descendingGradient_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ArithmeticGradientView extends StatefulWidget {
  ArithmeticGradientView({super.key});

  @override
  State<ArithmeticGradientView> createState() => _ArithmeticGradientViewState();
}

class _ArithmeticGradientViewState extends State<ArithmeticGradientView> {
  late TextEditingController vpf;
  late TextEditingController A;
  late TextEditingController G;
  late TextEditingController I;
  late TextEditingController N;
  late AscendingGradientModel G_ASC;
  late DescendingGradientModel G_DES;
  List<_StepAreaData>? chartData;
  List<double> cuotas = [];
  List<Color> gradientColors = [Colors.green, Colors.yellow];
  String gradienteSeleccionado = 'Ascendente';
  String valorSeleccionado = 'Valor presente';
  String tiempoSeleccionado1 = 'Mensual';
  String tiempoSeleccionado2 = 'Mensual';
  int indexGradiente = 1;
  int indexValor = 1;
  int indexTiempo = 1;
  String incg1 = "";
  String incg2 = "";
  String incg3 = "";
  String incg4 = "";
  String incg5 = "";
  bool _isSwitched = false;
  String nCuota = "";
  double min = 0;
  double max = 1000;

  var TipoGradientes = <String>[
    'Ascendente',
    'Descendente',
  ];

  var TipoValor = <String>[
    'Valor presente',
    'Valor Futuro',
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

  calcularGradiente() {
    if (gradienteSeleccionado == 'Ascendente') {
      //print("calcula simple");
      if (valorSeleccionado == 'Valor presente') {
        print("calcula presente");
        G_ASC.f = 1;
        G_ASC.p = 0;
        calcularGradienteAsc();
        //datos.listData(G_ASC.cuotas);
      } else {
        print("calcula futuro");
        G_ASC.p = 1;
        G_ASC.f = 0;
        calcularGradienteAsc();
        //datos.listData(G_ASC.cuotas);
      }
    } else {
      //print("calcula compuesto");
      if (valorSeleccionado == 'Valor presente') {
        G_DES.f = 1;
        G_DES.p = 0;
        calcularGradienteDes();
        //datos.listData(G_DES.cuotas2);
      } else {
        G_DES.f = 0;
        G_DES.p = 1;
        calcularGradienteDes();
        //datos.listData(G_DES.cuotas2);
      }
    }
  }

  calcularCuotas() {}

  calcularGradienteAsc() {
    validar();
    if (vpf.text != "" && vpf.text != "0") {
      print("No esta vacio");
      print(vpf.text);
      G_ASC.p = double.parse(vpf.text.replaceAll('.', '').replaceAll(',', '.'));
    }
    G_ASC.g = double.parse(G.text.replaceAll('.', '').replaceAll(',', '.'));
    G_ASC.a = double.parse(A.text.replaceAll('.', '').replaceAll(',', '.'));
    G_ASC.n = double.parse(N.text);
    G_ASC.i = double.parse(I.text);
    G_ASC.criterio();
    G.text = FormatoMoneda(G_ASC.g);
    A.text = FormatoMoneda(G_ASC.a);
    N.text = textoFormato(G_ASC.n);
    I.text = textoFormato(G_ASC.i);
    if (valorSeleccionado == "Valor presente") {
      vpf.text = FormatoMoneda(G_ASC.p);
    } else {
      vpf.text = FormatoMoneda(G_ASC.f);
    }
  }

  calcularGradienteDes() {
    validar();
    if (vpf.text != "" && valorSeleccionado == "Valor presente") {
      G_ASC.p = double.parse(vpf.text.replaceAll('.', '').replaceAll(',', '.'));
    } else if (vpf.text != "" && valorSeleccionado == "Valor futuro") {
      G_ASC.f = double.parse(vpf.text.replaceAll('.', '').replaceAll(',', '.'));
    }
    G_DES.g = double.parse(G.text.replaceAll('.', '').replaceAll(',', '.'));
    G_DES.a = double.parse(A.text.replaceAll('.', '').replaceAll(',', '.'));
    G_DES.n = double.parse(N.text);
    G_DES.i = double.parse(I.text);
    G_DES.criterio();
    G.text = FormatoMoneda(G_DES.g);
    A.text = FormatoMoneda(G_DES.a);
    N.text = textoFormato(G_DES.n);
    I.text = textoFormato(G_DES.i);
    if (valorSeleccionado == "Valor presente") {
      vpf.text = FormatoMoneda(G_DES.p);
    } else {
      vpf.text = FormatoMoneda(G_DES.f);
    }
  }

  validar() {
    if (vpf.text == "") {
      vpf.text = "0";
      setState(() {
        incg1 = "Incognita";
      });
    } else if (G.text == "") {
      G.text = "0";
      setState(() {
        incg2 = "Incognita";
      });
    } else if (N.text == "") {
      N.text = "0";
      setState(() {
        incg3 = "Incognita";
      });
    } else if (I.text == "") {
      I.text = "0";
      setState(() {
        incg4 = "Incognita";
      });
    } else if (A.text == "") {
      A.text = "0";
      setState(() {
        incg5 = "Incognita";
      });
    } else {
      //alerta
    }
  }

  obtenerIncognita() {
    if (A.text == "") {
      A.text = "0";
      setState(() {
        incg1 = "Incognita";
        incg2 = "";
        incg3 = "";
        incg4 = "";
      });
    } else if (G.text == "") {
      G.text = "0";
      setState(() {
        incg1 = "";
        incg2 = "Incognita";
        incg3 = "";
        incg4 = "";
      });
    } else if (I.text == "") {
      I.text = "0";
      setState(() {
        incg3 = "Incognita";
        incg2 = "";
        incg1 = "";
        incg4 = "";
      });
    } else if (N.text == "") {
      N.text = "0";
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
    //datos.dataCuotas.clear();
    vpf.clear();
    A.clear();
    G.clear();
    I.clear();
    N.clear();
    tiempoSeleccionado1 = "Mensual";
    tiempoSeleccionado2 = "Mensual";
    incg1 = "";
    incg2 = "";
    incg3 = "";
    incg4 = "";
    incg5 = "";
    G_ASC.p = 0;
    G_ASC.f = 0;
    G_DES.p = 0;
    G_DES.f = 0;
  }

  @override
  void initState() {
    vpf = TextEditingController();
    A = TextEditingController();
    G = TextEditingController();
    I = TextEditingController();
    N = TextEditingController();
    G_DES = DescendingGradientModel();
    G_ASC = AscendingGradientModel();
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
                  "Gradiente Aritmético",
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
                width: MediaQuery.of(context).size.width * 0.95,
                margin: EdgeInsets.symmetric(vertical: 10),
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
                      child: Icon(Icons.timeline),
                    ),
                    Expanded(
                      child: DropdownButton(
                        hint: Text(
                          'Tipo de gradiente',
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
                        value: gradienteSeleccionado,
                        onChanged: (newValue) {
                          setState(() {
                            gradienteSeleccionado = newValue.toString();
                            indexGradiente =
                                TipoGradientes.indexOf(newValue.toString());
                            print(
                                indexGradiente); // Actualiza el valor seleccionado
                          });
                        },
                        items: TipoGradientes.map((valueItem) {
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
                padding: EdgeInsets.symmetric(vertical: 5),
                alignment: Alignment.centerLeft,
                child: Text(
                  "Datos",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.45,
                      height: 45,
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
                                'Valor presente',
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
                              value: valorSeleccionado,
                              onChanged: (newValue) {
                                setState(() {
                                  valorSeleccionado = newValue.toString();
                                  indexValor =
                                      TipoValor.indexOf(newValue.toString());
                                  print(
                                      indexValor); // Actualiza el valor seleccionado
                                });
                              },
                              items: TipoValor.map((valueItem) {
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
                      margin: EdgeInsets.only(top: 20),
                      width: MediaQuery.of(context).size.width * 0.45,
                      height: 70,
                      child: TextField(
                        controller: vpf,
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
                          labelText: valorSeleccionado,
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      width: MediaQuery.of(context).size.width * 0.45,
                      height: 70,
                      child: TextField(
                        controller: A,
                        inputFormatters: [
                          CurrencyTextInputFormatter(
                              locale: 'es-Co', symbol: '', decimalDigits: 2),
                        ],
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          helperText: incg5,
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
                          labelText: 'Cuota inicial',
                          labelStyle: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      width: MediaQuery.of(context).size.width * 0.45,
                      height: 70,
                      child: TextField(
                        controller: G,
                        inputFormatters: [
                          CurrencyTextInputFormatter(
                              locale: 'es-Co', symbol: '', decimalDigits: 2),
                        ],
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
                          prefixIcon: Icon(Icons.attach_money),
                          labelText: 'Gradiente',
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      width: MediaQuery.of(context).size.width * 0.45,
                      height: 70,
                      child: TextField(
                        controller: I,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          helperText: "",
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
                          prefixIcon: Icon(Icons.percent),
                          labelText: 'Interes',
                          labelStyle: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.45,
                      height: 42,
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
                              value: tiempoSeleccionado1,
                              onChanged: (newValue) {
                                setState(() {
                                  tiempoSeleccionado1 = newValue.toString();
                                  indexTiempo =
                                      Tiempos.indexOf(newValue.toString());
                                  print(
                                      indexTiempo); // Actualiza el valor seleccionado
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
                      width: MediaQuery.of(context).size.width * 0.45,
                      height: 70,
                      child: TextField(
                        controller: N,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          helperText: "",
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
                          prefixIcon: Icon(Icons.calendar_today),
                          labelText: 'Periodo',
                          labelStyle: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.45,
                      height: 42,
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
                              value: tiempoSeleccionado2,
                              onChanged: (newValue) {
                                setState(() {
                                  tiempoSeleccionado2 = newValue.toString();
                                  indexTiempo =
                                      Tiempos.indexOf(newValue.toString());
                                  print(
                                      indexTiempo); // Actualiza el valor seleccionado
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
                              calcularGradiente();
                            } else {
                              nuevo();
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
