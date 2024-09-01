import 'package:moyen_express/resources/exports/index.dart';

class RefundRequestBinding extends Bindings{
  @override
  void dependencies(){
    Get.lazyPut(() => RefundRequestController());
  }
}