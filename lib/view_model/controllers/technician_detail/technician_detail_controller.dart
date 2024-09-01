import 'package:moyen_express/model/technician/technician_detail_model.dart';

import '../../../resources/exports/index.dart';

class TechnicianDetailController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabCtrl;
  late int techId;

  void toggleSelectedImageTech(
    TechnicianDetail? product,
  ) {
    // Update selectedImageIndex
    // selectedImageIndex = index;
    // Refresh UI
    update(["product_preview_image"]);
  }

  void onAddToCart() {
    CustomDialog.showDialog(
      content: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Text(
            //   Strings.Item_Added_To_Your_Cart.tr,
            //   textAlign: TextAlign.center,
            //   style: Get.context!.textTheme.headline6?.copyWith(
            //       fontWeight: FontWeight.bold,
            //       color: AppColors.primaryColor,
            //       fontSize: Sizes.TEXT_SIZE_40),
            // ),
            SizedBox(height: Sizes.HEIGHT_20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomButton.solid(
                  backgroundColor: AppColors.cartBtn,
                  textColor: AppColors.white,
                  radius: Sizes.RADIUS_8,
                  child: Text(
                    Strings.BACK_TO_SHOPPING.tr,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: Sizes.TEXT_SIZE_16,
                    ),
                  ),
                  onTap: () => Get.back(),
                ).constrainedBox(maxHeight: 50, maxWidth: 170),
                CustomButton.solid(
                    backgroundColor: AppColors.primaryColor,
                    textColor: AppColors.white,
                    radius: Sizes.RADIUS_8,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.shopping_cart_outlined,
                            color: AppColors.white),
                        SizedBox(width: Sizes.WIDTH_8),
                        Text(
                          Strings.MY_CART.tr,
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: Sizes.TEXT_SIZE_16,
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      Get.back();
                      Get.toNamed(Routes.CART);
                    }).constrainedBox(maxHeight: 50, maxWidth: 170),
              ],
            ),
          ],
        ),
      ),
      alignment: Alignment.center,
      showTopRightDialog: false,
      barrierDismissible: true,
      width: 400,
      height: 300,
    );
  }

  @override
  void onInit() {
    tabCtrl = TabController(length: 3, vsync: this);
    techId = Get.arguments != null ? Get.arguments['techId'] : 0;
    log.w(techId);
    super.onInit();
  }
}
