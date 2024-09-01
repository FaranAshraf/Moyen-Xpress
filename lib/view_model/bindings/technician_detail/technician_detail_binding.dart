
import 'package:moyen_express/view_model/controllers/technician_detail/technician_detail_controller.dart';

import '../../../resources/exports/index.dart';

class TechnicianDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TechnicianDetailController());
  }
}
