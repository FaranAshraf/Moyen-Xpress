part of 'constants.dart';

class Gradients {
  static LinearGradient offlineBackground = LinearGradient(
    begin: const Alignment(-3.0, -3.0),
    end: const Alignment(1.5, 1.5),
    colors: [
      const Color(0xffDA6E26),
      const Color(0xffDA6E26).withOpacity(0.67)
    ],
  );

  static LinearGradient sellerDetails = const LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [Color(0xFFE66B12), Color(0xFFF3921F)],
  );
}
