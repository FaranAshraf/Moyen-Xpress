import 'package:moyen_express/view_model/controllers/all_products/all_products_controller.dart';

import '../../../resources/exports/index.dart';


class AllProductsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AllProductsController());
  }
}
