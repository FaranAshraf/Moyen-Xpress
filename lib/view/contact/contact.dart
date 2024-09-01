import '../../view/contact/component/contact_form.dart';

import '../../resources/exports/index.dart';

class ContactView extends GetView<ContactController> {
  const ContactView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: Strings.CONTACT.tr),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
              height: 200.0,
              width: double.maxFinite,
              margin: const EdgeInsets.all(10.0),
              child: ImageService.image(Assets.CONTACT_HEADER, scale: 1.1),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    Strings.ASK_ANYTHING.tr,
                    style: context.bodyLarge
                        .copyWith(fontSize: 22, fontWeight: FontWeight.w600),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                    "Ask anything because your single word matter to us.",
                    style: context.bodyMedium.copyWith(fontSize: 15)),
              ),
            ),
            const ContactForm(),
            contactMethod(
              context,
              "Info@Moyenxpress.Com",
              EneftyIcons.sms_outline,
            ),
            const SpaceH4(),
            contactMethod(
                context, "PO BOX 48675 Atlanta GA 30362", Assets.ADDRESS_ICON),
            const SpaceH4(),
            contactMethod(
              context,
              "(+1) 8556693697",
              EneftyIcons.call_outline,
            ),
          ],
        ),
      ),
    );
  }

  Row contactMethod(BuildContext context, String title, dynamic icon) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      icon is IconData
          ? Icon(
              icon,
              size: 30,
              color: AppColors.tagGrey,
            )
          : Image.asset(
              icon,
              scale: 3.1,
            ),
      const SpaceW8(),
      Text(
        title,
        style: context.bodyMedium.copyWith(fontSize: 15),
      ),
    ]);
  }
}
