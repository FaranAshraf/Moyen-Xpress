import 'package:moyen_express/view_model/controllers/shipping_orders/shipping_orders_controller.dart';

import '../../../resources/exports/index.dart';

class ShippingOrdersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ShippingOrdersController());
  }
}
