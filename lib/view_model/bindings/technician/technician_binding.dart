
import '../../../resources/exports/index.dart';

class TechnicianBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TechnicianController());
  }
}
