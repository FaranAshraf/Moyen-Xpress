import '../../../resources/exports/index.dart';

class TopBrands extends GetView<HomeController> {
  const TopBrands({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  CustomAppBar(title: Strings.TOP_BRANDS.tr),
      body: PaginatedListView(
        showTopSellerOrBrands: true,
        buttonTitle: Strings.VIEW.tr,
        apiUrl: Urls.TOP_BRANDS,
              onCardTap: (id) => log.e(id),
        onPrimaryButtonTap: (productId) => log.e(productId),
      ),
    );
  }
}
