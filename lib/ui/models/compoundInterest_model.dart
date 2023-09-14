import 'dart:math';

class CompoundInterestModel {
  late double p;
  late double f;
  late double n;
  late double i;
  late double k;
  late int nTiempo;
  late int iTiempo;
  late bool modo = true;
  List<List<double>> matrix = [
    [1, 30, 60, 90, 180, 360],
    [0.03, 1, 2, 3, 6, 12],
    [0.016, 0.5, 1, 1.5, 3, 6],
    [0.011, 0.33, 0.66, 1, 2, 4],
    [0.0055, 0.16, 0.33, 0.50, 1, 2],
    [0.0027, 0.083, 0.16, 0.25, 0, 5, 1],
  ];
  CompoundInterestModel(
      {this.p = 0,
      this.f = 0,
      this.n = 0,
      this.i = 0,
      this.k = 0,
      this.iTiempo = 1,
      this.nTiempo = 1});

  void todecimal(int num) {
    if (num == 0) {
      i = i / 100;
    } else {
      i = i * 100;
    }
  }

  void calcularI() {
    //formula para calcular el interes
    i = pow(f / p, 1 / n) - 1;
    todecimal(1);
    //print(i);
  }

  void calcularN() {
    todecimal(0);
    //formula para calcular el periodo
    n = log(f / p) / log(1 + i);
    todecimal(1);
  }

  void calcularF() {
    todecimal(0);
    //formula para calcular el monto final
    f = p * pow(1 + i, n);
    todecimal(1);
  }

  void calcularP() {
    todecimal(0);
    //formula para calcular el monto inicial
    p = f / pow(1 + i, n);
    todecimal(1);
  }

  void calcularK() {
    //formula para calcular el interes compuesto
    k = f - p;
  }

  void criterio() {
    //print(p);
    //print(f);
    //print(n);
    //print(i);
    if (iTiempo == nTiempo) {
      criterio2();
      calcularK();
    } else {
      conversion();
      criterio2();
      inversion();
      calcularK();
    }
  }

  void criterio2() {
    if ((p == 0) && (f != 0 && i != 0 && n != 0)) {
      calcularP();
    } else if ((f == 0) && (p != 0 && i != 0 && n != 0)) {
      calcularF();
    } else if ((i == 0) && (p != 0 && f != 0 && n != 0)) {
      calcularI();
    } else if ((n == 0) && (p != 0 && i != 0 && f != 0)) {
      calcularN();
    } else {
      //print("No se pueden tener 2 incognitas");
    }
  }

  void conversion() {
    i = i * matrix[iTiempo][nTiempo];
    //   2          1
  }

  void inversion() {
    i = i * matrix[nTiempo][iTiempo];
    //   2          1
  }
}
