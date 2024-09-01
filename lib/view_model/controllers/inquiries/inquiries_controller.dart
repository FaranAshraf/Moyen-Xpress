import 'package:moyen_express/repository/inquiries_repository.dart';

import '../../../resources/exports/index.dart';
class InquiriesController extends GetxController{
  Future<void> myInquiries()async{
    await InquiriesRepository.getInquiries();
  }


  @override
  void onInit() {
    myInquiries();
    super.onInit();
  }
}