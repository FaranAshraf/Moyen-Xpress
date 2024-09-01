
import '../../../resources/exports/index.dart';

class BannerView extends StatelessWidget {
  final String img;
  const BannerView({super.key, required this.img});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: double.maxFinite,
      decoration:  BoxDecoration(
          color: Colors.transparent,
          image: DecorationImage(
              image: AssetImage(img), fit: BoxFit.fill)),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 20, top: 10),
            child: InkWell(
                onTap: () {
                  Get.back();
                },
                child: const Align(
                    alignment: Alignment.topRight,
                    child: Icon(
                      Icons.cancel,
                      color: AppColors.white,
                      size: Sizes.HEIGHT_36,
                    ))),
          )
        ],
      ),
    );
  }
}
