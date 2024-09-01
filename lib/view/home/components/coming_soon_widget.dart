import 'package:flutter_polygon/flutter_polygon.dart';
import 'package:moyen_express/resources/exports/index.dart';

class PolygonWidget extends StatelessWidget {
  const PolygonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController homeController=Get.put(HomeController());
    return Obx(()=>
     Bounce(
        duration: const Duration(milliseconds: 300),
        onPressed: ()=>Get.toNamed(Routes.COMING_SOON_SCREEN),
        child: SizedBox(
          height: 110,
          width: 110,
          child: ClipPolygon(
            sides: 7,
            borderRadius: 5.0,
            boxShadows: [
              PolygonBoxShadow(color: Colors.black, elevation: 1.0),
              PolygonBoxShadow(color: Colors.grey, elevation: 5.0)
            ],
            child: Container(
              decoration: const BoxDecoration(color: AppColors.black),
              child: Center(
                child: AnimatedOpacity(
                    opacity: homeController.textChange.value ? 1 : 0,
                    duration: const Duration(milliseconds: 800),
                    child: homeController.textChange.value
                        ? Image.asset(Assets.COMING_SOON,fit: BoxFit.fill,scale: 1.4,)
                        :  Text("Coming\n\t\t\tSoon",style:context.bodyMedium.copyWith(fontWeight: FontWeight.w600,color: AppColors.white))),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

