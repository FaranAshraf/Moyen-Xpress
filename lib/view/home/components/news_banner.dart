import 'package:moyen_express/resources/exports/index.dart';

class NewsBanner extends StatelessWidget {
  const NewsBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.put(HomeController());
    return Container(
      height: 40,
      color: AppColors.green,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: CustomFutureBuilder<SuccessContents?>(
              future: HomeRepository.newsBar(),
              hasDataBuilder: (context, snapshot) =>
                  newsBarWidget(snapshot.data!.newsBarText.toString()),
            ),
          ),
          Obx(
            () => Positioned(
              child: Container(
                  height: 60,
                  width: 120,
                  decoration: BoxDecoration(
                      color: homeController.colorChange.value
                          ? AppColors.primaryColor
                          : AppColors.newsColor,
                      borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(25),
                          bottomRight: Radius.circular(25))),
                  child: Column(
                    children: [
                      Text(Strings.LATEST.tr,
                          style: context.bodyMedium
                              .copyWith(color: AppColors.white)),
                      Text(Strings.ANNOUNCEMENT.tr,
                          style: context.bodySmall
                              .copyWith(color: AppColors.white)),
                    ],
                  )),
            ),
          ),
        ],
      ),
    );
  }

  Marquee newsBarWidget(String title) {
    return Marquee(
      accelerationDuration: const Duration(milliseconds: 10),
      decelerationDuration: const Duration(milliseconds: 10),
      text: title.isEmpty ? "Welcome to Moyen Xpress" : title,
      style: const TextStyle(
          fontWeight: FontWeight.normal, fontSize: 15, color: AppColors.white),
      scrollAxis: Axis.horizontal,
      crossAxisAlignment: CrossAxisAlignment.start,
      blankSpace: 20.0,
      velocity: 100.0,
      startPadding: 10.0,
    );
  }
}
