import 'dart:math';

class InternalRateReturnModel {
  late double inversion;
  late double interes;
  late double tir;
  late double van;
  late int nTiempo;
  late int iteraciones;
  late List<double> flujos;
  late int iTiempo;

  InternalRateReturnModel(
      {this.inversion = 0,
      this.interes = 0,
      this.iteraciones = 1000,
      this.iTiempo = 0,
      this.nTiempo = 0,
      this.flujos = const [],
      this.tir = 0,
      this.van = 0});

  void todecimal(int num) {
    if (num == 0) {
      interes = interes / 100;
    } else {
      interes = interes * 100;
    }
  }

  double calcularTIRNewtonRaphson() {
    double left = 0.1;
    double right = 1.0;
    double tolerance = 1e-9;
    double tir;

    for (int i = 0; i < iteraciones; i++) {
      tir = (left + right) / 2;
      double npv = 0;
      for (int j = 0; j < flujos.length; j++) {
        npv += flujos[j] / pow(1 + tir, j + 1);
      }
      if (npv.abs() < tolerance) {
        return tir * 100;
      }
      if (npv > 0) {
        left = tir;
      } else {
        right = tir;
      }
    }
    return double.infinity;
  }

  double calcularVAN() {
    double van = 0;
    for (int i = 0; i < flujos.length; i++) {
      van += flujos[i] / pow(1 + interes, i);
    }
    return van;
  }

  void calcularTir() {
    todecimal(0);
    tir = calcularTIRNewtonRaphson();
    todecimal(1);
  }

  void calcularVan() {
    todecimal(0);
    van = calcularVAN();
    todecimal(1);
  }

  void criterio() {
    if (iTiempo == nTiempo) {
      criterioIncognita();
    } else {
      conversion();
      criterioIncognita();
    }
  }

  void criterioIncognita() {
    if (flujos != [] && inversion != 0 && interes == 0) {
      calcularTir();
    } else if (flujos != [] && inversion != 0 && interes != 0) {
      calcularTir();
      calcularVan();
    }
  }

  void conversion() {
    if (interes == 0) {
      interes = interes / 100;
    } else {
      interes = interes * 100;
    }
  }
}
