import 'package:moyen_express/resources/exports/index.dart';

import '../../view_model/controllers/gallery_search/gallery_search_controller.dart';

class GallerySearch extends GetView<GalleryController> {
  const GallerySearch({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileController profileController = Get.put(ProfileController());
    return Scaffold(
      appBar: CustomAppBar(title: Strings.GALLERY.tr),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            CustomTextFormField(
              controller: controller.searchController,
              isRequired: false,
              height: Sizes.HEIGHT_16,
              labelText: Strings.SEARCH_IMAGE.tr,
              labelColor: AppColors.black,
              prefixIconColor: AppColors.black,
              textColor: AppColors.black,
              cursorColor: AppColors.black,
              errorColor: AppColors.error,
              enableBorderColor: AppColors.black,
              focusBorderColor: AppColors.primaryColor,
              textInputAction: TextInputAction.next,
              borderRadius: 7.0,
            ),
            const SpaceH10(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomButton.solid(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Wrap(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 7, top: 7),
                              child: ListTile(
                                onTap: profileController.pickImageFromCamera,
                                leading: const Icon(Icons.camera_alt_outlined),
                                title: const Text('Select From Camera'),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 7),
                              child: ListTile(
                                onTap: profileController.pickImageFromGallery,
                                leading: const Icon(Icons.image),
                                title: const Text('Select From Gallery'),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  padding: const EdgeInsets.all(10.0),
                  backgroundColor: AppColors.primaryColor,
                  textColor: AppColors.white,
                  radius: Sizes.RADIUS_6,
                  text: Strings.UPLOAD_FILES,
                ).constrainedBox(maxHeight: 40, maxWidth: 130),
                Row(
                  children: [
                    Text(
                      Strings.SORT_BY.tr,
                      maxLines: 2,
                      style: context.bodyMedium.copyWith(
                        color: AppColors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SpaceW16(),
                    Obx(() => Container(
                          width: 120.0,
                          height: 40,
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.black),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              padding: const EdgeInsets.all(4),
                              value: controller.dropDownValue.value,
                              icon: const Icon(Icons.keyboard_arrow_down),
                              items: controller.items.map((String item) {
                                return DropdownMenuItem(
                                  value: item,
                                  child: SizedBox(
                                    width: 80.0,
                                    child: Text(
                                      item,
                                      overflow: TextOverflow.ellipsis,
                                      style: context.bodyLarge.copyWith(
                                          fontSize: 17,
                                          color:
                                              AppColors.black.withOpacity(0.7)),
                                    ),
                                  ),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                if (newValue != null) {
                                  controller.dropDownValue.value = newValue;
                                  controller.fetchGalleryData();
                                }
                              },
                            ),
                          ),
                        )),
                  ],
                ),
              ],
            ),
            const SpaceH10(),
            Obx(() {
              if (controller.galleryData.value == null) {
                return const Center(child: CircularProgressIndicator());
              } else if (controller.galleryData.value!.uploads?.isEmpty ??
                  true) {
                return const Center(child: Text('No data found'));
              }

              return Expanded(
                child: GridView.builder(
                  itemCount: controller.galleryData.value?.uploads?.length ?? 0,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: Sizes.WIDTH_18,
                    mainAxisSpacing: Sizes.HEIGHT_20,
                    childAspectRatio: 0.5,
                    mainAxisExtent: 150,
                  ),
                  itemBuilder: (context, index) {
                    final upload =
                        controller.galleryData.value?.uploads?[index];
                    return upload != null
                        ? GestureDetector(
                            onTap: () {
                              final box = GetStorage();
                              profileController.id = upload.id;
                              profileController.imageUrl = upload.fileName;
                              box.write("imageUrl", profileController.imageUrl);
                              box.write("imageId", profileController.id);
                              log.e(profileController.id);
                              Get.toNamed(Routes.MY_ACCOUNT);
                            },
                            child: Container(
                              width: 180.0,
                              height: 250.0,
                              decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Column(
                                children: [
                                  Expanded(
                                    child: Image.network(
                                      upload.fileName ?? "",
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      height: double.infinity,
                                    ),
                                  ),
                                  Text(upload.fileOriginalName ?? "",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: context.bodyMedium
                                          .copyWith(fontSize: 17)),
                                ],
                              ),
                            ),
                          )
                        : Container(); // Handle null uploads gracefully
                  },
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
