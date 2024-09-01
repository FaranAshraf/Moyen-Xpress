import 'package:moyen_express/repository/send_request_refund_repository.dart';
import 'package:moyen_express/resources/exports/index.dart';

import '../../view_model/controllers/send_replace_request/send_replace_request_controller.dart';

class SendReplaceRequest extends GetView<SendReplaceRequestController> {
  const SendReplaceRequest({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final SendReplaceRequestController controller =
        Get.put(SendReplaceRequestController());
   

    return Scaffold(
        appBar: CustomAppBar(title: Strings.SEND_REPLACE_REQUEST.tr),
        body: CustomFutureBuilder(
            future: SendRefundRequestRepository.sendReplaceRequest(),
            hasDataBuilder: (context, snapshot) => ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data?.length,
                itemBuilder: (context, index) {
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
                        _buildRow(context, Strings.QUANTITY.tr,
                            snapshot.data?[index].quantity.toString() ?? ""),
                        _buildRow(
                            context,
                            Strings.QUANTITY_TYPE.tr,
                            snapshot.data?[index].quantityType.toString() ??
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
