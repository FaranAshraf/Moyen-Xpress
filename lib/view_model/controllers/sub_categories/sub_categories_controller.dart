import 'package:moyen_express/resources/exports/index.dart';

class SubCategoryController extends GetxController {
  late int subCategoryId;
  RxInt itemId=0.obs;
  RxBool appBarValue=false.obs;
  List<SuccessContent>? subCategories;
  Future<void> getSubCategory() async {
   subCategories= await HomeRepository.getSubCategories(subId: subCategoryId);
  }



  @override
  void onInit() {
    subCategoryId = Get.arguments != null ? Get.arguments['subCategoryId'] : 0;

    getSubCategory();
    super.onInit();
  }
}
