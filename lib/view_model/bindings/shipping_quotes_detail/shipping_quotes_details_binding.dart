import 'package:moyen_express/resources/exports/index.dart';

import '../../controllers/shipping_quotes_detail/shipping_quotes_details_controller.dart';

class ShippingQuoteBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ShippingQuoteDetailController());
  }
}
