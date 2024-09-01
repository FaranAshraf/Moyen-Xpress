import 'package:moyen_express/resources/exports/index.dart';

import '../../../repository/contact_repository.dart';

class ContactController extends GetxController {
   GlobalKey<FormState> nameKey=GlobalKey<FormState>();
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController msgController;


  Future<void> contactData() async {
    if (nameKey.currentState?.validate() ?? false) {
      await ContactRepository.contactUs(
        name: nameController.text,
        email: emailController.text,
        phone: phoneController.text,
        message: msgController.text,
      );
      onClear();
    }
  }


    onClear() {
    nameController.clear();
    emailController.clear();
    phoneController.clear();
    msgController.clear();
  }
  
  @override
  void onInit() {
    nameKey = GlobalKey<FormState>();
    nameController = TextEditingController();
    emailController = TextEditingController();
    phoneController = TextEditingController();
    msgController = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    msgController.dispose();

    super.dispose();
  }
}
