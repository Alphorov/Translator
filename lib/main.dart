import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:translator_deepl/widgets/Inherited/language_scope.dart';
import 'package:translator_deepl/widgets/translate_screen/language_change_widget.dart';

import 'animations/animations_in_and_out_main_screen.dart';
import 'widgets/translate_screen/main_translete_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return LanguageScope(
      child: MaterialApp(
        initialRoute: '/main',
        onGenerateRoute: (settings) {
          log(settings.name.toString());

          if (settings.arguments == LanType.current) {
            return MaterialPageRoute(builder: (context) {
              return const LanguageChange(targetOrCurrent: LanType.current);
            });
          }
          if (settings.arguments == LanType.target) {
            return MaterialPageRoute(builder: (context) {
              return const LanguageChange(targetOrCurrent: LanType.target);
            });
          }
          if (settings.name == '/main') {
            return SlideRightRoute(page: const MainTranslete());
          }
          if (settings.name == '/language') {
            return SlideRightRoute(
                page: LanguageChange(
              targetOrCurrent: settings.arguments as LanType,
            ));
          }
        },
        title: 'Flutter Demo',
        theme: ThemeData(),
      ),
    );
  }
}
