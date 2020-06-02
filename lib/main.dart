import 'package:flutter/material.dart';
import 'package:wolog_app/service_locator.dart';

import 'my_app.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}
