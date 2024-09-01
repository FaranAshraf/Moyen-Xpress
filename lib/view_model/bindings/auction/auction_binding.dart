import '../../../resources/exports/index.dart';

class AuctionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuctionController());
  }
}
