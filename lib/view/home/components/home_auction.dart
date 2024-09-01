import '../../../resources/exports/index.dart';

class HomeAuction extends GetView<HomeController> {
  const HomeAuction({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: CustomFutureBuilder(
        customLoader: const GridViewShimmer(),
        future: HomeRepository.getAuction(),
        hasDataBuilder: (context, snapshot) => _buildItems(snapshot.data ?? []),
      ),
    );
  }

  GridView _buildItems(List<ListViewModel> items) {
    return GridView.builder(
      padding: EdgeInsets.zero,
      itemCount: items.length > 4 ? 4 : items.length,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: Sizes.WIDTH_18,
        mainAxisSpacing: Sizes.HEIGHT_20,
        childAspectRatio: 3 / 3.5,
      ),
      itemBuilder: (context, index) => PaginatedListViewCardContent(
        borderRadius: 0.0,
        showTopSellerOrBrands: true,
        item: items[index],
        showRating: true,
        buttonTitle: Strings.VIEW.tr,
        onCardTap: (id) {
          log.e(id);
          Get.toNamed(
            Routes.PRODUCT_DETAILS,
            arguments: {"proId": id, "isAuctionProduct": true},
          );
        },
      
        onPrimaryButtonTap: (productId) => Get.toNamed(
          Routes.PRODUCT_DETAILS,
          arguments: {"proId": productId, "isAuctionProduct": true},
        ),
      ),
    );
  }
}
