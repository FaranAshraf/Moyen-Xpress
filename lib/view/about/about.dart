import 'package:moyen_express/resources/exports/index.dart';

class AboutView extends StatelessWidget {
  const AboutView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:  CustomAppBar(title: Strings.ABOUT.tr),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 250.0,
                width: double.maxFinite,
                margin: const EdgeInsets.all(10.0),
                child: ImageService.image(Assets.ABOUT_CARD, scale: 1.1),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      Strings.HEAD1_ABOUT.tr,
                      style: context.bodyLarge
                          .copyWith(fontSize: 18, fontWeight: FontWeight.w600),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      Strings.DESC_ABOUT.tr,
                      style: context.bodyLarge
                          .copyWith(fontSize: 14, fontWeight: FontWeight.w300),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 8),
                child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      Strings.DESC1_ABOUT.tr,
                      style: context.bodyLarge
                          .copyWith(fontSize: 14, fontWeight: FontWeight.w300),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10,top: 10,bottom: 5),
                child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      Strings.HEAD2_ABOUT.tr,
                      style: context.bodyLarge
                          .copyWith(fontSize: 18, fontWeight: FontWeight.w600),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      Strings.DESC2_ABOUT.tr,
                      style: context.bodyLarge
                          .copyWith(fontSize: 14, fontWeight: FontWeight.w300),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 8),
                child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      Strings.DESC3_ABOUT.tr,
                      style: context.bodyLarge
                          .copyWith(fontSize: 14, fontWeight: FontWeight.w300),
                    )),
              ),
            ],
          ),
        ));
  }
}
