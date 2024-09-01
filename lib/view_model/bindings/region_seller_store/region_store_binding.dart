
import 'package:moyen_express/view_model/controllers/region_seller_stores/region_seller_stores_controller.dart';

import '../../../resources/exports/index.dart';

class RegionSellerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RegionSellerStoreController());
  }
}
