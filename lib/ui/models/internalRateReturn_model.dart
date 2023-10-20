import 'dart:math';

class InternalRateReturnModel {
  late double inver;
  late double n;
  late double inter;
  late double tir;
  late double van;

  InternalRateReturnModel(
      {this.inver = 0, this.n = 0, this.inter = 0, this.tir = 0, this.van = 0});

  calcularTIR() {
    double lowerRate = 0.0;
    double upperRate = 1.0; // Supongamos una tasa de interés máxima inicial

    while (upperRate - lowerRate > 0.0001) {
      double rate = (lowerRate + upperRate) / 2;
      double npv = inver - inter / pow((1 + rate), n);
      if (npv > 0) {
        lowerRate = rate;
      } else {
        upperRate = rate;
      }
    }

    tir = (lowerRate + upperRate) / 2;
  }

  calcularVAN(double discountRate) {
    van = 0.0;
    for (int i = 0; i <= n; i++) {
      van += inter / pow((1 + discountRate), i);
    }
    van -= inver;
  }
}
