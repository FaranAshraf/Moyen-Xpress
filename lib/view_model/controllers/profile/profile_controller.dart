import 'package:moyen_express/repository/gallery_repository.dart';
import 'package:moyen_express/resources/exports/index.dart';

class ProfileController extends GetxController {
  final box = GetStorage();
  num? id;
  String? imageUrl;
  late TextEditingController nameController;
  late TextEditingController phoneController;
  late TextEditingController oldPasswordController;
  late TextEditingController newPasswordController;
  late TextEditingController confirmPasswordController;
  late TextEditingController changeEmailController;
  late GlobalKey<FormState> emailKey;

  Future<void> updateEmail() async {
    if (emailKey.currentState?.validate() ?? false) {
      await AuthRepository.updateEmail(
        email: changeEmailController.text,
      );
    }
  }

  RxBool newPassword = false.obs;

  void togglePassword() {
    newPassword.value = !newPassword.value;
  }

  RxBool oldPassword = false.obs;

  void toggleOldPassword() {
    oldPassword.value = !oldPassword.value;
  }

  RxBool confirmPassword = false.obs;

  void toggleConfirmPassword() {
    confirmPassword.value = !confirmPassword.value;
  }

  var image = Rx<File?>(null);

  Future<File?> pickImageFromCamera() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      image.value = File(pickedFile.path);
      await postData(); // Post data automatically
      return File(pickedFile.path);
    } else {
      return null;
    }
  }

  Future<File?> pickImageFromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      image.value = File(pickedFile.path);
      await postData(); // Post data automatically
      return File(pickedFile.path);
    } else {
      return null;
    }
  }

  Future<void> getProfile() async {
    await AuthRepository.profileUpdate(
      name: nameController.text,
      phoneNo: phoneController.text,
      newPassword: newPasswordController.text,
      newPasswordConfirmation: confirmPasswordController.text,
      oldPassword: oldPasswordController.text,
      image: box.read("imageId").toString(), // Pass the selected image here
    );
  }

  Future<void> postData() async {
    if (image.value != null) {
      await GalleryRepository.getPackageImage(image.value);
    }
  }

  Future<void> getGalleryData() async {
    await GalleryRepository.getGalleryData();
  }

  @override
  void onInit() {
    emailKey = GlobalKey<FormState>();

    log.e(id);
    getGalleryData();
    nameController = TextEditingController();
    phoneController = TextEditingController();
    oldPasswordController = TextEditingController();
    newPasswordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    changeEmailController = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    changeEmailController.dispose();
    super.dispose();
  }
}
