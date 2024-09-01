import 'package:moyen_express/resources/exports/index.dart';

class SubCategoryBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => SubCategoryController());
  }

}