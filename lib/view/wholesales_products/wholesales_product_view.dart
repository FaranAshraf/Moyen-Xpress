import '../../repository/cart_repository.dart';
import '../../repository/wishlist_repository.dart';
import '../../resources/exports/index.dart';
import '../../utils/bottom_sheet.dart';

class WholeSalesProducts extends StatelessWidget {
  const WholeSalesProducts({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final LocationsController locationsController =
        Get.put(LocationsController());
    return Scaffold(
        appBar: CustomAppBar(title: Strings.WHOLESALERS.tr),
        body: Padding(
            padding: const EdgeInsets.all(12.0),
            child: CustomFutureBuilder(
              customLoader: const GridViewShimmer(),
              future: HomeRepository.getWholeSaleProducts(),
              hasDataBuilder: (context, snapshot) =>
                  _buildItems(snapshot.data ?? []),
            )));
  }

  GridView _buildItems(List<ListViewModel> items) {
    final LocationsController locationsController =
        Get.put(LocationsController());
    return GridView.builder(
      padding: EdgeInsets.zero,
      itemCount: items.length,
      physics: const AlwaysScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: Sizes.WIDTH_18,
        mainAxisSpacing: Sizes.HEIGHT_20,
        childAspectRatio: 3 / 3.5,
      ),
      itemBuilder: (context, index) => PaginatedListViewCardContent(
        item: items[index],
        showRating: true,
        onPrimaryButtonTap: (productId) async {
          Get.bottomSheet(
            CustomBottomSheetWidget(
                id: productId,
                onTap: () {
                  log.e(items[index].minimumQty);
                  CartRepository.cartAPi(
                      productType: "product",
                      productId: productId.toInt(),
                      quantity: items[index].minimumQty,
                      color: locationsController.colorValue.value.toString(),
                      size: locationsController.sizeValue.value.toString());
                  Get.back();
                }),
          );
        },
        onCardTap: (id) => Get.toNamed(
          Routes.PRODUCT_DETAILS,
          arguments: {"proId": id, "isAuctionProduct": false},
        ),
        onSecondaryButtonTap: (id) {
          WishlistRepository.addToWishList(productId: id.toString());
          log.e(id);
        },
      ),
    );
  }
}
