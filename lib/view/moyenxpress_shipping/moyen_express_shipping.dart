

import '../../resources/exports/index.dart';

class MoyenXpressShipping extends GetView<MxShippingController> {
  const MoyenXpressShipping({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: CustomAppBar(title: Strings.MX_SHIPPING.tr),
      body: const SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: HomeShippingCard()),
  );
  }
  }