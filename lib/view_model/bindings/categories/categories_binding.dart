import 'package:moyen_express/resources/exports/index.dart';

class CategoriesBinding extends Bindings{
  @override
  void dependencies(){
      Get.lazyPut(() => CategoriesController());
  }
}