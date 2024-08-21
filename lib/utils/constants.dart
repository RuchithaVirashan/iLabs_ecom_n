import 'dart:io' show Platform;

class Constants {
  static const referenceHeight = 896;
  static const referenceWidth = 414;
  String currentPlatfrom = Platform.isAndroid
      ? "android"
      : Platform.isIOS
          ? "iOS"
          : "other";
  static const String baseurl =
      'https://66c40190b026f3cc6cedb992.mockapi.io/ecomapi/v1/';
}
