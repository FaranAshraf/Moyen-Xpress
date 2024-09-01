import '../../resources/exports/index.dart';

class OfflineScreen extends StatelessWidget with PortraitModeMixin {
  static const String routeName = '/offline';

  const OfflineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return LayoutBuilder(
      builder: (context, _) {
        return Container(
          decoration: BoxDecoration(gradient: Gradients.offlineBackground),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Center(
              child: SingleChildScrollView(
                child: Container(
                  width: Responsive.value(
                    mobile: double.infinity,
                    tablet: Get.width * 0.8,
                    desktop: Get.width * 0.5,
                  ),
                  padding: const EdgeInsets.all(Sizes.PADDING_32),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Lottie.asset(
                          Assets.OFFLINE_TREX_LIGHT,
                          height: 200,
                          width: double.infinity,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: Sizes.PADDING_32),
                        child: Text(
                          "You're Offline.",
                          style: context.headlineMedium.copyWith(
                            color: AppColors.secondaryText,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: Sizes.PADDING_32,
                        ),
                        child: Text(
                          "No Internet Connection. Make sure that Wifi or Mobile data is turned on, then try again.",
                          style: context.titleMedium.copyWith(
                            color: AppColors.secondaryText,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void openWifiSettings() async {
    try {
      await AppSettings.openAppSettings(type: AppSettingsType.wifi);
    } on MissingPluginException catch (_) {
      CustomSnackbar.unsupportedPlatform;
    }
  }

  void openDataSettings() async {
    try {
      await AppSettings.openAppSettings(type: AppSettingsType.dataRoaming);
    } on MissingPluginException catch (_) {
      CustomSnackbar.unsupportedPlatform;
    }
  }
}
