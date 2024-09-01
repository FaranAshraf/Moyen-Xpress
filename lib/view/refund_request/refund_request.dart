
import 'package:moyen_express/resources/exports/index.dart';


class RefundRequest extends StatelessWidget {
  const RefundRequest({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: CustomAppBar(title: Strings.REFUND_REQUEST.tr),
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              SpaceH8(),
             RefundRequestForm(),
            ],
          ),
        ),
      )
    );
  }
}