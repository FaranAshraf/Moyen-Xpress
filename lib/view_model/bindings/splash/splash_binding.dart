import 'package:moyen_express/resources/exports/index.dart';

class SplashBinding extends Bindings{
 @override
  void dependencies(){
    Get.lazyPut(() => SplashController());
 }
}