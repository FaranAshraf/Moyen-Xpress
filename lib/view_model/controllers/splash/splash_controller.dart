import '../../../resources/exports/index.dart';

class SplashController extends GetxController {
  final AuthManager authManager = Get.find();

  late RxBool isConnected = false.obs;
  late StreamSubscription<ConnectivityResult> _streamSubscription;

  Future<bool> initializeAuthentication() async {
    return await authManager.checkLoginStatus();
  }

  goto() async {
    await Future.delayed(
      const Duration(seconds: 8),
    );
    Get.offAllNamed(Routes.ONBOARDING);
  }

  @override
  void onInit() async {
    goto();
    super.onInit();
    initializeAuthentication();
    initializeConnectivity();
    checkConnectivityStream();
  }

  void checkConnectivityStream() async {
    _streamSubscription = Connectivity().onConnectivityChanged.listen(
      (status) async {
        switch (status) {
          case ConnectivityResult.ethernet:
          case ConnectivityResult.mobile:
          case ConnectivityResult.wifi:
            if (!isConnected.value) {
              if (!authManager.isLoggedIn) await authManager.checkLoginStatus();

              isConnected.value = true;
              if (WidgetsFlutterBinding.ensureInitialized()
                  .firstFrameRasterized) Get.back();
            }
            break;
          default:
            if (isConnected.value != false) {
              isConnected.value = false;
              if (WidgetsFlutterBinding.ensureInitialized()
                  .firstFrameRasterized) {
                Get.toNamed(Routes.OFFLINE);
              }
            }

            break;
        }
      },
    );
  }

  Future<void> initializeConnectivity() async {
    ConnectivityResult connectionStatus =
        await Connectivity().checkConnectivity();

    switch (connectionStatus) {
      case ConnectivityResult.ethernet:
      case ConnectivityResult.mobile:
      case ConnectivityResult.wifi:
        isConnected = true.obs;
        break;
      default:
        isConnected = false.obs;
        break;
    }
  }

  @override
  void dispose() {
    goto().dispose;
    _streamSubscription.cancel();
    super.dispose();
  }
  
}
