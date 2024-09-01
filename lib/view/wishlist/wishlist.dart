import 'package:moyen_express/model/wishlist/wishlist_model.dart';
import 'package:moyen_express/repository/wishlist_repository.dart';

import '../../resources/exports/index.dart';
import '../../utils/custom_future_wishlist_builder_empty.dart';

class WishListView extends GetView<WishListController> {
  const WishListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar:  CustomAppBar(
        title: Strings.WISHLIST.tr,
      ),
      body: GetBuilder<WishListController>(builder: (controller) {
        return CustomFutureWishListBuilderEmpty(
          future: WishlistRepository.getWishListProduct(),
          hasDataBuilder: (_, snapshot) {
            if (snapshot.hasData) {
              List<WishItem> cartItems = snapshot.data as List<WishItem>;
              return SingleChildScrollView(
                  child: _buildItems(context, cartItems));
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        );
      }),
    );
  }

  Widget _buildItems(BuildContext context, List<WishItem> items) {
    // Group items by shop name
    Map<String, List<WishItem>> groupedItems = {};

    for (var item in items) {
      if (!groupedItems.containsKey(item.storeName)) {
        groupedItems[item.storeName!] = [];
      }
      groupedItems[item.storeName]!.add(item);
    }

    // Build widgets for each shop and its products
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: groupedItems.entries.map((entry) {
        String shopName = entry.key;
        List<WishItem> shopItems = entry.value;
        bool isLastShop = groupedItems.keys.last == shopName;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "$shopName Products",
                overflow: TextOverflow.ellipsis,
                style: context.bodyLarge
                    .copyWith(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            ),
            ListView.builder(
              itemCount: shopItems.length,
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (_, index) {
                return _buildProducts(context, shopItems[index], index);
              },
            ),
            if (shopItems.length > 1 || isLastShop)
              const CustomButton.solid(
                margin: EdgeInsets.only(
                    left: 16.0, right: 10.0, bottom: 10.0, top: 10.0),
                backgroundColor: AppColors.primaryColor,
                textColor: AppColors.white,
                text: "Proceed to Checkout",

                radius: Sizes.RADIUS_6,
                // constraints: const BoxConstraints(minHeight: 40),
              ),
          ],
        );
      }).toList(),
    );
  }

  Widget _buildProducts(BuildContext context, WishItem product, int index) {
    return Column(
      children: [
        Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
            child: Row(
              children: [
                Container(
                  height: 100.0,
                  width: 100.0,
                  decoration: BoxDecoration(
                    color: AppColors.iconGrey,
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.shadow,
                        offset: const Offset(0.0, 4.0),
                        blurRadius: 6.0,
                      ),
                    ],
                  ),
                  child: ImageService.image(
                    product.product?.thumbnailImg ?? "",
                    borderRadius: 8.0,
                  ),
                ),
                const SpaceW16(),
                GetBuilder<WishListController>(
                    id: "delete",
                    builder: (_) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 150,
                                child: Text(
                                  product.product?.name ?? "",
                                  style: context.titleMedium,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ).expanded(),
                              const SpaceW10(),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    onTap: () async {
                                      await controller
                                          .removeCartItem(product.id);

                                      controller.update();
                                    },
                                    child: const Icon(Icons.delete_outline,
                                        color: AppColors.error),
                                  ),
                                  const SpaceH30(),
                                  Text(
                                    (product.product?.unitPrice ?? 0)
                                        .toString()
                                        .toPrice(withSymbol: true),
                                    style: context.titleMedium,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ).expanded();
                    }),
              ],
            ).constrainedBox(maxHeight: 100)),
      ],
    );
  }
}
