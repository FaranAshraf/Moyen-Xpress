import 'package:moyen_express/resources/exports/index.dart';
import 'package:moyen_express/view_model/controllers/my_account/my_account_controller.dart';

class MyAccount extends StatelessWidget {
  const MyAccount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MyAccountController controller = Get.put(MyAccountController());

    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Get.offNamed(Routes.DASHBOARD),
          child: const Icon(Icons.arrow_back_ios, color: Colors.black),
        ),
        centerTitle: true,
        title: Text(Strings.ACCOUNT.tr),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SpaceH16(),
              Text(
                AuthManager.instance.user?.fullName.capitalizeFirstLetter ?? "",
                style: context.bodyMedium.copyWith(
                  height: 1.1,
                  color: AppColors.primaryColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                AuthManager.instance.user?.emailAddress ?? "",
                style: context.bodyMedium.copyWith(
                  height: 1.1,
                  color: AppColors.primaryColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              // GestureDetector(
              //   onTap: () {
              //     // Add navigation logic to view profile
              //   },
              //   child: Text(
              //     "view profile",
              //     style: context.bodyMedium.copyWith(
              //       color: AppColors.primaryColor,
              //       fontSize: 18,
              //       fontWeight: FontWeight.w600,
              //     ),
              //   ),
              // ),
              const SpaceH10(),
              GetBuilder<MyAccountController>(
                init: MyAccountController(),
                builder: (controller) {
                  return GridView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: controller.checkOut.length,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: Sizes.WIDTH_18,
                      mainAxisSpacing: Sizes.HEIGHT_14,
                      childAspectRatio: 3 / 2,
                    ),
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: controller.checkOut[index]["onTap"],
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(controller.checkOut[index]["color"]),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                controller.checkOut[index]["count"].toString(),
                                style: context.bodyLarge.copyWith(
                                    color: AppColors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 24),
                              ),
                              Text(
                                controller.checkOut[index]["title"],
                                style: context.bodyLarge.copyWith(
                                    color: AppColors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                              Text(
                                controller.checkOut[index]["subtitle"],
                                style: context.bodyMedium.copyWith(
                                  color: AppColors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SpaceH14(),
              Container(
                color: AppColors.white,
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  children: [
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.tabs.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          onTap: controller.tabs[index]["onTap"],
                          leading: Icon(controller.tabs[index]["icon"],
                              color: AppColors.black.withOpacity(0.6)),
                          title: Text(controller.tabs[index]["title"]),
                          trailing: Icon(Icons.chevron_right,
                              color: AppColors.black.withOpacity(0.5)),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return Divider(
                          color: Colors.grey.withOpacity(0.3),
                          thickness: 1,
                          height: 0,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
