class SimpleInterestModel {
  late double p;
  late double f;
  late double n;
  late double i;
  late int nTiempo;
  late int iTiempo;
  late bool modo = true;
  SimpleInterestModel(
      {this.p = 0,
      this.f = 0,
      this.n = 0,
      this.i = 0,
      this.iTiempo = 0,
      this.nTiempo = 0});

  List<List<double>> matrix = [
    [1, 30, 60, 90, 180, 360],
    [0.03333333333333330, 1, 2.00, 3.00, 6.00, 12.00],
    [0.01666666666666670, 0.50, 1, 1.50, 3.00, 6.00],
    [
      0.01111111111111110,
      0.3333333333333330,
      0.6666666666666670,
      1,
      2.00,
      4.00
    ],
    [
      0.005555555555555560,
      0.1666666666666670,
      0.3333333333333330,
      0.50,
      1,
      2.00
    ],
    [
      0.002777777777777780,
      0.08333333333333330,
      0.1666666666666670,
      0.25,
      0.50,
      1
    ],
  ];

  void todecimal(int num) {
    if (num == 0) {
      i = i / 100;
    } else {
      i = i * 100;
    }
  }

  void calcularI() {
    i = (1 / n) * ((f / p) - 1);
    todecimal(1);
    //print(i);
  }

  void calcularN() {
    todecimal(0);
    n = (1 / i) * ((f / p) - 1);
    todecimal(1);
  }

  void calcularF() {
    todecimal(0);
    f = p * (1 + (n * i));
    todecimal(1);
  }

  void calcularP() {
    todecimal(0);
    p = f / (1 + (n * i));
    todecimal(1);
  }

  void criterio() {
    if (iTiempo == nTiempo) {
      criterioIncognita();
    } else {
      conversion();
      criterioIncognita();
      inversion();
    }
  }

  void criterioIncognita() {
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
    i = i * matrix[iTiempo][0];
    //   2          1
  }

  void inversion() {
    i = i * matrix[0][iTiempo];
    //   2          1
  }
}
