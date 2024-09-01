import '../../../resources/exports/index.dart';
import '../../controllers/gallery_search/gallery_search_controller.dart';

class GalleryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GalleryController());
  }
}
