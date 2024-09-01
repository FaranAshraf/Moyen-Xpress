import 'package:googleapis_auth/auth_io.dart';

class AccessFirebaseToken {
  static String firebaseMessagingScope =
      "https://www.googleapis.com/auth/firebase.messaging";

  Future<String> getAccessToken() async {
    final client = await clientViaServiceAccount(
        ServiceAccountCredentials.fromJson(
          {
            "type": "service_account",
            "project_id": "moyenxpresscustomer",
            "private_key_id": "adc13a26b6391910316fff4a69815033dad6edd8",
            "private_key":
                "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQC66TLR9vNGK1+w\nWvJpeCLYkF236g0Fn7pj9EtSyXf8HqCXBZx/ZDrAzxe/zqDHENP2RGTQYj+Qij4O\n9QSjxeDUmqzA68oDrsTYbSUuqmP3kGq4fZsQ5oxr8Ml+kvsvh6syxUsifCaJRlYj\nP88gIbbX4PCFndkeEEkjVgjhkkpPyQ8sFkPPepyR2SuoUSIPAJY2uDn3N42UVrEj\nGePAlCfvsPMvycHOctC5kljE92YLHqQWxUJn8/S0OaA8t+kouNJ89dmFjAvUdRGp\nRp05eScgr8TmChaPIB6vl8xA0jCFe7sxNfvGcHQrP7QTJt7P/449zsw2rUrNPpDQ\n1ky+geOZAgMBAAECggEAM4FqdzB5ZkcyharyLP0lgQ77PGB7OScEWmHp1cTd0vRv\npV4u+23XwOTwcvMSG/j3p9+99ix0vrRRmJaNMkIni/6Zh0oSb4RcCxW8jsj2ZjR+\nLBu0vOoDHQWLyNzg6f6VPxbd9wFGL0LaHrmJLp4LwB5kuTU/rMipFtsw9FP3NVfF\ny7NmWwCoum5kmLLgOmIcN//qXvhalHw829QYBGwnBjXQiDppHALnV5w0hp6JUxQr\nKm6C4o+28cz9M74NW51UmgUZjeMFOExfb9RNf8mzv3qn1Dk5Pxc1WgmWAS2O6U68\ny1p5mi9jk1B3H0vv4VqNUqEPNDXArw/7DorU7H8OfwKBgQDv6JYf4VG3hEXCMUGU\ndxqCbU0KoiySvqCcvQhruIDssSD6ssrQfSElmMWBhf7XuTQuQqOVHgktJh/mkUK/\nzYBWqtEFriNdJRvcvW3PJPkoqmNxJgreri41okCFgQT7uHPSuPhIH7D1sysRaJSI\nPnfU+OUoN7AmTbJSNwiItQ/ckwKBgQDHcpo+VVPtiSQJJjZCjWlIdCxY6tENLhVD\nK1yUSGaIoTCUyQTn21Dl4oNPrq+jfxCCtJ4BKdDJ9SRkZtLzkMeS5oZx8lHdmAO2\nNj//O1vf6WAIm6v88K4lViHevaczaeLjPqn5TLwNhFIJcroY+O7umfdts1mGYbpF\nL1dd0+8GowKBgDgi3VXyXDOr4MLS0bySrgJM3xUY44Mm1eA3H0xNbOV1gPkIcwqb\n7PCmMbjgCMSjkoEsmKhg0dbdr+M8pDjLNjeRWr2QhLfb4gwhyxsIVMDeNcyZETwP\n18I3CA/1I5xfCcMKAxalS7wCQ5acOP00WMfdwYlKlo4v6gTw2a9bZq2/AoGAIwc3\nm7b0tIUfdRPm961KTlVI7Jzg9kWfqlpVOh21FE3q8FaVq/rSrG0pzrbJVhec2LfM\nADxN1Qpex9tfNTO6OUyPVDfQtPBbxoakmrjcG+kq2pgsjpHeo+QKssnwMZFpLav1\nwjj91gnlNo+Vq4kcvX8A+51CHd3QDxKPb4UnN60CgYADysVyDIGbYwRjt4QTGcik\nDLnmArTqM6BWW4rjf68RHdMlR/lOWV0bFEsEc/QJI1toyq2t1HCxEcblSjtWiZt7\ntHf2Uu6DYaegZDyo+jPLgCA0cx/ef1bKRrhRWQbVNvzdbYpuKI7fIWnl8z6LipIy\nx/0rP8lLlV219AesLRI/fw==\n-----END PRIVATE KEY-----\n",
            "client_email":
                "firebase-adminsdk-abp54@moyenxpresscustomer.iam.gserviceaccount.com",
            "client_id": "107959592118609569483",
            "auth_uri": "https://accounts.google.com/o/oauth2/auth",
            "token_uri": "https://oauth2.googleapis.com/token",
            "auth_provider_x509_cert_url":
                "https://www.googleapis.com/oauth2/v1/certs",
            "client_x509_cert_url":
                "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-abp54%40moyenxpresscustomer.iam.gserviceaccount.com",
            "universe_domain": "googleapis.com"
          },
        ),
        [firebaseMessagingScope]);
    final accessToken = client.credentials.accessToken.data;
    return accessToken;
  }
}
