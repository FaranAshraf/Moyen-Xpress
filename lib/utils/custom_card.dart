import 'package:moyen_express/view_model/helpers/global_helper/currency_conversion.dart';

import '../resources/exports/index.dart';

// ignore: must_be_immutable
class CustomCard extends StatelessWidget {
  double? width;
  double? height;
  String? img;
  String? title;
  Color? clr;
  String? orderId;
  String? oid;
  String? orderDate;
  String? oDate;
  String? quantity;
  String? oQuantity;
  String? totalAmount;
  String? oAmount;
  String? status;
  final dynamic onTap;

  CustomCard({super.key, 
    this.width,
    this.height,
    this.clr,
    this.title,
    this.img,
    this.orderId,
    this.orderDate,
    this.quantity,
    this.totalAmount,
    this.onTap,
    this.oid,
    this.oDate,
    this.oQuantity,
    this.status,
    this.oAmount,
  });

  @override
  Widget build(BuildContext context) {
    final CurrencyConversionController conversionController =
        Get.put(CurrencyConversionController());
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10.0),
        margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        width: width,
        height: height,
        decoration:
            BoxDecoration(
               boxShadow: [
          
          BoxShadow(
              blurRadius: 2,
              spreadRadius: 2,
              offset: const Offset(0, 2),
              color: AppColors.greyClr.withOpacity(0.3))
        ],
              
              borderRadius: BorderRadius.circular(10), color: clr),
        child: Padding(
          padding: const EdgeInsets.only(left: 3),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Text(
                  status ?? "",
                  style: context.bodyMedium.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                    color: AppColors.completed,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title ?? "",
                    style: context.bodyMedium.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 17,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(oid ?? "", style: context.bodyMedium),
                      Text(
                        orderId ?? "",
                        style: context.bodyMedium.copyWith(
                          fontSize: 16,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: [
                      Text(oDate ?? "", style: context.bodyMedium),
                      // Use oDate instead of orderDate for consistency
                      Text(
                        orderDate ?? "",
                        overflow: TextOverflow.clip,
                        style: context.bodyMedium.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: [
                      Text(oQuantity ?? "", style: context.bodyMedium),
                      Text(
                        quantity ?? "",
                        style: context.bodyMedium.copyWith(
                          fontSize: 16,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ],
                  ),
                  // Ensure oAmount and totalAmount are not null before accessing them
                  if (oAmount != null && totalAmount != null)
                    Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: [
                        Text(oAmount!, style: context.bodyMedium),
                        Text(
                          '${conversionController.convertCurrencyAmt(amount: totalAmount).value} ${conversionController.currentCurrency.value}',
                          style: context.bodyMedium.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    )
                  else
                    const SpaceH10()
                ],
              ),
             
            ],
          ),
        ),
      ),
    );
  }

  Column warningDialog(BuildContext context, dynamic onTap) {
    return Column(
      children: [
        Expanded(
          child: Column(
            children: [
              Lottie.asset(
                Assets.WARNING,
                width: 150,
                height: 150,
                fit: BoxFit.fill,
              ),
              Text(
                "Are You Sure!",
                textAlign: TextAlign.center,
                style: context.bodyLarge.copyWith(fontSize: 22, height: 1.3),
              ),
            ],
          ),
        ),
        Row(
          children: [
            Flexible(
              child: CustomButton.solid(
                margin: const EdgeInsets.all(12),
                backgroundColor: AppColors.error,
                textColor: AppColors.white,
                text: "Yes",
                onTap: () => Get.toNamed(Routes.DASHBOARD),
                radius: Sizes.RADIUS_6,
                constraints: const BoxConstraints(minHeight: 55),
              ),
            ),
            Flexible(
              child: CustomButton.solid(
                margin: const EdgeInsets.all(12),
                backgroundColor: Colors.green,
                textColor: AppColors.white,
                text: "No",
                onTap: onTap,
                radius: Sizes.RADIUS_6,
                constraints: const BoxConstraints(minHeight: 55),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
