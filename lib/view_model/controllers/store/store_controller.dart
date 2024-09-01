
import 'package:moyen_express/resources/exports/index.dart';

class StoreController extends GetxController {
  final StoreHomeController _storeHomeController =
      Get.put(StoreHomeController());
  RxBool storeRating = false.obs;
  RxBool topSellingBrands = false.obs;
  String? storeImg = '';
  String? storeTitle;
  dynamic onTap1;

  late int storeId;
  @override
  void onInit() {
    // _storeHomeController.onDummyData.value=false;

    super.onInit();
     storeId = Get.arguments?['storeId'] ?? 0;
    if (kDebugMode) {
      print('Store ID: $storeId');
    }
    _storeHomeController.onDummyData.value = true;
    Future.delayed(const Duration(seconds: 5), () {
      if (Get.currentRoute == Routes.STORE) {
        CustomDialog.showDialog(
            width: 350,
            height: 600,
            content: const BannerView(img: Assets.ANIMATED_BANNER2));
      }
    });
  }

  @override
  void onClose() {
    _storeHomeController.onDummyData.value = false;

    super.onClose();
  }
}
