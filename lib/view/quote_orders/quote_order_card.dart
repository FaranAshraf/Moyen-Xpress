import 'package:moyen_express/utils/custom_future_cart_builder.dart';

import '../../model/my_orders/quote_orders_model.dart';
import '../../repository/myorders_repository.dart';
import '../../resources/exports/index.dart';

class QuoteOrderView extends StatelessWidget {
  const QuoteOrderView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    final DateFormat dateFormat = DateFormat('yyyy-MM-dd / HH:mm:ss');
    return Scaffold(
      appBar: CustomAppBar(
          title:  Strings.QUOTES_ORDER.tr
                  ),
      body: CustomFutureCartBuilder<List<QuoteOrders>?>(
        customLoader: const ShippingCardPlaceHolder(),
        future: MyOrderRepository.getQuoteHistory(),
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
                  final quote = snapshot.data![index];
                  return CustomCard(
                    status: snapshot.data![index].deliveryStatus,
                    width: double.maxFinite,
                    clr: AppColors.white,
                    title: quote.productName ?? "",
                    orderId: quote.quoteId?.toString() ?? "",
                    oid: Strings.QUOTE_ORDER_ID.tr,
                    orderDate:
                        dateFormat.format(snapshot.data![index].createdAt!),
                    oDate: Strings.DATE.tr,
                    quantity: quote.isPaid == 1 ? "paid" : "unpaid",
                    oQuantity: Strings.PAYMENT_STATUS.tr,
                    totalAmount: quote.paidPayment?.toString() ?? "",
                    oAmount: Strings.TOTAL_AMOUNT,
                    onTap: () {
                      log.e(quote.id.toString());

                      Get.toNamed(Routes.QUOTE_ORDERS_DETAIL,arguments: {
                        "id":quote.id
                      });
                    },
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
