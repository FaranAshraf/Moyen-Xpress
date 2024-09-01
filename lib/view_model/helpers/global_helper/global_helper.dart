import 'dart:math';

class GlobalHelper {
  static Set<int> setOfInts = {};

  static int getRandomId() {
    int value = Random().nextInt(99999999);
    while (setOfInts.contains(value)) {
      value = Random().nextInt(99999999);
    }
    setOfInts.add(value);
    return setOfInts.last;
  }

  static double getDiscountPice(double price, int disPer) {
    double disPrice = (disPer / 100) * price;
    if (disPrice.isInfinite || disPrice.isNegative) return 0.0;
    return disPrice;
  }
}
