import 'package:moyen_express/view/moyenxpress_shipping/component/moyen_shipping_card.dart';

import '../../../resources/exports/index.dart';

class HomeShippingCard extends StatelessWidget {
  const HomeShippingCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Container(
            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(15),
                image: const DecorationImage(
                    image: AssetImage(Assets.SHIP_CARD), fit: BoxFit.fill)),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    Strings.MOYENXPRESS.tr,
                    style: context.headlineMedium.copyWith(
                      color: AppColors.white,
                      fontSize: 22,
                      height: 0.7,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    Strings.SHIPPING.tr,
                    style: context.headlineMedium.copyWith(
                      color: AppColors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  shippingMethod(context, Assets.TRUCK,
                      Strings.SHIPCARD_HEAD1.tr, Strings.SHIPCARD_DESC1.tr),
                  const SpaceH10(),
                  shippingMethod(context, Assets.JET, Strings.SHIPCARD_HEAD2.tr,
                      Strings.SHIPCARD_DESC2.tr),
                ],
              ),
            ),
          ),
        ),
        const SpaceH12(),
        Text(
          Strings.MX_SHIPPING.tr,
          textAlign: TextAlign.center,
          style: context.headlineMedium.copyWith(
            color: AppColors.black,
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, top: 4, right: 20),
          child: Text(
            Strings.MX_SHIPPING_DISC.tr,
            textAlign: TextAlign.center,
            style: context.headlineMedium.copyWith(
              fontSize: 15,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        const MxShippingCard(),
      ],
    );
  }

  Widget shippingMethod(BuildContext context, String img, String txt1, txt2) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            img,
            scale: 1.8,
          ),
          const SpaceW8(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: Sizes.WIDTH_300,
                child: Text(
                  txt1,
                  overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                
                  style: context.headlineMedium.copyWith(
                    color: AppColors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(
                width: Sizes.WIDTH_300,
                child: Text(
                  txt2,
                  overflow: TextOverflow.clip,
                  maxLines: 3,
                  style: context.bodyMedium.copyWith(
                    color: AppColors.white,
                    fontSize: 16,
                    // fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
