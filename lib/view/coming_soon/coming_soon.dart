import 'package:moyen_express/resources/exports/index.dart';

class ComingSoonView extends StatelessWidget {
  const ComingSoonView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: double.maxFinite,
          height: double.maxFinite,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    Assets.COMING_SOON_PAGE,
                  ),
                  fit: BoxFit.fill)),
          child: Padding(
            padding: const EdgeInsets.only(left: 30, top: 45),
            child: Align(
                alignment: Alignment.topLeft,
                child: Bounce(
                  duration: const Duration(milliseconds: 300),
                  onPressed: () => Get.back(),
                  child: Container(
                    padding: const EdgeInsets.all(1),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: AppColors.black, width: 2),
                        color: Colors.transparent),
                    child: const Icon(
                      Icons.chevron_left,
                      size: 35,
                      color: AppColors.black,
                    ),
                  ),
                )),
          )),
    );
  }
}
