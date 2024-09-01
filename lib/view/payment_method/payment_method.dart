
import '../../resources/exports/index.dart';

class PaymentMethod extends GetView<PaymentMethodController> {
  const PaymentMethod({super.key});

  @override
  Widget build(BuildContext context) {
    final PaymentMethodController controller =
        Get.put(PaymentMethodController());

    return Scaffold(
      appBar: CustomAppBar(title: Strings.PAYMENT_METHOD.tr),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, top: 10.0),
                    child: Text(Strings.SELECT_PAYMENT_TYPE.tr,
                        style: context.bodyLarge.copyWith(
                            fontSize: 20, fontWeight: FontWeight.w500)),
                  ),
                  ListView.separated(
                    padding: const EdgeInsets.all(12.0),
                    itemCount: controller.methods.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () => controller.methods[index]
                            .onTap(), // Call onTap function
                        child: Container(
                          height: 60,
                          width: Get.width,
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          decoration: BoxDecoration(
                            color: controller.methods[index].color,
                            borderRadius: BorderRadius.circular(8.0),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.shadow,
                                offset: const Offset(0.0, 4.0),
                                blurRadius: 4.0,
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                            controller.methods[index].icon),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                      width: 12), // Adjusted from SpaceW12()
                                  Text(
                                    controller.methods[index].title,
                                    style: context.bodyLarge.copyWith(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 17,
                                    ),
                                  ),
                                ],
                              ),
                              GetBuilder<PaymentMethodController>(
                                id: "update_selected_index",
                                builder: (_) {
                                  return controller.selectedIndex ==
                                          controller.methods[index].id
                                      ? const Icon(
                                          Icons.check_circle_outline,
                                          color: Colors.green,
                                          size: 30.0,
                                        )
                                      : const SizedBox();
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (_, __) =>
                        const SizedBox(height: 10), // Adjusted from SpaceH10()
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0, top: 8.0),
                    child: Text(Strings.ESCROW.tr,
                        style: context.bodyLarge.copyWith(
                            fontSize: 20, fontWeight: FontWeight.w600)),
                  ),
                  Row(
                    children: [
                      Obx(() => Checkbox(
                          value: controller.isEscrow.value,
                          onChanged: ((value) {
                            controller.isEscrow.value =
                                !controller.isEscrow.value;
                            if (controller.isEscrow.value == true) {
                              log.e(1);
                              controller.isEscrowChecked.value = 1;
                              log.f(controller.isEscrowChecked.value);
                            } else {
                              controller.isEscrowChecked.value = 0;
                              log.f(controller.isEscrowChecked.value);
                            }
                          }))),
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: SizedBox(
                            width: 360,
                            child: Text(
                              Strings.ESCROW_DESCRIPTION.tr,
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            )),
                      ),
                    ],
                  ),
                  const SpaceH4(),
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0, top: 8.0),
                    child: Text(Strings.ADDITIONAL_INFO.tr,
                        style: context.bodyLarge.copyWith(
                            fontSize: 20, fontWeight: FontWeight.w600)),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: CustomTextFormField(
                      maxLines: 3,
                      controller: controller.additionalInfoCtrl,
                      isRequired: false,
                      height: Sizes.HEIGHT_20,
                      labelText: "Type Your Text",
                      labelColor: AppColors.black.withOpacity(0.5),
                      textColor: AppColors.black,
                      cursorColor: AppColors.black,
                      errorColor: AppColors.error,
                      enableBorderColor: AppColors.black,
                      focusBorderColor: AppColors.primaryColor,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                      borderRadius: 5.0,
                    ),
                  ),
                  const SpaceH10(),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        text: 'By clicking on complete order you will agree',
                        style: context.bodyMedium,
                        children: <TextSpan>[
                          TextSpan(
                              text: ' terms and conditions, return policy',
                              style: context.bodyMedium
                                  .copyWith(color: AppColors.primaryColor),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {}),
                          TextSpan(
                              text: ' &',
                              style: context.bodyMedium,
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {}),
                          TextSpan(
                              text: ' privacy policy',
                              style: context.bodyMedium
                                  .copyWith(color: AppColors.primaryColor),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {}),
                        ]),
                  ),
                ],
              ),
            ),
          ),
        
        ],
      ),
    );
  }
}
