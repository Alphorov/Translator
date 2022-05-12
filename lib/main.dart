import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'src/common/settings/route_setting.dart';
import 'src/features/translater/widgets/Inherited/language_scope.dart';

void main() {
  runApp(
    const MyApp(),
  );
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Color.fromARGB(255, 75, 75, 75),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return LanguageScope(
        child: MaterialApp(
            initialRoute: '/main',
            onGenerateRoute: (RouteSettings settings) =>
                AppSettings.route(settings),
            title: 'translator',
            theme: ThemeData()));
  }
}
