class OrderCalculator {
  static const double tax = 1.5;
  static const double deliveryFee = 4.0;

  static double calculateTotal(double orderPrice) {
    return orderPrice + tax + deliveryFee;
  }
}
