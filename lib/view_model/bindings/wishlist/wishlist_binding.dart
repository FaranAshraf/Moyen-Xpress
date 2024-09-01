import 'package:moyen_express/resources/exports/index.dart';

class WishListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WishListController());
  }
}
