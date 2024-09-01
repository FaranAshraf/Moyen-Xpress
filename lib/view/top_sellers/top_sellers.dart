import '../../../resources/exports/index.dart';

class TopSellers extends GetView<HomeController> {
  const TopSellers({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  CustomAppBar(title: Strings.TOP_SELLERS.tr),
      body: PaginatedListView(
        showTopSellerOrBrands: true,
        showOnlyRightBtn: false,
        buttonTitle: Strings.VIEW_SHOP.tr,
        apiUrl: Urls.TOP_SELLERS,
        onCardTap: (id) => Get.toNamed(
              Routes.STORE_HOME,
              arguments: {"storeId": id},
            ),
        onPrimaryButtonTap: (productId) => Get.toNamed(
              Routes.STORE_HOME,
              arguments: {"storeId": productId},
            ),
     
      ),
    );
  }
}
