import 'package:moyen_express/resources/exports/index.dart';


class GetAQuote extends GetView<GetQuoteController> {
  const GetAQuote({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  CustomAppBar(title: Strings.GET_A_QUOTE.tr),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 250.0,
                    width: double.maxFinite,
                    margin: const EdgeInsets.all(12.0),
                    child: ImageService.image(Assets.QUOTE_CART, scale: 1.1),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(Strings.SHIPMENT_FORM.tr,
                        style: context.bodyLarge.copyWith(
                            fontSize: 24, fontWeight: FontWeight.w600)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, bottom: 3),
                    child: Text(
                      "I am a:",
                      style: context.bodyMedium.copyWith(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    child: Obx(() => SizedBox(
                          width: double.maxFinite,
                          height: Sizes.HEIGHT_60,
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.black),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                padding: const EdgeInsets.all(8),
                                value: controller.dropDownValue.value,
                                icon: const Icon(Icons.keyboard_arrow_down),
                                items: controller.items.map((String item) {
                                  return DropdownMenuItem(
                                    value: item,
                                    child: Row(
                                      children: [
                                        Text(
                                          item,
                                          style: context.bodyLarge.copyWith(
                                              fontSize: 17,
                                              color:
                                                  AppColors.black.withOpacity(0.7)),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  controller.dropDownValue.value = newValue!;
                                  
                                },
                              ),
                            ),
                          ),
                        )),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 15, top: 10, bottom: 3),
                    child: Text(
                      "I want to ship:",
                      style: context.bodyMedium.copyWith(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Obx(() => SizedBox(
                          width: double.maxFinite,
                          height: Sizes.HEIGHT_60,
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.black),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                padding: const EdgeInsets.all(8),
                                value: controller.dropDownValue1.value,
                                icon: const Icon(Icons.keyboard_arrow_down),
                                items: controller.items1.map((String item) {
                                  return DropdownMenuItem(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: context.bodyLarge.copyWith(
                                          fontSize: 17,
                                          color:
                                              AppColors.black.withOpacity(0.7)),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  controller.dropDownValue1.value = newValue!;
                                  controller.itemType=newValue;
                                  log.e(controller.itemType);
                                },
                              ),
                            ),
                          ),
                        )),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 15, top: 10, bottom: 3),
                    child: Text(
                      "My shipping is:",
                      style: context.bodyMedium.copyWith(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Obx(() => SizedBox(
                          width: double.maxFinite,
                          height: Sizes.HEIGHT_60,
                          child: Container(
                            decoration: BoxDecoration(
                             border: Border.all(color: AppColors.black),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                padding: const EdgeInsets.all(8),
                                value: controller.dropDownValue2.value,
                                icon: const Icon(Icons.keyboard_arrow_down),
                                items: controller.items2.map((String item) {
                                  return DropdownMenuItem(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: context.bodyLarge.copyWith(
                                          fontSize: 17,
                                          color:
                                              AppColors.black.withOpacity(0.7)),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  controller.dropDownValue2.value = newValue!;
                                  controller.shipType=newValue;
                                  log.e(controller.shipType);
                                },
                              ),
                            ),
                          ),
                        )),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 15, top: 10, bottom: 3),
                    child: Text(
                      "Ship via:",
                      style: context.bodyMedium.copyWith(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Obx(() => SizedBox(
                          width: double.maxFinite,
                          height: Sizes.HEIGHT_60,
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.black),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                padding: const EdgeInsets.all(8),
                                value: controller.dropDownValue3.value,
                                icon: const Icon(Icons.keyboard_arrow_down),
                                items: controller.items3.map((String item) {
                                  return DropdownMenuItem(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: context.bodyLarge.copyWith(
                                          fontSize: 17,
                                          color:
                                              AppColors.black.withOpacity(0.7)),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  controller.dropDownValue3.value = newValue!;
                                  controller.shipVia=newValue;
                                  log.e(controller.shipVia);
                                },
                              ),
                            ),
                          ),
                        )),
                  ),
                ],
              ),
            ),
          ),
          CustomButton.solid(
            margin: const EdgeInsets.all(16.0),
            backgroundColor: AppColors.primaryColor,
            textColor: AppColors.white,
            text: Strings.NEXT.tr,
            onTap: () => Get.toNamed(Routes.FROM_FORM_QUOTE),
            radius: Sizes.RADIUS_6,
            constraints: const BoxConstraints(minHeight: 55),
          ),
        ],
      ),
    );
  }
}
