// ignore_for_file: public_member_api_docs, sort_constructors_first

import '../../../resources/exports/index.dart';

// ignore: must_be_immutable
class SellerDetails extends StatelessWidget {
  final SellerData seller;
  String sellerImg;
  String sellerName;
  dynamic rating;
  num id;
  SellerDetails({
    Key? key,
    required this.seller,
    required this.sellerImg,
    required this.sellerName,
    required this.rating,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProductDetailsController productDetailsController =
        Get.put(ProductDetailsController());
    TechnicianController technicianController = Get.put(TechnicianController());
    return Container(
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
            decoration: const BoxDecoration(shape: BoxShape.circle),
            child: Stack(
              children: [
                ImageService.image(
                  sellerImg,
                  imageWidth: double.maxFinite,
                  imageSize: double.maxFinite,
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    height: 14.0,
                    width: 14.0,
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: (seller.isActive ?? false)
                          ? AppColors.active
                          : AppColors.error,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.shadow,
                          offset: const Offset(0.0, 0.0),
                          blurRadius: 4.0,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SpaceW10(),
          GestureDetector(
            onTap: () {
              log.e(id);
              id == 0
                  ? CustomSnackBar.showSnackBar(
                      message: "$sellerName Store not found!",
                      snackBarStyle: SnackBarStyle.success)
                  : Get.toNamed(
                      Routes.STORE_HOME,
                      arguments: {"storeId": id},
                    );
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 130,
                  child: Text(
                    sellerName,
                    style: context.titleLarge.copyWith(
                      // fontSize: 2,
                      color: AppColors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.star_border_outlined,
                      color: AppColors.white,
                    ),
                    const SpaceW4(),
                    Text(
                      "$rating/5",
                      style: context.bodyMedium.copyWith(
                        color: AppColors.white,
                      ),
                    ),
                    const SpaceW8(),
                    const Icon(Icons.reviews_outlined, color: AppColors.white),
                    const SpaceW8(),
                    Text(
                      "( ${seller.noOfReviews ?? 0} )",
                      style: context.bodyMedium.copyWith(
                        color: AppColors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SpaceW16(),
          CustomButton.solid(
            backgroundColor: AppColors.black,
            onTap: () {
              showDialog(
                context: Get.context!,
                builder: (ctx) => SizedBox(
                  width: double.maxFinite,
                  child: AlertDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    contentPadding: EdgeInsets.zero,
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SpaceH10(),
                        Text(
                          Strings.QUERY_MSG.tr,
                          style: context.bodyLarge.copyWith(fontSize: 22),
                        ),
                        const SpaceH4(),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CustomTextFormField(
                                controller:
                                    productDetailsController.proNameController,
                                width: double.maxFinite,
                                readOnly: true,
                                enabled: true,
                                height: Sizes.HEIGHT_20,
                                labelText: Strings.PRODUCT.tr,
                                labelColor: AppColors.black,
                                prefixIconColor: AppColors.black,
                                textColor: AppColors.black,
                                cursorColor: AppColors.black,
                                errorColor: AppColors.error,
                                enableBorderColor: AppColors.black,
                                focusBorderColor: AppColors.primaryColor,
                                textInputAction: TextInputAction.next,
                              ),
                              CustomTextFormField(
                                controller:
                                    productDetailsController.yourQuestion,
                                maxLines: 3,
                                height: Sizes.HEIGHT_20,
                                labelText: Strings.YOUR_QUESTION.tr,
                                labelColor: AppColors.black,
                                prefixIconColor: AppColors.black,
                                textColor: AppColors.black,
                                cursorColor: AppColors.black,
                                errorColor: AppColors.error,
                                enableBorderColor: AppColors.black,
                                focusBorderColor: AppColors.primaryColor,
                                textInputAction: TextInputAction.next,
                              ),
                              const SpaceH4(),
                              CustomButton.solid(
                                margin: const EdgeInsets.only(bottom: 10.0),
                                backgroundColor: AppColors.primaryColor,
                                textColor: AppColors.white,
                                text: Strings.SEND.tr,
                                radius: Sizes.RADIUS_6,
                                onTapAsync: () async {
                                  await productDetailsController.postQuestion();
                                  Get.close(-1);
                                },
                                constraints:
                                    const BoxConstraints(minHeight: 55),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
              );
            },
            radius: Sizes.RADIUS_6,
            constraints: const BoxConstraints(minHeight: 55),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.forum_outlined, color: AppColors.white),
                const SpaceW8(),
                SizedBox(
                  width: 120.0,
                  child: Text(
                    productDetailsController.isAuctionProduct
                        ? Strings.CHAT_WITH_SELLER.tr
                        : technicianController.isTechProducts.value == false
                            ? Strings.CHAT_WITH_SELLER.tr
                            : "Chat With Tech".tr,
                    overflow: TextOverflow.ellipsis,
                    style: context.titleSmall.copyWith(color: AppColors.white),
                  ),
                )
              ],
            ),
          ).expanded(),
        ],
      ),
    );
  }
}
