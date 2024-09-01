import '../../../resources/exports/index.dart';
import '../../controllers/recently_views/recently_views_controller.dart';

class RecentlyViewsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RecentlyViewsController());
  }
}
