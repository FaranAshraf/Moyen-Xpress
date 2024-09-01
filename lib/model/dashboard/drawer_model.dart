import '../../resources/exports/index.dart';

class DrawerModel {
  String title;
  dynamic icon;
  VoidCallback onTap;

  DrawerModel({
    required this.title,
    required this.icon,
    required this.onTap,
  });
}

class FullDrawerModel {
  String title;
  dynamic icon;
  VoidCallback onTap;

  FullDrawerModel({
    required this.title,
    required this.icon,
    required this.onTap,
  });
}
