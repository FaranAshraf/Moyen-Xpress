import 'package:moyen_express/resources/exports/index.dart';

class ProfileBinding extends Bindings{
  @override
  void dependencies(){
    Get.lazyPut(() => ProfileController());
  }
}