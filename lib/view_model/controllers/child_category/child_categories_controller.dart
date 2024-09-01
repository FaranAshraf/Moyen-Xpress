import 'package:moyen_express/resources/exports/index.dart';

class ChildCategoryController extends GetxController {
  late int childCategoryId;
  late int getSubOrChildProducts;
 

List<SuccessContent>? subCategory;
  Future<void> getChildProduct() async {
    subCategory=await HomeRepository.getSubCategories(subId: childCategoryId);
  }

  @override
  void onInit() {
    childCategoryId = Get.arguments != null ? Get.arguments['childCategoryId'] : 0;
    log.e(childCategoryId);
    // childCategoryId = Get.arguments != null ? Get.arguments['childCategoryId'] : 0;
    getChildProduct();
    super.onInit();
  }
}
