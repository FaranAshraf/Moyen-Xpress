import 'package:moyen_express/resources/exports/index.dart';

class SearchProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SearchProductController());
  }
}
