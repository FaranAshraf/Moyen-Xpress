import 'package:moyen_express/resources/exports/index.dart';

class MoyenXpressBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => MxShippingController());
  }

}