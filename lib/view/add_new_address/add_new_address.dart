import '../../resources/exports/index.dart';

class AddNewAddress extends GetView<LocationsController> {
  const AddNewAddress({super.key});

  @override
  Widget build(BuildContext context) {
  

    return Scaffold(
      appBar:  CustomAppBar(title: Strings.ADD_NEW_ADDRESS.tr),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
     
                Text(
                  Strings.ADD_NEW_ADDRESS.tr,
                  style: context.headlineSmall.copyWith(
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                  ),
                ),
                Text(
                  Strings.FILL_BELOW_FIELDS.tr,
                  style: context.titleMedium.copyWith(
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SpaceH36(),
                 const AddNewAddressForm(),
                CustomButton.solid(
                  backgroundColor: AppColors.primaryColor,
                  textColor: AppColors.white,
                  text: Strings.SAVE.tr,
                  onTap: () {
                    if (controller.addressForm.currentState!.validate()) {
                      controller.getLocation();
                    }
                  },
                  radius: Sizes.RADIUS_6,
                ),
              ],
            ),
          ),
        ),
      ),
    );
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
}
