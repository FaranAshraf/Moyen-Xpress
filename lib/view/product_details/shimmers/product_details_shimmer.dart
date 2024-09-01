import '../../../resources/exports/index.dart';

class ProductsDetailsShimmer extends StatelessWidget {
  final bool isAuctionProduct;
  const ProductsDetailsShimmer({
    Key? key,
    this.isAuctionProduct = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomAppBar(
        title: isAuctionProduct
            ? Strings.AUCTION_PRODUCT_DETAILS
            : Strings.PRODUCT_DETAILS,
        actions: Row(
          children: [
            const Icon(Icons.share_outlined).shimmerWidget,
            const SpaceW10(),
            const Icon(Icons.shopping_cart_outlined).shimmerWidget,
            const SpaceW10(),
            if (!isAuctionProduct) ...[
              const Icon(Icons.thumb_up_alt_outlined).shimmerWidget,
              const SpaceW10(),
              const Icon(Icons.favorite_outline).shimmerWidget,
              const SpaceW10(),
            ],
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              Container(
                height: 250.0,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7.0),
                  color: AppColors.white,
                ),
              ).shimmerWidget,
              const SpaceH16(),
              const TitlePlaceholder(width: 250, height: 15, linesCount: 1)
                  .shimmerWidget,
              const SpaceH10(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.star_border_outlined).shimmerWidget,
                  const SpaceW4(),
                  const TitlePlaceholder(width: 80, height: 10, linesCount: 1)
                      .shimmerWidget,
                  const SpaceW8(),
                  const Icon(Icons.thumb_up_alt_outlined).shimmerWidget,
                  const SpaceW8(),
                  const TitlePlaceholder(width: 80, height: 10, linesCount: 1)
                      .shimmerWidget,
                  const SpaceW16(),
                  const Icon(Icons.local_shipping_outlined).shimmerWidget,
                  const SpaceW8(),
                  const TitlePlaceholder(width: 80, height: 10, linesCount: 1)
                      .shimmerWidget,
                ],
              ),
              const SpaceH16(),
              Container(
                width: double.maxFinite,
                height: 100.0,
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  gradient: Gradients.sellerDetails,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Row(
                  children: [
                    Container(
                      height: 80.0,
                      width: 80.0,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.white,
                      ),
                    ).shimmerWidget,
                    const SpaceW10(),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const TitlePlaceholder(
                          width: 150,
                          height: 15,
                          linesCount: 1,
                        ).shimmerWidget,
                        const SpaceH12(),
                        Row(
                          children: [
                            const Icon(Icons.star_border_outlined)
                                .shimmerWidget,
                            const SpaceW4(),
                            const TitlePlaceholder(
                              width: 40,
                              height: 10,
                              linesCount: 1,
                            ).shimmerWidget,
                            const SpaceW8(),
                            const Icon(Icons.reviews_outlined).shimmerWidget,
                            const SpaceW8(),
                            const TitlePlaceholder(
                              width: 40,
                              height: 10,
                              linesCount: 1,
                            ).shimmerWidget,
                          ],
                        ),
                      ],
                    ),
                    const SpaceW16(),
                    Container(
                      height: 55,
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                    ).shimmerWidget.expanded(),
                  ],
                ),
              ),
              const SpaceH30(),
              Row(
                children: [
                  const TitlePlaceholder(
                    width: 80,
                    height: 20,
                    linesCount: 1,
                  ).shimmerWidget.expanded(),
                  const SpaceW8(),
                  const TitlePlaceholder(
                    width: 80,
                    height: 20,
                    linesCount: 1,
                  ).shimmerWidget,
                  const SpaceW8(),
                  const TitlePlaceholder(
                    width: 80,
                    height: 20,
                    linesCount: 1,
                  ).shimmerWidget.expanded(),
                  const SpaceW8(),
                  const TitlePlaceholder(
                    width: 80,
                    height: 20,
                    linesCount: 1,
                  ).shimmerWidget.expanded(),
                  const SpaceW8(),
                ],
              ),
              const SpaceH20(),
              Divider(color: AppColors.shadow),
              const SpaceH20(),
              RichTitlePlaceholder(width: Get.width, height: 10, linesCount: 10)
                  .shimmerWidget,
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        width: double.maxFinite,
        height: 90.0,
        padding: const EdgeInsets.all(12.0),
        decoration: const BoxDecoration(color: Colors.white),
        child: Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TitlePlaceholder(
                  width: 90,
                  height: 10,
                  linesCount: 1,
                ).shimmerWidget,
                const SpaceH10(),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const TitlePlaceholder(
                      width: 110,
                      height: 20,
                      linesCount: 1,
                    ).shimmerWidget,
                    const SpaceW10(),
                    const TitlePlaceholder(
                      width: 60,
                      height: 10,
                      linesCount: 1,
                    ).shimmerWidget,
                  ],
                ),
              ],
            ),
            const SpaceW16().expanded(),
            CustomButton.solid(
              backgroundColor: AppColors.cartBtn,
              textColor: AppColors.white,
              onTap: Get.back,
              radius: Sizes.RADIUS_6,
              child: const Icon(
                Icons.shopping_cart_outlined,
                color: AppColors.white,
                size: 30,
              ),
            ).constrainedBox(maxHeight: 50, maxWidth: 80).shimmerWidget,
            const SpaceW10(),
            CustomButton.solid(
              backgroundColor: AppColors.primaryColor,
              textColor: AppColors.white,
              text: Strings.BUY_NOW,
              onTap: Get.back,
              radius: Sizes.RADIUS_6,
            ).constrainedBox(maxHeight: 60, maxWidth: 120).shimmerWidget,
          ],
        ),
      ),
    );
  }
}
