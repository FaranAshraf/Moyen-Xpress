import '../../../resources/exports/index.dart';

class LocationsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LocationsController());
  }
}
