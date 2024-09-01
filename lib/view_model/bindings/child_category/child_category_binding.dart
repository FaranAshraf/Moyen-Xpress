import 'package:moyen_express/resources/exports/index.dart';

class ChildCategoryBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => ChildCategoryController());
  }

}