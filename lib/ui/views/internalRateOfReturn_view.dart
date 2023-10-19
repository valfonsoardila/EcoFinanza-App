import 'package:flutter/material.dart';
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

  @override
  void initState() {
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
