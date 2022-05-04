import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Inherited/language_scope.dart';
import '../main_translate_widget.dart';

class OutputBackSide extends StatelessWidget {
  const OutputBackSide({
    Key? key,
    required TextStyle langTextStyle,
    required TextEditingController outputController,
  })  : _langTextStyle = langTextStyle,
        _outputController = outputController,
        super(key: key);

  final TextStyle _langTextStyle;
  final TextEditingController _outputController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          color: Theme.of(context).colorScheme.primary,
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 99, 94, 94).withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 1,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        height: 290,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
              child: Text(
                LanguageScope.of(context).targetLanguage,
                style: _langTextStyle,
              ),
            ),
            _OutputField(outputController: _outputController),
          ],
        ),
      ),
    );
  }
}

class InputBackSide extends StatelessWidget {
  const InputBackSide(this._inputController, this._langTextStyle,
      {Key? key, required this.swap})
      : super(key: key);
  final void Function() swap;
  final TextEditingController _inputController;
  final TextStyle _langTextStyle;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        color: Theme.of(context).colorScheme.onPrimary,
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 1,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      height: 350,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SwapWidget(
            swap: swap,
          ),
          const Divider(
            thickness: 1,
            height: 0,
            color: Color(0xffC9CACC),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
            child: Text(LanguageScope.of(context).currentLanguage,
                style: _langTextStyle),
          ),
          _InputField(inputController: _inputController),
        ],
      ),
    );
  }
}

class _InputField extends StatelessWidget {
  const _InputField({
    Key? key,
    required this.inputController,
  }) : super(key: key);

  final TextEditingController inputController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: GoogleFonts.montserrat(fontSize: 16, color: Colors.white),
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
    );
  }
}

class _OutputField extends StatelessWidget {
  const _OutputField({
    Key? key,
    required this.outputController,
  }) : super(key: key);

  final TextEditingController outputController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: TextField(
        style: GoogleFonts.montserrat(fontSize: 16, color: Colors.white),
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
    );
  }
}

class _SwapWidget extends StatelessWidget {
  const _SwapWidget({Key? key, required this.swap}) : super(key: key);

  final void Function() swap;

  @override
  Widget build(BuildContext context) {
    final _mainTextStyle = GoogleFonts.lato(
        fontSize: 18,
        fontWeight: FontWeight.w400,
        color: Theme.of(context).colorScheme.surface);
    return Row(
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
                    style: _mainTextStyle,
                  ),
                  SvgPicture.asset(
                    'assets/icons/down_arrow_icon.svg',
                    color: Theme.of(context).colorScheme.surface,
                  )
                ],
              )),
        ),
        Expanded(
          child: TextButton(
              onPressed: () => swap(),
              child: SvgPicture.asset(
                'assets/icons/reverse_icon.svg',
                color: Theme.of(context).colorScheme.surface,
              )),
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
                  style: _mainTextStyle,
                ),
                SvgPicture.asset(
                  'assets/icons/down_arrow_icon.svg',
                  color: Theme.of(context).colorScheme.surface,
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
