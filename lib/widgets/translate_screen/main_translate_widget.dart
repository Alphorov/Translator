import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:translator_deepl/repositoty/repository.dart';
import 'package:translator_deepl/widgets/Inherited/language_scope.dart';

import 'sub_widgets/sub_widgets.dart';

enum LanType { target, current }

class MainTranslate extends StatelessWidget {
  const MainTranslate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 56, 58, 61),
        body: SingleChildScrollView(
          child: Column(
            children: const [
              ColoredBox(
                color: Color.fromARGB(255, 112, 113, 117),
                child: _TopLogo(),
              ),
              MainTranslateContent()
            ],
          ),
        ),
      ),
    );
  }
}

class MainTranslateContent extends StatefulWidget {
  const MainTranslateContent({Key? key}) : super(key: key);

  @override
  State<MainTranslateContent> createState() => _MainTranslateContentState();
}

class _MainTranslateContentState extends State<MainTranslateContent> {
  void swap() {
    setState(() {
      LanguageScope.of(context).changeLanguages();
      var swap1 = _inputController.text;
      var swap2 = _outputController.text;
      _inputController.text = swap2;
      _outputController.text = swap1;
    });
  }

  void _autoTranslate() async {
    await Future.delayed(const Duration(seconds: 1));
    if (_inputController.text != '') {
      final resalt = await Repository().tranlate(
          _inputController.text,
          LanguageScope.of(context).requestCurrentLang,
          LanguageScope.of(context).requestTargetLang);
      _outputController.text = resalt;
    } else {
      _outputController.text = '';
    }
  }

  final _langTextStyle = GoogleFonts.lato(
      color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold);

  final _inputController = TextEditingController();

  final _outputController = TextEditingController();

  @override
  void initState() {
    _inputController.addListener(() => _autoTranslate());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InputBackSide(_inputController, _langTextStyle, swap: swap),
            OutputBackSide(
                langTextStyle: _langTextStyle,
                outputController: _outputController),
          ],
        ),
      ],
    );
  }

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }
}

class _TopLogo extends StatelessWidget {
  const _TopLogo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('PlTranslator',
            style: GoogleFonts.montserratAlternates(
                fontSize: 36,
                color: Colors.white,
                fontWeight: FontWeight.w300)),
        const SizedBox(
          width: 5,
        ),
        SvgPicture.asset('assets/icons/top_icon.svg')
      ],
    );
  }
}
