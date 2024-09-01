import 'package:moyen_express/repository/myorders_repository.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../model/my_orders/shipping_quote_detail_model.dart';
import '../../resources/exports/index.dart';
import '../../view_model/controllers/shipping_quotes/shipping_quotes_controller.dart';
import '../../view_model/controllers/shipping_quotes_detail/shipping_quotes_details_Controller.dart';

class ShippingQuoteDetail extends GetView<ShippingQuoteDetailController> {
  const ShippingQuoteDetail({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final ShippingQuoteController controller =
        Get.put(ShippingQuoteController());
    return Scaffold(
      appBar: CustomAppBar(title: controller.check==0?Strings.SHIPPING_ORDER.tr:Strings.SHIPPING_QUOTES.tr),
      body: SingleChildScrollView(
        child: Container(
          width: double.maxFinite,
          margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 10.0),
          color: AppColors.white,
          child: CustomFutureBuilder<QuoteDetail?>(
            customLoader: const ShippingDetailShimmer(),
            future: MyOrderRepository.getQuoteDetail(id: controller.id),
            hasDataBuilder: (context, snapshot) {
              if (kDebugMode) {
                print('Customer Status: ${snapshot.data?.id}');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (snapshot.hasData) {
                return shippingQuoteMethod(context, snapshot);
              } else {
                return const Center(child: Text('No Data Found'));
              }
            },
          ),
        ),
      ),
    );
  }

  Padding shippingQuoteMethod(
      BuildContext context, AsyncSnapshot<QuoteDetail?> snapshot) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Bounce(
              onPressed: () async {
                // ignore: deprecated_member_use
                await launch("https://moyenxpress.com/quote-invoice/${snapshot.data?.id}");
              },
              duration: const Duration(milliseconds: 400),
              child: Container(
                decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(7.0)),
                padding: const EdgeInsets.all(6.0),
                child: Text(
                  Strings.DOWNLOAD_INVOICE.tr,
                  style: context.bodyMedium.copyWith(
                      color: AppColors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              Strings.FROM.tr,
              style: context.bodyLarge
                  .copyWith(fontSize: 20, fontWeight: FontWeight.w600),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
            child: Divider(
              thickness: 0.8,
              color: AppColors.black.withOpacity(0.5),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${Strings.FULL_NAME.tr}:",
                style: context.bodyMedium.copyWith(
                    color: AppColors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
              Text(
                snapshot.data?.fromName ?? "",
                style: context.bodyMedium.copyWith(
                    color: AppColors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${Strings.EMAIL.tr}:",
                style: context.bodyMedium.copyWith(
                    color: AppColors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
              Text(
                snapshot.data?.fromEmail ?? "",
                style: context.bodyMedium.copyWith(
                    color: AppColors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${Strings.COUNTRY.tr}:",
                style: context.bodyMedium.copyWith(
                    color: AppColors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
              Text(
                snapshot.data?.fromCountryId ?? "",
                style: context.bodyMedium.copyWith(
                    color: AppColors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${Strings.STATE.tr}:",
                style: context.bodyMedium.copyWith(
                    color: AppColors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
              Text(
                snapshot.data?.fromStateId ?? "",
                style: context.bodyMedium.copyWith(
                    color: AppColors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${Strings.CITY.tr}:",
                style: context.bodyMedium.copyWith(
                    color: AppColors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
              Text(
                snapshot.data?.fromCityId ?? "",
                style: context.bodyMedium.copyWith(
                    color: AppColors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${Strings.POSTAL_CODE.tr}:",
                style: context.bodyMedium.copyWith(
                    color: AppColors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
              Text(
                snapshot.data?.fromPostalCode ?? "",
                style: context.bodyMedium.copyWith(
                    color: AppColors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${Strings.PHONE_NUMBER.tr}:",
                style: context.bodyMedium.copyWith(
                    color: AppColors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
              Text(
                snapshot.data?.fromPhone ?? "",
                style: context.bodyMedium.copyWith(
                    color: AppColors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${Strings.ADDRESS1.tr}:",
                style: context.bodyMedium.copyWith(
                    color: AppColors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
              Text(
                snapshot.data?.fromAddress1 ?? "",
                style: context.bodyMedium.copyWith(
                    color: AppColors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${Strings.ADDRESS_2.tr}:",
                style: context.bodyMedium.copyWith(
                    color: AppColors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
              Text(
                snapshot.data?.fromAddress2 ?? "",
                style: context.bodyMedium.copyWith(
                    color: AppColors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
            ],
          ),
          const SpaceH10(),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              Strings.To.tr,
              style: context.bodyLarge
                  .copyWith(fontSize: 20, fontWeight: FontWeight.w600),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
            child: Divider(
              thickness: 0.8,
              color: AppColors.black.withOpacity(0.5),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${Strings.FULL_NAME.tr}:",
                style: context.bodyMedium.copyWith(
                    color: AppColors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
              Text(
                snapshot.data?.toName ?? "",
                style: context.bodyMedium.copyWith(
                    color: AppColors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${Strings.EMAIL.tr}:",
                style: context.bodyMedium.copyWith(
                    color: AppColors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
              Text(
                snapshot.data?.toEmail ?? "",
                style: context.bodyMedium.copyWith(
                    color: AppColors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${Strings.COUNTRY.tr}:",
                style: context.bodyMedium.copyWith(
                    color: AppColors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
              Text(
                snapshot.data?.toCountryId ?? "",
                style: context.bodyMedium.copyWith(
                    color: AppColors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${Strings.STATE.tr}:",
                style: context.bodyMedium.copyWith(
                    color: AppColors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
              Text(
                snapshot.data?.toStateId ?? "",
                style: context.bodyMedium.copyWith(
                    color: AppColors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${Strings.CITY.tr}:",
                style: context.bodyMedium.copyWith(
                    color: AppColors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
              Text(
                snapshot.data?.toCityId ?? "",
                style: context.bodyMedium.copyWith(
                    color: AppColors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${Strings.POSTAL_CODE.tr}:",
                style: context.bodyMedium.copyWith(
                    color: AppColors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
              Text(
                snapshot.data?.toPostalCode ?? "",
                style: context.bodyMedium.copyWith(
                    color: AppColors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${Strings.PHONE_NUMBER.tr}:",
                style: context.bodyMedium.copyWith(
                    color: AppColors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
              Text(
                snapshot.data?.toPhone ?? "",
                style: context.bodyMedium.copyWith(
                    color: AppColors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${Strings.ADDRESS1.tr}:",
                style: context.bodyMedium.copyWith(
                    color: AppColors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
              Text(
                snapshot.data?.toAddress1 ?? "",
                style: context.bodyMedium.copyWith(
                    color: AppColors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${Strings.ADDRESS_2.tr}:",
                style: context.bodyMedium.copyWith(
                    color: AppColors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
              Text(
                snapshot.data?.toAddress2 ?? "",
                style: context.bodyMedium.copyWith(
                    color: AppColors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
            ],
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              Strings.PACKAGE_DESCRIPTION.tr,
              style: context.bodyLarge
                  .copyWith(fontSize: 20, fontWeight: FontWeight.w600),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
            child: Divider(
              thickness: 0.8,
              color: AppColors.black.withOpacity(0.5),
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: snapshot.data?.products?.length,
            itemBuilder: (context, index) => Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${Strings.PRODUCT_NAME.tr}:",
                      style: context.bodyMedium.copyWith(
                          color: AppColors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    ),
                    Text(
                      snapshot.data?.products?[index].productName ?? "",
                      style: context.bodyMedium.copyWith(
                          color: AppColors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${Strings.BOX_SIZE.tr}:",
                      style: context.bodyMedium.copyWith(
                          color: AppColors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    ),
                    Text(
                      "${snapshot.data?.products?[index].length}x${snapshot.data?.products?[index].width}x${snapshot.data?.products?[index].height}",
                      style: context.bodyMedium.copyWith(
                          color: AppColors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${Strings.QUANTITY.tr}:",
                      style: context.bodyMedium.copyWith(
                          color: AppColors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    ),
                    Text(
                      snapshot.data?.products?[index].quantity.toString() ?? "",
                      style: context.bodyMedium.copyWith(
                          color: AppColors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${Strings.WEIGHT.tr}:",
                      style: context.bodyMedium.copyWith(
                          color: AppColors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    ),
                    Text(
                      "${snapshot.data?.products?[index].weight} KG",
                      style: context.bodyMedium.copyWith(
                          color: AppColors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              "${Strings.SHIPMENT_DETAILS.tr}:",
              style: context.bodyLarge
                  .copyWith(fontSize: 20, fontWeight: FontWeight.w600),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
            child: Divider(
              thickness: 0.8,
              color: AppColors.black.withOpacity(0.5),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                Strings.QUOTE_ID.tr,
                style: context.bodyMedium.copyWith(
                    color: AppColors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
              Text(
                snapshot.data?.trackingId ?? "",
                style: context.bodyMedium.copyWith(
                    color: AppColors.primaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${Strings.FULL_NAME.tr}:",
                style: context.bodyMedium.copyWith(
                    color: AppColors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
              Text(
                snapshot.data?.fromName ?? "",
                style: context.bodyMedium.copyWith(
                    color: AppColors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${Strings.COUNTRY.tr}:",
                style: context.bodyMedium.copyWith(
                    color: AppColors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
              Text(
                snapshot.data?.fromCountryId ?? "",
                style: context.bodyMedium.copyWith(
                    color: AppColors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${Strings.PICKUP_DATE.tr}:",
                style: context.bodyMedium.copyWith(
                    color: AppColors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
              Text(
                snapshot.data?.shipmentDate ?? "",
                style: context.bodyMedium.copyWith(
                    color: AppColors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${Strings.ADDRESS1.tr}:",
                style: context.bodyMedium.copyWith(
                    color: AppColors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
              Text(
                snapshot.data?.fromAddress1 ?? "",
                style: context.bodyMedium.copyWith(
                    color: AppColors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${Strings.ADDRESS_2.tr}:",
                style: context.bodyMedium.copyWith(
                    color: AppColors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
              Text(
                snapshot.data?.fromAddress2 ?? "",
                style: context.bodyMedium.copyWith(
                    color: AppColors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${Strings.PAYMENT_STATUS.tr}:",
                style: context.bodyMedium.copyWith(
                    color: AppColors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.0),
                  color: snapshot.data?.isCustomerPaid == 0
                      ? AppColors.error
                      : AppColors.success,
                ),
                child: Text(
                  snapshot.data?.isCustomerPaid == 0 ? "UnPaid" : "Paid",
                  style: context.bodyMedium.copyWith(
                      color: AppColors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ],
          ),
          const SpaceH16(),
        ],
      ),
    );
  }
}
