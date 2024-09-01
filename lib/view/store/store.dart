import 'package:moyen_express/resources/exports/index.dart';

class StoreView extends GetView<StoreController> {
  const StoreView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  CustomAppBar(title: Strings.STORE.tr),
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
            apiUrl: Urls.STORE,
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
