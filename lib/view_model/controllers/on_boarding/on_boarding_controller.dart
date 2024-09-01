// import '../../../resources/exports/index.dart';

// class OnBoardingController extends GetxController {
//   late PageController pageCtrl;

//   void onNext() {
//     if (pageCtrl.page == 2) {
//       Get.offAllNamed(Routes.DASHBOARD);
//     } else {
//       pageCtrl.nextPage(
//         duration: Durations.medium3,
//         curve: Curves.linear,
//       );
//       update(["update_on_boarding_screen"]);
//     }
//   }

//   RxBool showBanner1=false.obs;
//   RxBool showBanner2=false.obs;
//   RxBool showBanner3=false.obs;
//   void onSkip() {}

//   @override
//   void onInit() {
//     showBanner1.value=true;
//     pageCtrl = PageController(initialPage: 0);
//     super.onInit();
//   }
// }

import '../../../resources/exports/index.dart';

class OnBoardingController extends GetxController {
  late PageController pageCtrl;
  final _storage = GetStorage();
  final String _enteredOnceKey = 'enteredOnce';
 

  @override
  void onInit() {
    super.onInit();
    showBanner1.value = true;
    pageCtrl = PageController(initialPage: 0);

    bool enteredOnce = _storage.read(_enteredOnceKey) ?? false;
    if (enteredOnce) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Get.offNamed(Routes.DASHBOARD);
      });
    } else {
      _storage.write(_enteredOnceKey, true);
    }
  }

  void onNext() {
    if (pageCtrl.page == 2) {
      Get.offAllNamed(Routes.DASHBOARD);
    } else {
      pageCtrl.nextPage(
        duration: Durations.medium3,
        curve: Curves.linear,
      );
      update(["update_on_boarding_screen"]);
    }
  }

  RxBool showBanner1 = false.obs;
  RxBool showBanner2 = false.obs;
  RxBool showBanner3 = false.obs;
  void onSkip() {}
}
