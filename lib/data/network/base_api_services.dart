import '../../resources/exports/index.dart';

abstract class BaseApiServices {
  Future getApi(String url, {Map<String, dynamic>? quaryParameters});
  Future testApi(String url, {Map<String, dynamic>? quaryParameters});
  Future getCheck(String url, {Map<String, dynamic>? quaryParameters});
  Future postApi(String url, Map<String, dynamic> body,{ Map<String, dynamic>? quaryParameters});
  Future<dynamic> postPictureApi(String url, Map<String, dynamic> body, {File? file, Map<String, dynamic>? quaryParameters});
  Future deleteApi(String url,{ Map<String, dynamic>? quaryParameters});
  Future putApi(String url, Map<String, dynamic> body,);
  Future postUpdatedAPI(String url, Map<String, dynamic> body,{ Map<String, dynamic>? quaryParameters});
  Future postPaymentApi(String url, Map<String, dynamic> body);
  Future postPaymentApi1(String url, Map<String, dynamic> body);
  
}
