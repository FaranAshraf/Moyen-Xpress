import 'package:moyen_express/resources/exports/index.dart';
import 'package:moyen_express/utils/custom_future_cart_builder.dart';

import '../../model/my_orders/shipping_quote_model.dart';
import '../../repository/myorders_repository.dart';
import '../../view_model/controllers/shipping_quotes/shipping_quotes_controller.dart';

class ShippingQuotes extends GetView<ShippingQuoteController> {
  const ShippingQuotes({super.key});

  @override
  Widget build(BuildContext context) {
    final DateFormat dateFormat = DateFormat('yyyy-MM-dd');
    return Scaffold(
      appBar: CustomAppBar(title: Strings.SHIPPING_QUOTES.tr),
      body: CustomFutureCartBuilder<List<ShipmentQuotes>?>(
        customLoader: const ShippingCardPlaceHolder(),
        future: MyOrderRepository.getShippingQuote(),
        hasDataBuilder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Get.toNamed(Routes.SHIPPING_QUOTE_DETAIL,arguments: {
                        "id":snapshot.data?[index].id,
                        "check":1
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 10.0),
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 5.0),
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 2,
                                spreadRadius: 2,
                                offset: const Offset(0, 2),
                                color: AppColors.greyClr.withOpacity(0.3))
                          ],
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.topRight,
                            child: Text(
                              snapshot.data?[index].status ?? "",
                              style: context.bodyLarge.copyWith(
                                  color: AppColors.active,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "${Strings.SHIPPING_QUOTES.tr}:",
                              style: context.bodyLarge.copyWith(
                                  fontSize: 20, fontWeight: FontWeight.w600),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                Strings.QUOTE_ORDER_ID.tr,
                                style: context.bodyMedium.copyWith(
                                    color: AppColors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400),
                              ),
                              Text(
                                snapshot.data?[index].trackingId ?? "",
                                style: context.bodyMedium.copyWith(
                                    color: AppColors.primaryColor,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                Strings.SHIPMENT_DATE.tr,
                                style: context.bodyMedium.copyWith(
                                    color: AppColors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400),
                              ),
                              Text(
                                dateFormat.format(
                                    snapshot.data![index].shipmentDate!),
                                style: context.bodyMedium.copyWith(
                                    color: AppColors.primaryColor,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                Strings.SHIPMENT_FROM.tr,
                                style: context.bodyMedium.copyWith(
                                    color: AppColors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400),
                              ),
                              SizedBox(
                                width: 210,
                                child: Text(
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  "${snapshot.data?[index].fromCityId},${snapshot.data?[index].fromStateId},${snapshot.data?[index].fromCountryId}",
                                  style: context.bodyMedium.copyWith(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                Strings.SHIPMENT_TO.tr,
                                style: context.bodyMedium.copyWith(
                                    color: AppColors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400),
                              ),
                              SizedBox(
                                width: 210,
                                child: Text(
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  "${snapshot.data?[index].toCityId},${snapshot.data?[index].toStateId},${snapshot.data?[index].toCountryId}",
                                  style: context.bodyMedium.copyWith(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400),
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
                                    fontSize: 15, fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                Strings.ADMIN_APPROVAL.tr,
                                style: context.bodyMedium.copyWith(
                                    color: AppColors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400),
                              ),
                              Text(
                                snapshot.data?[index].orderStatus ?? "",
                                style: context.bodyMedium.copyWith(
                                    color: AppColors.active,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          } else {
            return const Center(child: Text('No data available'));
          }
        },
      ),
    );
  }
}
