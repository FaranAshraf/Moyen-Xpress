
import 'package:moyen_express/resources/exports/index.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      body: SizedBox(
      height: double.maxFinite,
      width: double.maxFinite,
      // color: AppColors.b,
      child: Image.asset(
      Assets.ANIMATE_SPLASH,
      width: double.infinity,
      fit: BoxFit.fill,
      ),
    ),
    );
  }
}