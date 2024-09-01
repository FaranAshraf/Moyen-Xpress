import 'package:moyen_express/resources/exports/index.dart';
import 'package:moyen_express/view_model/controllers/shipping_description/shipping_description_controller.dart';


class ShippingDescriptionBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => ShippingDescriptionController());
  }
  
}