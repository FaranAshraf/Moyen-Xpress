

import '../../../resources/exports/index.dart';

class StoreBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => StoreController());
  }
}
