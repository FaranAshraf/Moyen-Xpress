
import '../../../resources/exports/index.dart';

class GetQuoteBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GetQuoteController());
  }
}
