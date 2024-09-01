import '../../resources/exports/index.dart';

class OnBoarding extends GetView<OnBoardingController> {
  const OnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    final OnBoardingController controller=Get.put(OnBoardingController());
    return Scaffold(
      body: Stack(
        children: [
          GetBuilder<OnBoardingController>(
            id: "update_on_boarding_screen",
            builder: (_) {
              return PageView(
                physics: const ClampingScrollPhysics(),
                controller: controller.pageCtrl,
                children: [
                  Image.asset(Assets.onBoarding1, fit: BoxFit.fill),
                  Image.asset(Assets.onBoarding2, fit: BoxFit.fill),
                  Image.asset(Assets.onBoarding3, fit: BoxFit.fill),
                ],
              );
            },
          ),
          _buildButtons()
        ],
      ),
    );
  }

  Align _buildButtons() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildButton(Strings.SKIP.tr, () => Get.offAllNamed(Routes.DASHBOARD)),
            _buildButton(Strings.NEXT.tr, () => controller.onNext()),
          ],
        ),
      ),
    );
  }

  CustomButton _buildButton(String title, VoidCallback onTap) {
    return CustomButton.solid(
      backgroundColor: AppColors.black,
      text: title.tr,
      radius: Sizes.RADIUS_6,
      textStyle: const TextStyle(
        fontSize: Sizes.TEXT_SIZE_16,
        color: AppColors.white,
      ),
      onTap: onTap,
      hasInfiniteWidth: false,
      constraints: const BoxConstraints(
        maxHeight: Sizes.HEIGHT_50,
        maxWidth: Sizes.WIDTH_100,
        minHeight: Sizes.HEIGHT_50,
        minWidth: Sizes.WIDTH_100,
      ),
    );
  }
}
