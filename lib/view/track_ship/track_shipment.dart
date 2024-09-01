import 'package:moyen_express/model/track_shipment/track_shipment_model.dart';
import 'package:moyen_express/repository/quote_detail_repository.dart';
import 'package:moyen_express/view/home/components/home_quote.dart';

import '../../resources/exports/index.dart';
import '../../view_model/controllers/track_ship/track_shipment_controller.dart';
import '../../view_model/helpers/global_helper/currency_conversion.dart';

class TrackShipping extends GetView<TrackShipmentController> {
  const TrackShipping({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    // final TrackShipmentController controller =
    //     Get.put(TrackShipmentController());
    // ignore: unused_local_variable
    final CurrencyConversionController conversionController =
        Get.put(CurrencyConversionController());
    return Scaffold(
      appBar: CustomAppBar(title: Strings.TRACK_SHIPMENT.tr),
      body: SingleChildScrollView(
          child: Column(
        children: [
          const HomeQuote(),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 10.0),
            child: Align(
                alignment: Alignment.topLeft,
                child: Text(Strings.TRACK_SHIPMENT.tr,
                    style: context.bodyLarge.copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ))),
          ),
          GetBuilder<TrackShipmentController>(
            id: "data",
            builder: (context) {
              return Container(
                padding: const EdgeInsets.all(10.0),
                margin: const EdgeInsets.only(
                  left: 10.0,
                  right: 10.0,
                ),
                width: double.maxFinite,
                color: AppColors.white,
                child: FutureBuilder<TrackShipment?>(
                  future: TrackShipmentRepository.getShippingInfo(
                      trackShipment: controller.trackShipment.text.toString()),
                  // ignore: unrelated_type_equality_checks
                  builder: (context, snapshot) => snapshot.data == [] ||
                          snapshot.data == null || snapshot.data!.shippingQuoteProducts!.isEmpty
                      ? const Text(
                          "Sorry, your tracking attempt was not successful. Please check your tracking number.")
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                                alignment: Alignment.topLeft,
                                child: Text(Strings.SHIPMENT_DETAILS.tr,
                                    style: context.bodyLarge.copyWith(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                    ))),
                            const Divider(
                              color: Colors.grey, // Customize the divider color
                              thickness: 1,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(Strings.TRACKING_ID.tr,
                                    style: context.bodyLarge),
                                Text(snapshot.data?.trackingId.toString() ?? "",
                                    style: context.bodyLarge),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(Strings.FROM.tr, style: context.bodyLarge),
                                SizedBox(
                                  width: 172.0,
                                  child: Text(
                                      "${snapshot.data?.from?.country.toString()}, ${snapshot.data?.from?.state.toString()}, ${snapshot.data?.from?.city.toString()}",
                                      maxLines: 2,
                                      style: context.bodyLarge),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(Strings.To.tr, style: context.bodyLarge),
                                SizedBox(
                                  width: 172.0,
                                  child: Text(
                                      "${snapshot.data?.to?.country.toString()}, ${snapshot.data?.to?.state.toString()}, ${snapshot.data?.to?.city.toString()}",
                                      maxLines: 2,
                                      style: context.bodyLarge),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(Strings.SHIPMENT_VIA.tr,
                                    style: context.bodyLarge),
                                Text(snapshot.data?.shipmentVia.toString() ?? "",
                                    style: context.bodyLarge),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(Strings.SHIPMENT_STATUS.tr,
                                    style: context.bodyLarge),
                                Container(
                                  padding: const EdgeInsets.all(7.0),
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.circular(Sizes.RADIUS_6),
                                    color: AppColors.primaryColor,
                                  ),
                                  child: Text(
                                      snapshot.data?.shipmentStatus.toString() ??
                                          "",
                                      style: context.bodyLarge
                                          .copyWith(color: AppColors.white)),
                                ),
                              ],
                            ),
                            Align(
                                alignment: Alignment.topLeft,
                                child: Text(Strings.MORE_DETAILS.tr,
                                    style: context.bodyLarge.copyWith(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                    ))),
                            const Divider(
                              color: Colors.grey, // Customize the divider color
                              thickness: 1,
                            ),
                            ListView.separated(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount:
                                  snapshot.data?.shippingQuoteProducts?.length ?? 0,
                              itemBuilder: (context, index) {
                                var product =
                                    snapshot.data?.shippingQuoteProducts?[index];
                                return Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(Strings.PRODUCT_NAME.tr,
                                            style: context.bodyLarge),
                                        Text(product?.productName ?? "",
                                            style: context.bodyLarge),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(Strings.BOX_SIZE.tr,
                                            style: context.bodyLarge),
                                        Text(
                                            "${product?.length}x${product?.width}x${product?.height}",
                                            style: context.bodyLarge),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(Strings.WEIGHT.tr,
                                            style: context.bodyLarge),
                                        Text("${product?.weight}KG",
                                            style: context.bodyLarge),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(Strings.QUANTITY.tr,
                                            style: context.bodyLarge),
                                        Text("${product?.quantity}",
                                            style: context.bodyLarge),
                                      ],
                                    ),
                                    // Add any additional fields you need here
                                  ],
                                );
                              },
                              separatorBuilder: (context, index) => const Divider(
                                color: Colors.grey, // Customize the divider color
                                thickness: 1,
                              ),
                            ),
                            const Divider(
                              color: Colors.grey, // Customize the divider color
                              thickness: 1,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(Strings.VALUE_OF_PARCEL_.tr,
                                    style: context.bodyLarge),
                                Text(
                                    "${conversionController.convertCurrencyAmt(amount: snapshot.data?.valueOfParcel.toString()).value} ${conversionController.currentCurrency.value}",
                                    style: context.bodyLarge),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(Strings.DESCRIPTION.tr,
                                    style: context.bodyLarge),
                                Text(snapshot.data?.description.toString() ?? "",
                                    style: context.bodyLarge),
                              ],
                            ),
                          ],
                        ),
                ),
              );
            }
          ),
        ],
      )),
    );
  }
}
