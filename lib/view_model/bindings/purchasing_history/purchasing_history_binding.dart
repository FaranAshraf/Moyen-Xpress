import 'package:moyen_express/resources/exports/index.dart';

class PurchasingHistoryBinding extends Bindings{
  @override
  void dependencies(){
    Get.lazyPut(() => PurchasingHistoryController());
  }
}