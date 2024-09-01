import '../../resources/exports/index.dart';

class Auction extends GetView<AuctionController> {
  const Auction({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final AuctionController auctionController = Get.put(AuctionController());
    return Scaffold(
      appBar: const CustomAppBar(title: Strings.AUCTION),
      body: Column(
        children: [
          Container(
            height: 250.0,
            width: double.maxFinite,
            margin: const EdgeInsets.all(12.0),
            child: ImageService.image(Assets.AUCTION_HEADER, scale: 1.1),
          ),
          PaginatedListView(
            onSecondaryButtonTap: (id) => Get.toNamed(
              Routes.PRODUCT_DETAILS,
              arguments: {"proId": id, "isAuctionProduct": true},
            ),
            showOnlyRightBtn: true,
            showTopSellerOrBrands: false,
            apiUrl: Urls.AUCTION,
            // dummyData: ListViewModel.listFromJson(allProductsData),
            buttonTitle: Strings.VIEW_SHOP,
            onCardTap: (id) => Get.toNamed(
              Routes.PRODUCT_DETAILS,
              arguments: {"proId": id, "isAuctionProduct": true},
            ),
          ).expanded(),
        ],
      ),
    );
  }
}
