import 'package:moyen_express/resources/exports/index.dart';

import '../../view_model/controllers/region_seller_stores/region_seller_stores_controller.dart';

class RegionSellerStores extends GetView<RegionSellerStoreController> {
  const RegionSellerStores({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: Strings.REGIONS_SELLERS.tr),
      body: Column(
        children: [
       Container(
            width: double.maxFinite,
            height: 250.0,
            margin: const EdgeInsets.only(left:10.0,right: 10.0,top: 10.0),
            child: ImageService.image(Assets.STORE_CARD, scale: 0.7),
          ),
          PaginatedListView(
            showOnlyRightBtn: false,
            showTopSellerOrBrands: true,
            apiUrl: Urls.REGION_SELLER_STORES,
            parameters: {"country": controller.regionId},
            buttonTitle: Strings.VIEW_SHOP.tr,
            onCardTap: (id) {
              Get.toNamed(
                Routes.STORE_HOME,
                arguments: {"storeId": id},
              );

              log.e(id);
            },
            onPrimaryButtonTap: (productId) => Get.toNamed(
              Routes.STORE_HOME,
              arguments: {"storeId": productId},
            ),
          ).expanded(),
        ],
      ),
    );
  }
}
