import 'package:moyen_express/resources/exports/index.dart';

// ignore: must_be_immutable
class MyOrdersCard extends StatelessWidget {
  String img, title, bkImg;
  dynamic onTap;
  MyOrdersCard(
      {Key? key, required this.img, required this.bkImg, required this.title,required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: Get.width * 2,
        height: 90,
        margin: const EdgeInsets.only(left: 10.0, right: 10, top: 20),
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  Assets.SUB_CARD,
                ),
                fit: BoxFit.fill)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            children: [
              ImageService.image(img, scale: 1.8),
              const SpaceW8(),
              Text(
                title,
                style: context.bodyMedium.copyWith(
                    color: AppColors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              ),
              const SpaceW40(),
              ImageService.image(bkImg,
                  imageColor: AppColors.white.withOpacity(0.3)),
            ],
          ),
        ),
      ),
    );
  }
}
