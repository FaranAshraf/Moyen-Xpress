
import '../../../resources/exports/index.dart';
import '../../controllers/filter_product/filter_product_controller.dart';

class FilterProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GridController());
  }
}
