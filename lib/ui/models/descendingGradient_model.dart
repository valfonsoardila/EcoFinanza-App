import 'dart:math';

class DescendingGradientModel {
  late double p;
  late double f;
  late double n;
  late double i;
  late double a;
  late double g;
  List<double> cuotas2 = [];
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
  DescendingGradientModel(
      {this.p = 0,
      this.f = 0,
      this.n = 0,
      this.i = 0,
      this.a = 0,
      this.g = 0,
      this.iTiempo = 1,
      this.nTiempo = 1});

  void todecimal(int num) {
    if (num == 0) {
      i = i / 100;
    } else {
      i = i * 100;
    }
  }

  void calcularF() {
    todecimal(0);
    num k = pow((1 + i), n);
    f = a * ((k - 1) / i) - (g / i) * (((k - 1) / i) - n);
    todecimal(1);
  }

  void calcularP() {
    // print(p);
    // print(n);
    // print(i);
    // print(g);
    // print(a);
    todecimal(0);
    num k = pow((1 + i), n);
    p = a * ((k - 1) / (i * k)) - (g / i) * (((k - 1) / (i * k)) - (n / k));
    todecimal(1);
  }

  void calcularPa() {
    todecimal(0);
    num x = pow((1 + i), n);
    num h = i * x;
    num k = x - 1;
    num z = k / h;
    a = (p + ((g / i) * (z - (n / x)))) / z;
    todecimal(1);
  }

  void calcularPg() {
    todecimal(0);
    num x = pow((1 + i), n);
    num h = i * x;
    num k = x - 1;
    num z = k / h;
    g = i * ((p - (a * z)) / (z - (n / x)));
    todecimal(1);
  }

  void calcularFa() {
    todecimal(0);
    num x = pow((1 + i), n);
    num k = x - 1;
    num z = k / i;
    a = (f + ((g / i) * (z - n))) / z;
    todecimal(1);
  }

  void calcularFg() {
    todecimal(0);
    num x = pow((1 + i), n);
    num k = x - 1;
    num z = k / i;
    g = i * ((f + (a * z)) / (z - n));
    todecimal(1);
  }

  void criterio() {
    if (iTiempo == nTiempo) {
      criterio2();
      calcularCuotas();
    } else {
      conversion();
      criterio2();
      inversion();
      calcularCuotas();
    }
  }

  void criterio2() {
    if ((p == 0) && (f != 0 && i != 0 && n != 0 && g != 0 && a != 0)) {
      calcularP();
    } else if ((g == 0) && (p != 0 && i != 0 && n != 0 && a != 0)) {
      calcularPg();
    } else if ((a == 0) && (p != 0 && i != 0 && n != 0 && g != 0)) {
      calcularPa();
    } else if ((f == 0) && (p != 0 && i != 0 && n != 0 && g != 0 && a != 0)) {
      calcularF();
    } else if ((g == 0) && (f != 0 && i != 0 && n != 0 && a != 0)) {
      calcularFg();
    } else if ((a == 0) && (f != 0 && i != 0 && n != 0 && g != 0)) {
      calcularFa();
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

  void calcularCuotas() {
    cuotas2.clear();
    cuotas2.add(0);
    for (int h = 1; h < n + 1; h++) {
      double cuota = a - ((h - 1) * g);
      cuotas2.add(cuota);
    }
    //print(cuotas2);
  }
}
