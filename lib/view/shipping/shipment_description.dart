import '../../resources/exports/index.dart';

class ShipmentDescription extends GetView<GetQuoteController> {
  const ShipmentDescription({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: Strings.GET_A_QUOTE.tr),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(Strings.SHIPMENT_DESCRIPTION.tr,
                      style: context.bodyLarge.copyWith(
                          color: AppColors.primaryColor,
                          fontSize: Sizes.HEIGHT_24,
                          decorationThickness: 1.5,
                          fontWeight: FontWeight.w600)),
                ),
              ),
              const SpaceH8(),
              const ShipmentDescriptionForm(id: 'form_0'),
              Obx(
                () => ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.generateAddOne.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          const SpaceH8(),
                          const Divider(thickness: 1, color: AppColors.black),
                          const SpaceH8(),
                          ShipmentDescriptionForm(
                            id: 'form_${index + 1}',
                          ),
                        ],
                      );
                    }),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: CustomButton.solid(
                        backgroundColor: AppColors.primaryColor,
                        textColor: AppColors.white,
                        text: Strings.NEXT.tr,
                        onTap: () => Get.toNamed(Routes.PARCEL_DETAIL),
                        radius: Sizes.RADIUS_6,
                        constraints: const BoxConstraints(minHeight: 55),
                      ),
                    ),
                    const SpaceW12(),
                    Expanded(
                      child: CustomButton.solid(
                        backgroundColor: AppColors.cartBtn,
                        textColor: AppColors.white,
                        text: "Add One",
                        onTap: () {
                          controller.generateDynamicWidget();
                          if (kDebugMode) {
                            print(controller.generateAddOne.length);
                          }
                        },
                        radius: Sizes.RADIUS_6,
                        constraints: const BoxConstraints(minHeight: 55),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

