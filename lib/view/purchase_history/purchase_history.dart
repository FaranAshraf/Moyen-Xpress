import 'package:moyen_express/repository/purchase_repository.dart';
import 'package:moyen_express/utils/custom_future_cart_builder.dart';

import '../../resources/exports/index.dart';
import '../../utils/custom_purchase.dart';

class PurchaseHistory extends GetView<PurchasingHistoryController> {
  const PurchaseHistory({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final PurchasingHistoryController controller =
        Get.put(PurchasingHistoryController());
     final DateFormat dateFormat = DateFormat('yyyy-MM-dd / HH:mm:ss');
    return Scaffold(
      appBar: CustomAppBar(title: Strings.PURCHASE_HISTORY.tr),
      body: CustomFutureCartBuilder(
        customLoader: const ShippingCardPlaceHolder(),
        future: PurchaseRepository
            .getPurchaseHistory(), // Use getQuoteDetail() function here
        hasDataBuilder: (context, snapshot) => ListView.builder(
          itemCount: snapshot.data?.length,
          itemBuilder: (context, index) => CustomCardPurchase(
          clr: AppColors.white,
          orderId: snapshot.data?[index].code.toString() ?? "",
          oid: Strings.PURCHASE_ID.tr,
          orderDate: dateFormat.format(snapshot.data![index].createdAt!),
          oDate:Strings.PURCHASE_DATE.tr ,
          totalAmount: snapshot.data?[index].grandTotal.toString() ?? "",
          oAmount: Strings.TOTAL_AMOUNT.tr,
          status: snapshot.data?[index].deliveryStatus.toString() ?? "",
          onTap: () => Get.toNamed(Routes.PURCHASE_DETAIL,arguments: {
            "id":snapshot.data![index].id.toString(),
            "purchaseId":snapshot.data![index].code.toString(),
            "dateTime":dateFormat.format(snapshot.data![index].createdAt!),
          }),
                      ),
        ),
      ),
    );
  }
}
