import 'package:moyen_express/resources/exports/index.dart';

import '../../controllers/wholesales/wholesales_controller.dart';


class WholeSaleBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => WholeSaleController());
  }

}