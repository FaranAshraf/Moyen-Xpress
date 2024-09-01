// ignore_for_file: depend_on_referenced_packages

import '../../resources/exports/index.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:http_parser/http_parser.dart';

class NetworkApiServices extends BaseApiServices {
  static Map<String, String> generateHeaders() {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'AppToken': FlutterConfig.get('appToken'),
      if (AuthManager.instance.session.value?.user?.token == null) ...{
        'UserID': "",
        'Authorization': 'Bearer ',
      } else ...{
        'UserID': AuthManager.instance.session.value!.user!.userID.toString(),
        'Authorization':
            'Bearer ${AuthManager.instance.session.value!.user!.token!}',
      },
    };
    return headers;
  }

  @override
  Future postApi(String url, Map<String, dynamic>? body,
      {Map<String, dynamic>? quaryParameters}) async {
    try {
      // Construct Uri with query parameters if provided
      Uri uri = Uri.https(
        FlutterConfig.get('baseUrl'),
        url,
        quaryParameters,
      );

      http.Response response = await http
          .post(
            uri,
            headers: generateHeaders(),
            body: jsonEncode(body),
          )
          .timeout(const Duration(seconds: 10));

      ApiResponse data = ApiResponse.fromJson(validateResponse(response));

      return data.successContents;
    } on SocketException {
      return CustomSnackBar.showSnackBar(
        message: 'You are offline. Please connect to internet first.',
        snackBarStyle: SnackBarStyle.info,
      );
    } catch (e) {
      return false;
    }
  }

  @override
  Future postPictureApi(String url, Map<String, dynamic> body,
      {File? file, Map<String, dynamic>? quaryParameters}) async {
    try {
      Uri uri = Uri.https(
        FlutterConfig.get('baseUrl'),
        url,
        quaryParameters,
      );

      var request = http.MultipartRequest('POST', uri);

      body.forEach((key, value) {
        request.fields[key] = value;
      });

      var fileExtension = path.extension(file!.path);
      var fileName = path.basename(file.path);

      request.files.add(await http.MultipartFile.fromPath(
        'ss_attachment',
        file.path,
        contentType: MediaType(
            'image',
            fileExtension.replaceFirst(
                '.', '')), // guessing mime type from file extension
        filename: fileName,
      ));

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      ApiResponse data = ApiResponse.fromJson(validateResponse(response));
      return data.message;
    } on SocketException {
      return CustomSnackBar.showSnackBar(
        message: 'You are offline. Please connect to internet first.',
        snackBarStyle: SnackBarStyle.info,
      );
    } catch (e) {
      return false;
    }
  }

  @override
  Future postUpdatedAPI(String url, Map<String, dynamic>? body,
      {Map<String, dynamic>? quaryParameters}) async {
    try {
      http.Response response = await http
          .post(
            Uri.https(FlutterConfig.get('baseUrl'), url, quaryParameters),
            headers: generateHeaders(),
            body: jsonEncode(body),
          )
          .timeout(const Duration(seconds: 10));

      ApiResponse data = ApiResponse.fromJson(validateResponse(response));

      return data.message;
    } on SocketException {
      return CustomSnackBar.showSnackBar(
        message: 'You are offline. Please connect to internet first .',
        snackBarStyle: SnackBarStyle.info,
      );
    } catch (e) {
      return false;
    }
  }

  @override
  Future postPaymentApi(String url, Map<String, dynamic> body) async {
    try {
      http.Response response = await http
          .post(
            Uri.https(FlutterConfig.get('baseUrl'), url),
            headers: generateHeaders(),
            body: jsonEncode(body),
          )
          .timeout(const Duration(seconds: 10));

      ApiResponse data = ApiResponse.fromJson(validateResponse(response));

      return data.combinedOrderId;
    } on SocketException {
      return CustomSnackBar.showSnackBar(
        message: 'You are offline. Please connect to internet first .',
        snackBarStyle: SnackBarStyle.info,
      );
    } catch (e) {
      return false;
    }
  }

  @override
  Future postPaymentApi1(String url, Map<String, dynamic> body) async {
    try {
      http.Response response = await http
          .post(
            Uri.https(FlutterConfig.get('baseUrl'), url),
            headers: generateHeaders(),
            body: jsonEncode(body),
          )
          .timeout(const Duration(seconds: 10));

      ApiResponse data = ApiResponse.fromJson(validateResponse(response));
      return data.orderId;
    } on SocketException {
      return CustomSnackBar.showSnackBar(
        message: 'You are offline. Please connect to internet first .',
        snackBarStyle: SnackBarStyle.info,
      );
    } catch (e) {
      return false;
    }
  }
String baseUrl = FlutterConfig.get('baseUrl');
  @override
  Future getApi(
    String url, {
    Map<String, dynamic>? quaryParameters,
  }) async {
   Map<String,dynamic>? queryParams = quaryParameters?.map((key, value) => MapEntry(key, value.toString()));
    try {
      Uri uri;
      ApiResponse data;

      if (queryParams != null) {
        uri = Uri.https(
          baseUrl,
          url,
          queryParams,
        );
      } else {
        uri = Uri.https(baseUrl, url);
      }
print('--------------------------------${uri}-----------------------------');
      http.Response response =
          await http.get(uri, headers: generateHeaders()).timeout(
                const Duration(seconds: 10),
              );

      data = ApiResponse.fromJson(validateResponse(response));

      return data.successContents;
    } on SocketException {
      return CustomSnackBar.showSnackBar(
        message: 'You are offline. Please connect to internet first .',
        snackBarStyle: SnackBarStyle.failure,
      );
    } catch (e) {
      print("___________________________${e}________________________");
      return false;
    }
  }

  @override
  Future putApi(String url, Map<String, dynamic> body) async {
    try {
      if (kDebugMode) {
        print(
            "Making PUT request to: ${Uri.https(FlutterConfig.get('baseUrl'), url)}");
        print("Request body: ${jsonEncode(body)}");
      }

      http.Response response = await http
          .put(
            Uri.https(FlutterConfig.get('baseUrl'), url),
            headers: generateHeaders(),
            body: jsonEncode(body),
          )
          .timeout(const Duration(seconds: 10));

      if (kDebugMode) {
        print("Response status: ${response.statusCode}");
        print("Response body: ${response.body}");
      }

      ApiResponse data = ApiResponse.fromJson(validateResponse(response));

      if (data.message is String) {
        return data.message;
      } else {
        if (kDebugMode) {
          print(
              "Unexpected response type: ${data.successContents.runtimeType}");
        }
        return false;
      }
    } on SocketException {
      CustomSnackBar.showSnackBar(
        message: 'You are offline. Please connect to internet first.',
        snackBarStyle: SnackBarStyle.info,
      );
      return false;
    } catch (e) {
      if (kDebugMode) {
        print("Error occurred: $e");
      }
      return false;
    }
  }

  @override
  Future deleteApi(String url, {Map<String, dynamic>? quaryParameters}) async {
    try {
      Uri uri;
      ApiResponse data;
      uri = Uri.https(
        FlutterConfig.get('baseUrl'),
        url,
        quaryParameters!.map((key, value) => MapEntry(key, value.toString())),
      );
      http.Response response =
          await http.delete(uri, headers: generateHeaders()).timeout(
                const Duration(seconds: 10),
              );

      data = ApiResponse.fromJson(validateResponse(response));

      return data.message;
    } on SocketException {
      return CustomSnackBar.showSnackBar(
        message: 'You are offline. Please connect to internet first.',
        snackBarStyle: SnackBarStyle.info,
      );
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
      return false;
    }
  }

  @override
  Future testApi(
    String url, {
    Map<String, dynamic>? quaryParameters,
  }) async {
    try {
      Uri uri;
      ApiResponse data;

      if (quaryParameters != null) {
        uri = Uri.https(
          FlutterConfig.get('baseUrl'),
          url,
          quaryParameters.map((key, value) => MapEntry(key, value.toString())),
        );
      } else {
        uri = Uri.https(FlutterConfig.get('baseUrl'), url);
      }

      http.Response response =
          await http.get(uri, headers: generateHeaders()).timeout(
                const Duration(seconds: 10),
              );

      data = ApiResponse.fromJson(validateResponse(response));

      return data.rates;
    } on SocketException {
      return CustomSnackBar.showSnackBar(
        message: 'You are offline. Please connect to internet first .',
        snackBarStyle: SnackBarStyle.info,
      );
    } catch (e) {
      return false;
    }
  }

  @override
  Future getCheck(
    String url, {
    Map<String, dynamic>? quaryParameters,
  }) async {
    try {
      Uri uri;
      ApiResponse data;

      if (quaryParameters != null) {
        uri = Uri.https(
          FlutterConfig.get('baseUrl'),
          url,
          quaryParameters.map((key, value) => MapEntry(key, value.toString())),
        );
      } else {
        uri = Uri.https(FlutterConfig.get('baseUrl'), url);
      }

      http.Response response =
          await http.get(uri, headers: generateHeaders()).timeout(
                const Duration(seconds: 10),
              );

      data = ApiResponse.fromJson(validateResponse(response));

      return data.message;
    } on SocketException {
      return CustomSnackBar.showSnackBar(
        message: 'You are offline. Please connect to internet first .',
        snackBarStyle: SnackBarStyle.info,
      );
    } catch (e) {
      return false;
    }
  }

  dynamic validateResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        CustomSnackBar.showSnackBar(
          message: InvalidUrlException().message,
          snackBarStyle: SnackBarStyle.failure,
        );
        throw InvalidUrlException();
      case 403:
        CustomSnackBar.showSnackBar(
          message: RestrictedAccess().message,
          snackBarStyle: SnackBarStyle.failure,
        );
        throw RestrictedAccess();
      case 401:
        CustomSnackBar.showSnackBar(
          message: UnauthorizedException().message,
          snackBarStyle: SnackBarStyle.failure,
        );
        throw UnauthorizedException();
      case 305:
        CustomSnackBar.showSnackBar(
          message: InvalidTokenException().message,
          snackBarStyle: SnackBarStyle.failure,
        );
        throw InvalidTokenException();
      case 408:
        CustomSnackBar.showSnackBar(
          message: RequestTimeout().message,
          snackBarStyle: SnackBarStyle.failure,
        );
        throw RequestTimeout();
      case 500:
        CustomSnackBar.showSnackBar(
          message: ServerException().message,
          snackBarStyle: SnackBarStyle.failure,
        );
        throw ServerException();
      default:
        dynamic responseJson = jsonDecode(response.body);
        CustomSnackBar.showSnackBar(
          message: responseJson['failreason'],
          snackBarStyle: SnackBarStyle.failure,
        );
        throw UnknownError();
    }
  }
}
