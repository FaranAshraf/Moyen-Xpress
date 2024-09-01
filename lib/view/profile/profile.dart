import 'package:moyen_express/resources/exports/index.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileController controller = Get.put(ProfileController());
    return Scaffold(
      appBar: CustomAppBar(title: Strings.PROFILE.tr),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    const SpaceH10(),
                    Center(
                      child: InkWell(
                        onTap: () {
                          Get.toNamed(Routes.GALLERY_SEARCH);
                          // showModalBottomSheet(
                          //   context: context,
                          //   builder: (context) {
                          //     return Wrap(
                          //       children: [
                          //         Padding(
                          //           padding:
                          //               const EdgeInsets.only(left: 7, top: 7),
                          //           child: ListTile(
                          //             onTap: controller.pickImageFromCamera,
                          //             leading:
                          //                 const Icon(Icons.camera_alt_outlined),
                          //             title: const Text('Select From Camera'),
                          //           ),
                          //         ),
                          //         Padding(
                          //           padding: const EdgeInsets.only(left: 7),
                          //           child: ListTile(
                          //             onTap: controller.pickImageFromGallery,
                          //             leading: const Icon(Icons.image),
                          //             title: const Text('Select From Gallery'),
                          //           ),
                          //         ),
                          //       ],
                          //     );
                          //   },
                          // );
                        },
                        child: Stack(
                            children: [
                              Container(
                                  height: 120,
                                  width: 120,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        width: 4, color: Colors.white),
                                  ),
                                  child:  ImageService.image(
                                         // ignore: prefer_if_null_operators
                                         controller.box.read("imageUrl")==null?
                                          "https://pics.craiyon.com/2023-07-15/dc2ec5a571974417a5551420a4fb0587.webp"
                                          :controller.box.read("imageUrl"),
                                          imageSize: 200.0,
                                          fit: BoxFit.cover,
                                        )),
                              Positioned(
                                bottom: 10,
                                right: 0,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: AppColors.primaryColor,
                                  ),
                                  padding: const EdgeInsets.all(5.0),
                                  child: const Icon(
                                    Icons.camera_alt_outlined,
                                    size: 25,
                                    color: AppColors
                                        .white, // Optional: Set icon color
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    
                    const ProfileForm(),
                  ],
                ),
              ),
            ),
          ),
          CustomButton.solid(
            margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 10.0),
            backgroundColor: AppColors.primaryColor,
            textColor: AppColors.white,
            text: Strings.UPDATE_PROFILE.tr,
            radius: Sizes.RADIUS_6,
            onTapAsync: () => controller.getProfile(),
            constraints: const BoxConstraints(minHeight: 55),
          ),
        ],
      ),
    );
  }
}
