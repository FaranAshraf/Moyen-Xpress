import 'package:moyen_express/model/technician/technician_detail_model.dart';
import 'package:moyen_express/repository/cart_repository.dart';
import 'package:moyen_express/repository/technician_repository.dart';
import 'package:moyen_express/view/technician/component/tech_details_tab.dart';
import 'package:moyen_express/view_model/controllers/technician_detail/technician_detail_controller.dart';

import '../../resources/exports/index.dart';

// ignore: must_be_immutable
class TechDetail extends GetView<TechnicianDetailController> {
  const TechDetail({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LocationsController locationsController =
        Get.put(LocationsController());
    // ignore: unused_local_variable
    final TechnicianDetailController technicianDetailController =
        Get.put(TechnicianDetailController());
    return Container(
      color: AppColors.white,
      child: CustomFutureBuilder<TechnicianDetail?>(
        customLoader: const ProductsDetailsShimmer(
            // isAuctionProduct: controller.isAuctionProduct,
            ),
        future: TechnicianRepository.getTechDetail(
            id: technicianDetailController.techId.toString()),
        hasDataBuilder: (context, snapshot) {
          return _buildContent(context, snapshot.data,
              technicianDetailController, locationsController);
        },
      ),
    );
  }

  Scaffold _buildContent(
      BuildContext context,
      TechnicianDetail? product,
      TechnicianDetailController controller,
      LocationsController locationsController) {
    return Scaffold(
        backgroundColor: AppColors.white,
        appBar:  CustomAppBar(
          title: Strings.TECH_PRODUCT_DETAILS.tr,
        ),
        body: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(children: [
              Container(
                height: 250.0,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7.0),
                  color: AppColors.imageContainer,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.black.withOpacity(0.05),
                      offset: const Offset(0.0, 4.0),
                      blurRadius: 5.0,
                    ),
                  ],
                ),
                child: _buildImages(product),
              ),
              const SpaceH10(),
              Text(
                product?.serviceName ?? "",
                style: context.headlineSmall,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
              const SpaceH10(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.star_border_outlined,
                    color: AppColors.primaryColor,
                  ),
                  const SpaceW4(),
                  Text("${product?.rating ?? 0}/5 ( ${5} )"),
                  const SpaceW8(),
                  Text(
                    "Sold By:",
                    style: context.bodyMedium,
                  ),
                  const SpaceW8(),
                  Text(
                    product?.companyName ?? "",
                    style: context.bodyMedium,
                  ),
                  const SpaceW8(),
                ],
              ),
              const SpaceH16(),
              TechnicianDetailsTabs(
                tab:  [
                  Tab(text: Strings.PRICE.tr),
                  Tab(text: Strings.DESCRIPTION.tr),
                  Tab(
                    text: Strings.REVIEWS_RATING.tr,
                  ),
                ],
                children: [
                  Column(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  Strings.UNIT_PRICE.tr,
                                  style:
                                      context.bodyLarge.copyWith(fontSize: 18),
                                ),
                                Text(
                                  "\$${product?.price.toString() ?? ""}",
                                  style:
                                      context.bodyLarge.copyWith(fontSize: 18),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Tax:",
                                  style:
                                      context.bodyLarge.copyWith(fontSize: 18),
                                ),
                                Text(
                                  product?.tax == null
                                      ? "0 %"
                                      : "${product?.tax.toString() ?? ""} %",
                                  style:
                                      context.bodyLarge.copyWith(fontSize: 18),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  HtmlText(
                    showReadMore: false,
                    jsonData: product?.description ?? "-",
                  ),
                  // ignore: unrelated_type_equality_checks
                  product?.rating==""
                      ? const Padding(
                          padding: EdgeInsets.all(4.0),
                          child: Text("No Reviews Found"),
                        ):  Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(product!.rating.toString(),style: context.bodyMedium,),
                        )
                     
                ],
              ).expanded(),
            ])),
        bottomNavigationBar: Container(
          width: double.maxFinite,
          height: 90.0,
          padding: const EdgeInsets.all(12.0),
          decoration: const BoxDecoration(color: Colors.white),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AuthManager.instance.isLoggedIn
                  ? CustomButton.solid(
                      text: Strings.ADD_TO_CHECKOUT.tr,
                      backgroundColor: AppColors.cartBtn,
                      textColor: AppColors.white,
                      radius: Sizes.RADIUS_6,
                      onTap: () => CustomDialog.showDialog(
                          height: 320.0,
                          content: successDialog(context, () {
                            Navigator.pop(context);
                            Get.offNamed(Routes.DASHBOARD);
                          }))).constrainedBox(maxHeight: 50, maxWidth: 200)
                  : const SpaceW10(),
         const SpaceH20(),

              CustomButton.solid(
                backgroundColor: AppColors.primaryColor,
                textColor: AppColors.white,
                text: Strings.ADD_TO_CART.tr,
                onTap: () {
                  CartRepository.cartAPi(
                    productId: product?.id?.toInt(),
                    productType: "service",
                    quantity: 1,
                    color: locationsController.colorValue.value.toString(),
                    size: locationsController.sizeValue.value.toString(),
                  );
                  controller.onAddToCart();
                },
                radius: Sizes.RADIUS_6,
              ).constrainedBox(maxHeight: 50, maxWidth: 200),
            ],
          ),
        ));
  }

  // ignore: unused_element
  Widget _buildInfoText(BuildContext context, String title, String subTitle) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: context.titleMedium),
        Text(
          subTitle,
          style: context.titleLarge.copyWith(color: AppColors.primaryColor),
        ),
      ],
    );
  }

  Stack _buildImages(TechnicianDetail? product) {
    return Stack(
      children: [
        GetBuilder<TechnicianDetailController>(
          id: "product_preview_image",
          builder: (_) {
            return ImageService.image(
              product?.thumbnailImage ?? "",
              borderRadius: 8.0,
              imageSize: 250.0,
              imageWidth: double.maxFinite,
            );
          },
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            height: 50.0,
            child: _buildPreviewImages(product),
          ),
        ),
      ],
    );
  }

  Widget _buildPreviewImages(TechnicianDetail? product) {
    return GestureDetector(
      onTap: () => controller.toggleSelectedImageTech(product),
      child: GetBuilder<TechnicianDetailController>(
          id: "product_preview_image",
          builder: (_) {
            return Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.0),
                color: AppColors.imageContainer,
                border: Border.all(
                  color: AppColors.white,
                  // width: controller.selectedImageIndex ? 2 : 1.0,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.shadow,
                    offset: const Offset(0.0, 4.0),
                    blurRadius: 5.0,
                  ),
                ],
              ),
              child: ImageService.image(
                product?.thumbnailImage ?? "",
                borderRadius: 4.0,
                imageSize: 250.0,
                imageWidth: double.maxFinite,
              ),
            );
          }),
    );
  }

  Column successDialog(BuildContext context, dynamic onTap) {
    return Column(
      children: [
        Expanded(
          child: Column(
            children: [
              Lottie.asset(Assets.SUCCESS,
                  width: 150, height: 150, fit: BoxFit.fill),
              Text("Your Inquiry has been Send Successfully",
                  textAlign: TextAlign.center,
                  style: context.bodyLarge.copyWith(fontSize: 22, height: 1.3))
            ],
          ),
        ),
        CustomButton.solid(
          margin: const EdgeInsets.all(12),
          backgroundColor: Colors.green,
          textColor: AppColors.white,
          text: "OK",
          onTap: onTap,
          radius: Sizes.RADIUS_6,
          constraints: const BoxConstraints(minHeight: 55),
        ),
      ],
    );
  }
}
