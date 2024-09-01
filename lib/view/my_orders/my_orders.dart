import '../../resources/exports/index.dart';

class MyOrdersView extends StatelessWidget {
  const MyOrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    final MyOrdersController myOrdersController = Get.put(MyOrdersController());
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar:  CustomAppBar(title: Strings.MY_ORDERS.tr),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
              height: 250.0,
              width: double.maxFinite,
              margin: const EdgeInsets.all(12.0),
              child: ImageService.image(Assets.ORDERS_HEADER, scale: 1.1),
            ),
            MyOrdersCard(
                img: Assets.SHIPPING_ORDER,
                title: Strings.SHIPPING_ORDER.tr,
                bkImg: Assets.SHIPPING_ORDER,
                onTap: () => Get.toNamed(Routes.SHIPPING_ORDERS)),
            MyOrdersCard(
                img: Assets.SHIP_QUOTE,
                title: Strings.QUOTES_ORDER.tr,
                bkImg: Assets.SHIP_QUOTE,
                onTap: () {
                  myOrdersController.isShippingQuote.value = true;

                  Get.toNamed(Routes.QUOTE_ORDERS_CARD);
                }),
            MyOrdersCard(
                img: Assets.SHIP_QUOTE,
                title: Strings.SHIPPING_QUOTES.tr,
                bkImg: Assets.SHIP_QUOTE,
                onTap: () {
                  Get.toNamed(Routes.SHIPPING_QUOTE);
                }),
          ],
        ),
      ),
    );
  }
}
