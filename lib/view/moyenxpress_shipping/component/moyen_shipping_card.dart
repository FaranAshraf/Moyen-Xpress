import 'package:moyen_express/resources/exports/index.dart';

class MxShippingCard extends StatelessWidget {
  const MxShippingCard({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final MxShippingController controller = Get.put(MxShippingController());
    late GlobalKey<FormState> shippingForm = GlobalKey<FormState>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: AppColors.white, borderRadius: BorderRadius.circular(10)),
        child: Form(
          key: shippingForm,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 10, right: 20),
                child: CustomTextFormField(
                  controller: controller.productNameController,
                  isRequired: true,
                  height: Sizes.HEIGHT_12,
                  labelText: Strings.PRODUCT_NAME.tr,
                  labelColor: AppColors.black.withOpacity(0.5),
                  prefixIconColor: AppColors.black,
                  textColor: AppColors.black,
                  cursorColor: AppColors.black,
                  errorColor: AppColors.error,
                  enableBorderColor: AppColors.black,
                  focusBorderColor: AppColors.primaryColor,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: CustomTextFormField(
                  controller: controller.descriptionController,
                  isRequired: false,
                  maxLines: 5,
                  height: Sizes.HEIGHT_12,
                  labelText: Strings.DESCRIPTION.tr,
                  labelColor: AppColors.black.withOpacity(0.5),
                  prefixIconColor: AppColors.black,
                  textColor: AppColors.black,
                  cursorColor: AppColors.black,
                  errorColor: AppColors.error,
                  enableBorderColor: AppColors.black,
                  focusBorderColor: AppColors.primaryColor,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: CustomTextFormField(
                  controller: controller.quantityController,
                  isRequired: true,
                  height: Sizes.HEIGHT_12,
                  labelText: Strings.ENTER_QUANTITY.tr,
                  labelColor: AppColors.black.withOpacity(0.5),
                  prefixIconColor: AppColors.black,
                  textColor: AppColors.black,
                  cursorColor: AppColors.black,
                  errorColor: AppColors.error,
                  enableBorderColor: AppColors.black,
                  focusBorderColor: AppColors.primaryColor,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: CustomTextFormField(
                  controller: controller.messageController,
                  isRequired: true,
                  height: Sizes.HEIGHT_12,
                  labelText: Strings.DELIVERY_ADDRESS.tr,
                  labelColor: AppColors.black.withOpacity(0.5),
                  prefixIconColor: AppColors.black,
                  textColor: AppColors.black,
                  cursorColor: AppColors.black,
                  errorColor: AppColors.error,
                  enableBorderColor: AppColors.black,
                  focusBorderColor: AppColors.primaryColor,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                ),
              ),
              Obx(() => Container(
                    padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                    margin:
                        const EdgeInsets.only(left: 20, right: 20.0, top: 10.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        border: Border.all(color: AppColors.black, width: 1)),
                    child: DropdownButton<String>(
                      menuMaxHeight: 300,
                      isExpanded: true,
                      iconSize: 30,
                      underline: const SizedBox(),
                      isDense: false,
                      alignment: Alignment.center,
                      dropdownColor: AppColors.white,
                      value: controller.selectedValue.value,
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          controller.setSelectedValue(newValue);
                          log.e(newValue);
                          controller.dataDrop=newValue;
                        }
                      },
                      items: <String>[
                        Strings.PLACE_,
                        Strings.BAGS,
                        Strings.DOZEN,
                        Strings.GALLON,
                        Strings.GRAM,
                        Strings.KILO,
                        Strings.METER,
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  )),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: CustomButton(
                  text: Strings.REQUEST_QUOTE.tr,
                  radius: 5,
                  onTapAsync: () async {
                    if (shippingForm.currentState!.validate()) {
                      await controller.contactData();
                    }
                  },
                  textColor: AppColors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Column successDialog(BuildContext context, dynamic onTap, String title) {
  return Column(
    children: [
      Expanded(
        child: Column(
          children: [
            Lottie.asset(Assets.SUCCESS,
                width: 150, height: 150, fit: BoxFit.fill),
            Text(title,
                textAlign: TextAlign.center,
                style: context.bodyLarge.copyWith(fontSize: 22, height: 1.3))
          ],
        ),
      ),
      CustomButton.solid(
        margin: const EdgeInsets.all(12),
        backgroundColor: Colors.green,
        textColor: AppColors.white,
        text: "OK",
        onTap: onTap,
        radius: Sizes.RADIUS_6,
        constraints: const BoxConstraints(minHeight: 55),
      ),
    ],
  );
}
