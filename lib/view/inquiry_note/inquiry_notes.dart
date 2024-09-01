import 'package:moyen_express/repository/inquiries_repository.dart';
import 'package:moyen_express/resources/exports/index.dart';

import '../../view_model/controllers/inquiry_note/inquiry_notes_controller.dart';

class InquiryNotes extends GetView<InquiryNotesController> {
  const InquiryNotes({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final InquiryNotesController controller = Get.put(InquiryNotesController());
    return Scaffold(
      appBar: CustomAppBar(title: Strings.INQUIRY_NOTES.tr),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: controller.noteKey,
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    Strings.NOTES.tr,
                    style: context.bodyLarge.copyWith(
                        color: AppColors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                CustomTextFormField(
                  controller: controller.note,
                  isRequired: true,
                  height: Sizes.HEIGHT_16,
                  labelText: Strings.ENTER_NOTES.tr,
                  labelColor: AppColors.black,
                  textColor: AppColors.black,
                  cursorColor: AppColors.black,
                  maxLines: 3,
                  borderRadius: 7.0,
                  errorColor: AppColors.error,
                  enableBorderColor: AppColors.black,
                  focusBorderColor: AppColors.primaryColor,
                  textInputAction: TextInputAction.next,
                ),
                const SpaceH4(),
                CustomButton.solid(
                  showIconOnRight: true,
                  text: Strings.ADD_NOTE.tr,
                  backgroundColor: AppColors.primaryColor,
                  textColor: AppColors.white,
                  radius: 5.0,
                  onTap: () {
                    controller.postInquiry();
                    Get.close(-1);
                  },
                ),
                const SpaceH4(),
                const Divider(
                  color: Colors.grey, // Customize the divider color
                  thickness: 1,
                ),
                CustomFutureBuilder(
                    future: InquiriesRepository.getInquiriesNotes(
                        id: controller.id),
                    hasDataBuilder: (context, snapshot) => ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data?.notes.length ?? 0,
                          separatorBuilder: (context, index) => const Divider(
                            color: Colors.grey, // Customize the divider color
                            thickness: 1,
                          ),
                          itemBuilder: (context, index) {
                            return Row(
                              children: [
                                ImageService.image(
                                    snapshot.data?.notes[index].image),
                                const SizedBox(
                                    width: 10), // Adjust spacing as needed
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(snapshot.data?.notes[index].senderName
                                            ?.toString() ??
                                        ""),
                                    Text(snapshot.data?.notes[index].note
                                            ?.toString() ??
                                        ""),
                                  ],
                                ),
                              ],
                            );
                          },
                        )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
