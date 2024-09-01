import '../../resources/exports/index.dart';

class PaymentMethodModel {
  int id;
  String icon;
  String title;
  Color color;
  VoidCallback onTap;

  PaymentMethodModel(
      {required this.id,
      required this.icon,
      required this.title,
      required this.color,
      required this.onTap});
}
