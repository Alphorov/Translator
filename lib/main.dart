import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:translator_deepl/widgets/Inherited/language_scope.dart';
import 'package:translator_deepl/widgets/translate_screen/language_change_widget.dart';

import 'widgets/translate_screen/main_translate_widget.dart';

void main() {
  runApp(const MyApp());
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Color.fromARGB(255, 75, 75, 75),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  MaterialPageRoute<dynamic>? _route(RouteSettings settings) {
    if (settings.name == '/main') {
      return MaterialPageRoute(builder: (context) => const MainTranslate());
    }
    if (settings.arguments == LanType.current) {
      return MaterialPageRoute(
          builder: (context) =>
              const LanguageChange(currentOrTarget: LanType.current));
    }
    if (settings.arguments == LanType.target) {
      return MaterialPageRoute(
          builder: (context) =>
              const LanguageChange(currentOrTarget: LanType.target));
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return LanguageScope(
        child: MaterialApp(
            initialRoute: '/main',
            onGenerateRoute: (RouteSettings settings) => _route(settings),
            title: 'Flutter Demo',
            theme: ThemeData()));
  }
}
