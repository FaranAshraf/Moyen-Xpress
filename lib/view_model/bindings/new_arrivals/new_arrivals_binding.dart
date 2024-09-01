import 'package:moyen_express/view_model/controllers/new_arrival/new_arrival_controller.dart';

import '../../../resources/exports/index.dart';


class NewArrivalsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NewArrivalController());
  }
}
