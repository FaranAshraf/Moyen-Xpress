import 'package:moyen_express/model/shipping_detail/shipping_detail_model.dart';


import '../../resources/exports/index.dart';

class ShippingDetailView extends GetView<MyOrdersController> {
  const ShippingDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:  CustomAppBar(title: Strings.SHIPPING_ORDER.tr),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
              margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              height: 600,
              width: double.maxFinite,
              color: AppColors.white,
              child: CustomFutureBuilder(
                customLoader: const ShippingDetailShimmer(),
                future: controller.getShippingDetail(),
                hasDataBuilder: (context, snapshot) => shipOrderDetail(snapshot, context),
              )),
        ));
  }
















  Column shipOrderDetail(AsyncSnapshot<ShippingDetailModel> snapshot, BuildContext context,) {
    return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                     
                      ImageService.image(
                         snapshot.data!.productImages?[0].imageUrl.toString(),
                          imageWidth: 100,
                          imageSize: 100),
                      const SpaceW8(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(snapshot.data!.title.toString(),
                              style: context.bodyMedium.copyWith(
                                  fontWeight: FontWeight.w600, fontSize: 16)),
                          Row(
                            children: [
                              Text(
                                "Order ID: ",
                                style: context.bodyMedium,
                              ),
                              Text(
                                snapshot.data!.orderId.toString(),
                                style: context.bodyMedium.copyWith(
                                    color: AppColors.primaryColor,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "Order Date/Time: ",
                                style: context.bodyMedium,
                              ),
                              Text(
                                snapshot.data!.orderDate.toString(),
                                style: context.bodyMedium.copyWith(
                                    color: AppColors.black,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "Size: ",
                                style: context.bodyMedium,
                              ),
                              Text(
                                snapshot.data!.size.toString(),
                                style: context.bodyMedium.copyWith(
                                    color: AppColors.black,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                          const SpaceH8(),
                          SizedBox(
                            
                              width: Get.width / 1.5,
                              height: 30,
                              child:  CustomButton(
                                text: Strings.RE_ORDER.tr,
                                textColor: AppColors.white,
                                radius: 5.0,
                                backgroundColor: AppColors.reorder,
                                onTap: ()=>Get.toNamed(Routes.CART),
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                  child: Divider(
                    thickness: 0.8,
                    color: AppColors.black.withOpacity(0.5),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Seller ",
                            style: context.bodyMedium,
                          ),
                          Text(
                            snapshot.data!.shippingInfo!.seller.toString(),
                            style: context.bodyMedium
                                .copyWith(fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Payment Status ",
                            style: context.bodyMedium,
                          ),
                          Text(
                            snapshot.data!.shippingInfo!.paymentStatus
                                .toString(),
                            style: context.bodyMedium.copyWith(
                                color: AppColors.reorder,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Delivery Status ",
                            style: context.bodyMedium,
                          ),
                          Text(
                            snapshot.data!.shippingInfo!.deliveryStatus
                                .toString(),
                            style: context.bodyMedium.copyWith(
                                color: AppColors.reorder,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Payment Method ",
                            style: context.bodyMedium,
                          ),
                          Text(
                            snapshot.data!.shippingInfo!.paymentMethod
                                .toString(),
                            style: context.bodyMedium.copyWith(
                                color: AppColors.black,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Order Status ",
                            style: context.bodyMedium,
                          ),
                          Text(
                            snapshot.data!.shippingInfo!.orderStatus
                                .toString(),
                            style: context.bodyMedium.copyWith(
                                color: AppColors.reorder,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Shipping Address ",
                            style: context.bodyMedium,
                          ),
                          Text(
                            snapshot.data!.shippingInfo!.shippingAddress
                                .toString(),
                            style: context.bodyMedium.copyWith(
                                color: AppColors.black,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Email Address ",
                            style: context.bodyMedium,
                          ),
                          Text(
                            snapshot.data!.shippingInfo!.emailAddress
                                .toString(),
                            style: context.bodyMedium.copyWith(
                                color: AppColors.black,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Delivered Type ",
                            style: context.bodyMedium,
                          ),
                          Text(
                            snapshot.data!.shippingInfo!.deliveryType
                                .toString(),
                            style: context.bodyMedium.copyWith(
                                color: AppColors.black,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                  child: Divider(
                    thickness: 0.8,
                    color: AppColors.black.withOpacity(0.5),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Quantity ",
                            style: context.bodyMedium,
                          ),
                          Text(
                            snapshot.data!.productInfo!.quantity.toString(),
                            style: context.bodyMedium.copyWith(
                                color: AppColors.black,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Subtotal ",
                            style: context.bodyMedium,
                          ),
                          Text(
                            "\$${snapshot.data!.productInfo!.subtotal.toString()}",
                            style: context.bodyMedium.copyWith(
                                color: AppColors.black,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "shipping ",
                            style: context.bodyMedium,
                          ),
                          Text(
                            "\$${snapshot.data!.productInfo!.shipping.toString()}",
                            style: context.bodyMedium.copyWith(
                                color: AppColors.black,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Tax ",
                            style: context.bodyMedium,
                          ),
                          Text(
                            "\$${snapshot.data!.productInfo!.tax.toString()}",
                            style: context.bodyMedium.copyWith(
                                color: AppColors.black,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "coupon ",
                            style: context.bodyMedium,
                          ),
                          Text(
                            "\$${snapshot.data!.productInfo!.coupon.toString()}",
                            style: context.bodyMedium.copyWith(
                                color: AppColors.black,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                      const SpaceH12(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total ",
                            style: context.bodyMedium,
                          ),
                          Text(
                            "\$${snapshot.data!.productInfo!.total.toString()}",
                            style: context.bodyMedium.copyWith(
                                color: AppColors.black,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            );
  }
}
