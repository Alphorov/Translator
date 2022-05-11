import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Inherited/language_scope.dart';
import '../main_translate_widget.dart';

class SwapWidget extends StatelessWidget {
  const SwapWidget({Key? key, required this.swap}) : super(key: key);

  final void Function() swap;

  @override
  Widget build(BuildContext context) {
    final _mainTextStyle = GoogleFonts.lato(
      fontSize: 18,
      fontWeight: FontWeight.w400,
    );
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
                  )
                ],
              )),
        ),
        Expanded(
          child: TextButton(
              onPressed: () => swap(),
              child: SvgPicture.asset(
                'assets/icons/reverse_icon.svg',
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
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
