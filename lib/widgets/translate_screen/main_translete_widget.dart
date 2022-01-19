import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:translator_deepl/bloc/translate_bloc/translate_bloc.dart';
import 'package:translator_deepl/widgets/Inherited/language_scope.dart';

class MainTranslete extends StatelessWidget {
  const MainTranslete({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              ColoredBox(
                color: const Color.fromRGBO(143, 128, 231, 1),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: SizedBox(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 19),
                          child: Icon(
                            Icons.translate,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          width: 87,
                        ),
                        Text(
                          'Translator',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              MainTranslateContent()
            ],
          ),
        ),
      ),
    );
  }
}

class MainTranslateContent extends StatelessWidget {
  MainTranslateContent({Key? key}) : super(key: key);

  final inputController = TextEditingController();
  final outputController = TextEditingController();
  final mainTextStyle = const TextStyle(
      color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold);

  void translate(BuildContext context, TranslateState state) {
    final bloc = context.read<TranslateBloc>();
    bloc.add(TranslatingEvent(
        translateLanguage: LanguageScope.of(context).targetLanguage,
        userInput: inputController.text));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TranslateBloc, TranslateState>(
        listener: (context, state) {
      if (state is TextTranslatedState) {
        outputController.text = state.outputText;
      }
      if (state is ErrorState) {
        outputController.text = 'Ошибка перевода: ${state.error}';
      }
    }, builder: (context, state) {
      return ColoredBox(
        color: const Color.fromRGBO(143, 128, 231, 0.5),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              Text(
                'Введите текст на любом языке',
                style: mainTextStyle,
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                        spreadRadius: 1,
                        blurRadius: 10,
                        offset: Offset(0, 3),
                        color: Colors.black26),
                  ],
                  borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                  color: Colors.purple[50],
                ),
                height: 200,
                child: TextField(
                  cursorWidth: 3,
                  cursorRadius: const Radius.circular(6),
                  cursorHeight: 22,
                  cursorColor: Colors.purple,
                  controller: inputController,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(8),
                    hintText: 'Введите текст',
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    border: InputBorder.none,
                  ),
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Text(
                    'Перевести на',
                    style: mainTextStyle,
                  ),
                  TextButton(
                      onPressed: () =>
                          Navigator.of(context).pushNamed('/language'),
                      child: Text(
                        LanguageScope.of(context).currentLanguage,
                        style: const TextStyle(
                            color: Colors.blue,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ))
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                        spreadRadius: 1,
                        blurRadius: 10,
                        offset: Offset(0, 3),
                        color: Colors.black26),
                  ],
                  borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                  color: Colors.purple[50],
                ),
                height: 200,
                child: TextField(
                  cursorWidth: 3,
                  cursorRadius: const Radius.circular(6),
                  cursorHeight: 22,
                  cursorColor: Colors.purple,
                  controller: outputController,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(8),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    border: InputBorder.none,
                  ),
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 25),
                child: Center(
                  child: CupertinoButton(
                    onPressed: () => translate(context, state),
                    child: const Text('Перевести'),
                    color: Colors.purple,
                  ),
                ),
              ),
              const SizedBox(
                height: 120,
              )
            ],
          ),
        ),
      );
    });
  }
}
