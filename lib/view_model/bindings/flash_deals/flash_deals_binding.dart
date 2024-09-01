import '../../../resources/exports/index.dart';

class FlashDealsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FlashDealsController());
  }
}
