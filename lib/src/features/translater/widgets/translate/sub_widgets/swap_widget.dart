import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:translator_deepl/src/features/translater/data/images.dart';

import '../../Inherited/language_scope.dart';
import '../main_translate_widget.dart';

class SwapWidget extends StatelessWidget {
  const SwapWidget({Key? key, required this.swap}) : super(key: key);

  final void Function() swap;

  @override
  Widget build(BuildContext context) {
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
              child: _Item(
                icon: AppImage.downArrow,
                lang: LanguageScope.of(context).currentLanguage,
              )),
        ),
        Expanded(
          child: IconButton(onPressed: () => swap(), icon: AppImage.swap),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: TextButton(
            onPressed: () => Navigator.of(context).pushNamed(
              '/languages',
              arguments: LanType.target,
            ),
            child: _Item(
              icon: AppImage.downArrow,
              lang: LanguageScope.of(context).targetLanguage,
            ),
          ),
        )
      ],
    );
  }
}

class _Item extends StatelessWidget {
  const _Item({Key? key, required this.lang, required this.icon})
      : super(key: key);
  final String lang;
  final SvgPicture icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [Text(lang), icon],
    );
  }
}
