import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:translator_deepl/repositoty/repository.dart';
import 'package:translator_deepl/widgets/Inherited/language_scope.dart';
import 'package:translator_deepl/widgets/translate_screen/language_change_widget.dart';

import 'animations/animations_in_and_out_main_screen.dart';
import 'bloc/translate_bloc/translate_bloc.dart';
import 'widgets/translate_screen/main_translete_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return LanguageScope(
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => TranslateBloc(Repository())),
        ],
        child: MaterialApp(
          initialRoute: '/main',
          onGenerateRoute: (settings) {
            log(settings.name.toString());
            if (settings.name == '/main') {
              return SlideRightRoute(page: const MainTranslete());
            }
            if (settings.name == '/language') {
              return SlideRightRoute(page: const LanguageChange());
            }
          },
          title: 'Flutter Demo',
          theme: ThemeData(),
        ),
      ),
    );
  }
}
