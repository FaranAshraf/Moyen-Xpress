
import '../../../resources/exports/index.dart';

class MyOrdersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MyOrdersController());
  }
}
