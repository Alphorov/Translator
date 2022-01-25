import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:translator_deepl/bloc/translate_bloc/translate_bloc.dart';
import 'package:translator_deepl/widgets/Inherited/language_scope.dart';

class MainTranslete extends StatelessWidget {
  const MainTranslete({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xff252A30),
        body: SingleChildScrollView(
          child: Column(
            children: [
              ColoredBox(
                color: const Color(0xff2B282A),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 7),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('PlTranslator',
                          style: GoogleFonts.montserratAlternates(
                              fontSize: 36,
                              color: Colors.white,
                              fontWeight: FontWeight.w300)),
                      const SizedBox(
                        width: 7,
                      ),
                      SvgPicture.asset('assets/icons/top_icon.svg')
                    ],
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

  final mainTextStyle =
      GoogleFonts.lato(fontSize: 18, fontWeight: FontWeight.w400);
  final inputController = TextEditingController();
  final outputController = TextEditingController();

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
      return Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xff28282A),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                height: 283,
                child: Column(
                  children: [
                    Row(
                      children: [
                        TextButton(
                            onPressed: () {},
                            child: Row(
                              children: [
                                Text(
                                  LanguageScope.of(context).currentLanguage,
                                  style: mainTextStyle,
                                ),
                                SvgPicture.asset(
                                    'assets/icons/down_arrow_icon.svg')
                              ],
                            )),
                        Expanded(
                          child: TextButton(
                              onPressed: () {},
                              child: SvgPicture.asset(
                                  'assets/icons/reverse_icon.svg')),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            LanguageScope.of(context).targetLanguage,
                            style: mainTextStyle,
                          ),
                        )
                      ],
                    ),
                    const Divider(
                      thickness: 1,
                      height: 0,
                      color: Color(0xffC9CACC),
                    ),
                    TextField(
                      autofocus: false,
                      cursorWidth: 2,
                      cursorRadius: const Radius.circular(6),
                      cursorHeight: 22,
                      cursorColor: Colors.white,
                      controller: inputController,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(8),
                        hintText: 'Введите текст',
                        hintStyle: TextStyle(color: Color(0xffC9CACC)),
                        border: InputBorder.none,
                      ),
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xff28282A),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 1,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                  height: 200,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 45),
                        child: Text(
                          LanguageScope.of(context).currentLanguage,
                          style: GoogleFonts.lato(
                              color: const Color(0xffA3A3A3),
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      TextField(
                        cursorWidth: 2,
                        cursorRadius: const Radius.circular(6),
                        cursorHeight: 22,
                        cursorColor: Colors.white,
                        controller: outputController,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.all(8),
                          border: InputBorder.none,
                        ),
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
              right: 10,
              top: 55,
              child: IconButton(
                icon: SvgPicture.asset('assets/icons/microphon_icon.svg'),
                onPressed: () {},
              )),
          Positioned(
            left: 10,
            top: 286.5,
            child: IconButton(
                onPressed: () {},
                icon: SvgPicture.asset('assets/icons/voice_icon.svg')),
          ),
        ],
      );
    });
  }
}
