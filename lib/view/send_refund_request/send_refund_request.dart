import 'package:moyen_express/repository/send_request_refund_repository.dart';
import 'package:moyen_express/resources/exports/index.dart';
import 'package:moyen_express/view_model/controllers/send_refund_request/send_refund_request_controller.dart';

import '../../view_model/helpers/global_helper/currency_conversion.dart';

class SendRefundRequest extends GetView<SendRefundRequestController> {
  const SendRefundRequest({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final SendRefundRequestController controller =
        Get.put(SendRefundRequestController());
    final CurrencyConversionController conversionController =
        Get.put(CurrencyConversionController());

    return Scaffold(
        appBar: CustomAppBar(title: Strings.SEND_REFUND_REQUEST.tr),
        body: CustomFutureBuilder(
            future: SendRefundRequestRepository.sendRefundRequest(),
            hasDataBuilder: (context, snapshot) => 
                   ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data?.length,
                      itemBuilder: (context, index) {
                        controller.dropDownValue.value =
                            snapshot.data?[index].dropOffStatus ?? "";
                        return Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 10.0),
                          margin: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 10.0),
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 2,
                                  spreadRadius: 2,
                                  offset: const Offset(0, 2),
                                  color: AppColors.greyClr.withOpacity(0.3),
                                ),
                              ],
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white),
                          child: Column(
                            children: [
                              const SizedBox(height: 5),
                              _buildRow(context, Strings.ORDERS_ID.tr,
                                  snapshot.data?[index].orderId.toString()),
                              _buildRowStatus(context, Strings.STATUS.tr,
                                  snapshot.data?[index].status.toString()),
                              _buildRow(context, Strings.DATE.tr,
                                  snapshot.data?[index].date.toString()),
                              _buildRow(context, Strings.PRODUCT.tr,
                                  snapshot.data?[index].product.toString()),
                              _buildRow(context, Strings.AMOUNT.tr,
                                  "${conversionController.convertCurrencyAmt(amount: snapshot.data?[index].amount.toString()).value} ${conversionController.currentCurrency.value}"),
                              _buildRow(context, Strings.REFUND_TYPE.tr,
                                  snapshot.data?[index].refundType.toString()),
                              _buildRow(
                                  context,
                                  Strings.WAREHOUSE_ADDRESS.tr,
                                  snapshot.data?[index].warehouseAddress
                                      .toString()),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: 170,
                                    child: Text(
                                      Strings.DROP_OFF_ADDRESS.tr,
                                      maxLines: 2,
                                      style: context.bodyMedium.copyWith(
                                        color: AppColors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                  Obx(() => Container(
                                        width: 180.0,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: AppColors.black),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton(
                                            padding: const EdgeInsets.all(4),
                                            value:
                                                controller.dropDownValue.value,
                                            icon: const Icon(
                                                Icons.keyboard_arrow_down),
                                            items: controller.items
                                                .map((String item) {
                                              return DropdownMenuItem(
                                                value: item,
                                                child: SizedBox(
                                                  width: 140.0,
                                                  child: Text(
                                                    item,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: context.bodyLarge
                                                        .copyWith(
                                                            fontSize: 17,
                                                            color: AppColors
                                                                .black
                                                                .withOpacity(
                                                                    0.7)),
                                                  ),
                                                ),
                                              );
                                            }).toList(),
                                            onChanged: controller
                                                        .dropDownValue.value ==
                                                    'Dropped'
                                                ? null
                                                : (String? newValue) async {
                                                    controller.dropDownValue
                                                        .value = newValue!;
                                                    await SendRefundRequestRepository
                                                        .updateDropOffStatus(
                                                            id: snapshot.data?[index].id?.toInt()??0,
                                                            status: newValue);
                                                  },
                                          ),
                                        ),
                                      )),
                                ],
                              ),
                              _buildRow(
                                  context,
                                  Strings.QUANTITY.tr,
                                  snapshot.data?[index].quantity.toString() ??
                                      ""),
                              _buildRow(
                                  context,
                                  Strings.QUANTITY_TYPE.tr,
                                  snapshot.data?[index].quantityType
                                          .toString() ??
                                      ""),
                            ],
                          ),
                        );
                      })));
                
  }

  Widget _buildRow(BuildContext context, String title, String? value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: context.bodyMedium.copyWith(
            color: AppColors.black,
            fontSize: 15,
            fontWeight: FontWeight.w400,
          ),
        ),
        Text(
          value ?? "",
          style: context.bodyMedium.copyWith(
            color: AppColors.black,
            fontSize: 15,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  Widget _buildRowStatus(BuildContext context, String title, String? value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: context.bodyMedium.copyWith(
            color: AppColors.black,
            fontSize: 15,
            fontWeight: FontWeight.w400,
          ),
        ),
        Text(
          value ?? "",
          style: context.bodyMedium.copyWith(
            color: AppColors.primaryColor,
            fontSize: 15,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
/*



*/
