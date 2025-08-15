import 'package:flutter/material.dart';
import 'app.dart';
import 'service_locator.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await di.init();
  runApp(const NewsApp());
}
