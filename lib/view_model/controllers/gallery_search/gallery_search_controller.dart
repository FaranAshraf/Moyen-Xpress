import 'package:moyen_express/repository/gallery_repository.dart';
import 'package:moyen_express/resources/exports/index.dart';

import '../../../model/upload_images/upload_images.dart';

class GalleryController extends GetxController {
  late TextEditingController searchController;
  var dropDownValue = 'newest'.obs;
  var items = ['newest', 'oldest', 'smallest', 'largest'];
  var galleryData = Rxn<GalleryModel>();

  @override
  void onInit() {
    searchController = TextEditingController();
    searchController.addListener(fetchGalleryData);
    super.onInit();
    fetchGalleryData();
  }

  @override
  void dispose() {
    searchController.removeListener(fetchGalleryData);
    searchController.dispose();
    super.dispose();
  }

  Future<void> fetchGalleryData() async {
    final data = await GalleryRepository.getGalleryData(
      search: searchController.text,
      sort: dropDownValue.value,
    );
    galleryData.value = data;
  }
}
