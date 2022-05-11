import 'package:flutter/material.dart';
import 'package:translator_deepl/widgets/translate_screen/sub_widgets/swap_widget.dart';

import '../../Inherited/language_scope.dart';
import 'input_field.dart';
import 'output_field.dart';

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
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 75, 75, 75),
          borderRadius: BorderRadius.all(Radius.circular(10)),
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
            const Divider(
              thickness: 1,
              height: 0,
              color: Color(0xffC9CACC),
            ),
            OutputField(outputController: _outputController),
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
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Color.fromARGB(255, 75, 75, 75),
      ),
      height: 350,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SwapWidget(
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
          InputField(inputController: _inputController),
        ],
      ),
    );
  }
}
