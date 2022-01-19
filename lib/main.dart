import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:translator_deepl/repositoty/repository.dart';
import 'package:translator_deepl/widgets/Inherited/language_scope.dart';
import 'package:translator_deepl/widgets/translate_screen/language_change_widget.dart';

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
          routes: {
            '/main': (context) => const MainTranslete(),
            '/language': (context) => const LanguageChange(),
          },
          title: 'Flutter Demo',
          theme: ThemeData(),
          home: const MainTranslete(),
        ),
      ),
    );
  }
}
