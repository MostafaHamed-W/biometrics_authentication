import 'package:flutter/services.dart';

Future<void> setWhiteStatusBarIcons() async {
  await setStatusBarIconBrightness();
}

Future<void> setStatusBarIconBrightness() async {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.light,
    ),
  );
}
