import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kaushik/ViewPage.dart';
import 'package:kaushik/dummyproducts.dart';
import 'package:kaushik/try.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: demoGrid(),
  ));
}
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}