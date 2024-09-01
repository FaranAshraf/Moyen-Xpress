import '../../../resources/exports/index.dart';

class SignInBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => SignInController());
  }
}