import 'dart:math';

class InternalRateReturnModel {
  late double inver;
  late double inter;
  late double tir;
  late double van;
  late int nTiempo;
  late List<double> flujos;
  late int iTiempo;

  InternalRateReturnModel(
      {this.inver = 0,
      this.inter = 0,
      this.iTiempo = 0,
      this.nTiempo = 0,
      this.flujos = const [],
      this.tir = 0,
      this.van = 0});

  void todecimal(int num) {
    if (num == 0) {
      inter = inter / 100;
    } else {
      inter = inter * 100;
    }
  }

  double calcularTIRNewtonRaphson() {
    double left = 0.1; // Límite izquierdo
    double right = 1.0; // Límite derecho
    double tolerance = 1e-9; // Tolerancia para la precisión
    double tir;

    for (int i = 0; i < 1000; i++) {
      // Itera un máximo de 1000 veces
      tir = (left + right) / 2; // Toma el punto medio
      double npv = 0;

      for (int j = 0; j < flujos.length; j++) {
        npv += flujos[j] / pow(1 + tir, j + 1);
      }

      if (npv.abs() < tolerance) {
        print("Tir: " + tir.toString());
        return tir * 100; // Devuelve la TIR en porcentaje
      }

      if (npv > 0) {
        left = tir;
      } else {
        right = tir;
      }
    }
    print("No converge");
    return double.infinity; // Si no converge, devuelve infinito
  }

  double calcularVAN() {
    double van = 0;

    for (int i = 0; i < flujos.length; i++) {
      van += flujos[i] /
          pow(1 + inter / 100, i + 1); // Convierte la tasa a porcentaje
    }
    print("VAN: " + van.toString());
    return van;
  }

  void calcularTir() {
    todecimal(0);
    tir = calcularTIRNewtonRaphson();
  }

  void calcularVan() {
    todecimal(0);
    van = calcularVAN();
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
    if ((tir == 0) && (flujos != [] && inver != 0)) {
      calcularTir();
    } else if ((van == 0) && (flujos != [] && inver != 0 && inter != 0)) {
      calcularVan();
    }
  }

  void conversion() {
    if (inter == 0) {
      inter = 0.1;
    } else {
      inter = inter / 100;
    }
  }
}
