import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:translator_deepl/repositoty/repository.dart';
import 'package:translator_deepl/widgets/Inherited/language_scope.dart';

class MainTranslate extends StatelessWidget {
  const MainTranslate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xff202123),
        body: SingleChildScrollView(
          child: Column(
            children: [
              ColoredBox(
                color: const Color(0xff303134),
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
              const MainTranslateContent()
            ],
          ),
        ),
      ),
    );
  }
}

enum LanType { target, current }

class MainTranslateContent extends StatefulWidget {
  const MainTranslateContent({Key? key}) : super(key: key);

  @override
  State<MainTranslateContent> createState() => _MainTranslateContentState();
}

class _MainTranslateContentState extends State<MainTranslateContent> {
  final mainTextStyle =
      GoogleFonts.lato(fontSize: 18, fontWeight: FontWeight.w400);

  final inputController = TextEditingController();

  final outputController = TextEditingController();

  void _autoTranslate() async {
    await Future.delayed(const Duration(seconds: 1));
    if (inputController.text != '') {
      final resalt = await Repository().tranlate(
          inputController.text,
          LanguageScope.of(context).requestCurrentLang,
          LanguageScope.of(context).requestTargetLang);
      outputController.text = resalt;
    } else {
      outputController.text = '';
    }
  }

  @override
  void initState() {
    inputController.addListener(() => _autoTranslate());
    super.initState();
  }

  @override
  void dispose() {
    inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: const Color(0xff2A2B2F),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: TextButton(
                            onPressed: () => Navigator.of(context).pushNamed(
                                  '/languages',
                                  arguments: LanType.current,
                                ),
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
                      ),
                      Expanded(
                        child: TextButton(
                            onPressed: () => {
                                  setState(() {
                                    LanguageScope.of(context).changeLanguages();
                                    var swap1 = inputController.text;
                                    var swap2 = outputController.text;
                                    inputController.text = swap2;
                                    outputController.text = swap1;
                                  })
                                },
                            child: SvgPicture.asset(
                                'assets/icons/reverse_icon.svg')),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: TextButton(
                          onPressed: () => Navigator.of(context).pushNamed(
                            '/languages',
                            arguments: LanType.target,
                          ),
                          child: Row(
                            children: [
                              Text(
                                LanguageScope.of(context).targetLanguage,
                                style: mainTextStyle,
                              ),
                              SvgPicture.asset(
                                  'assets/icons/down_arrow_icon.svg')
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  const Divider(
                    thickness: 1,
                    height: 0,
                    color: Color(0xffC9CACC),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 37),
                    child: Text(LanguageScope.of(context).currentLanguage,
                        style: GoogleFonts.lato(
                            color: const Color(0xffA3A3A3),
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                  ),
                  TextField(
                    // onChanged: _autoTranslate,
                    style: GoogleFonts.montserrat(
                        fontSize: 16, color: Colors.white),
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
                  color: const Color(0xff2A2B2F),
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
                        LanguageScope.of(context).targetLanguage,
                        style: GoogleFonts.lato(
                            color: const Color(0xffA3A3A3),
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    TextField(
                      style: GoogleFonts.montserrat(
                          fontSize: 16, color: Colors.white),
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
          left: 10,
          top: 286.5,
          child: IconButton(
              onPressed: () {},
              icon: SvgPicture.asset('assets/icons/voice_icon.svg')),
        ),
        Positioned(
          left: -3,
          top: 43.5,
          child: IconButton(
              onPressed: () {},
              icon: SvgPicture.asset('assets/icons/voice_icon.svg')),
        ),
        Positioned(
            right: 10,
            top: 55,
            child: IconButton(
              icon: SvgPicture.asset('assets/icons/microphone_icon.svg'),
              onPressed: () {},
            )),
      ],
    );
  }
}
