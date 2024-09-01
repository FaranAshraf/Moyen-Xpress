import 'package:moyen_express/resources/exports/index.dart';

import '../../controllers/shipping_quotes/shipping_quotes_controller.dart';

class ShippingQuoteBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => ShippingQuoteController());
  }
  
}