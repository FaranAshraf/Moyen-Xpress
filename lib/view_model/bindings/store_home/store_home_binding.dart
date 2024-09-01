import 'package:moyen_express/resources/exports/index.dart';

class StoreHomeBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => StoreHomeController());
  }

}