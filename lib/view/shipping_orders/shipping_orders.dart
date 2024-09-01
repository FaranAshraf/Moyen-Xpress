import 'package:moyen_express/repository/myorders_repository.dart';
import 'package:moyen_express/resources/exports/index.dart';
import 'package:moyen_express/utils/custom_future_cart_builder.dart';

class ShippingOrdersView extends GetView<MyOrdersController> {
  const ShippingOrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: Strings.SHIPPING_ORDER.tr),
      body: CustomFutureCartBuilder(
        customLoader: const ShippingCardPlaceHolder(),
        future: MyOrderRepository.getShippingOrders(),
        hasDataBuilder: (context, snapshot) => ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: snapshot.data?.length,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.only(top: 5),
            child: GestureDetector(
              onTap: () {
                Get.toNamed(Routes.SHIPPING_QUOTE_DETAIL,
                    arguments: {"id": snapshot.data?[index].id, "check": 0});
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 10.0),
                margin:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                width: double.maxFinite,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 2,
                        spreadRadius: 2,
                        offset: const Offset(0, 2),
                        color: AppColors.greyClr.withOpacity(0.3))
                  ],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: Text(
                        snapshot.data?[index].orderStatus ?? "",
                        style: context.bodyMedium.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          color: AppColors.completed,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          Strings.ORDER_ID.tr,
                          style: context.bodyMedium.copyWith(
                              color: AppColors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w400),
                        ),
                        Text(
                          snapshot.data?[index].trackingId ?? "",
                          style: context.bodyMedium.copyWith(
                            fontSize: 15,
                            color: AppColors.black,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          Strings.SHIPPING_DATE.tr,
                          style: context.bodyMedium.copyWith(
                              color: AppColors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w400),
                        ),
                        Text(
                          snapshot.data?[index].shipmentDate ?? "",
                          style: context.bodyMedium.copyWith(
                            fontSize: 15,
                            color: AppColors.black,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          Strings.SHIPPING_fROM.tr,
                          style: context.bodyMedium.copyWith(
                              color: AppColors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                          width: 200,
                          child: Text(
                            "${snapshot.data?[index].fromCityId},${snapshot.data?[index].fromStateId},${snapshot.data?[index].fromCountryId}",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: context.bodyMedium.copyWith(
                              fontSize: 15,
                              color: AppColors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          Strings.SHIPPING_TO.tr,
                          style: context.bodyMedium.copyWith(
                              color: AppColors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                          width: 200,
                          child: Text(
                            "${snapshot.data?[index].toCityId},${snapshot.data?[index].toStateId},${snapshot.data?[index].toCountryId}",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: context.bodyMedium.copyWith(
                              fontSize: 15,
                              color: AppColors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          Strings.SHIPMENT_VIA.tr,
                          style: context.bodyMedium.copyWith(
                              color: AppColors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w400),
                        ),
                        Text(
                          snapshot.data?[index].shipVia ?? "",
                          style: context.bodyMedium.copyWith(
                            fontSize: 15,
                            color: AppColors.black,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
