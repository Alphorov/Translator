import 'package:flutter/material.dart';

import '../../features/translater/widgets/lang_change/language_change_widget.dart';
import '../../features/translater/widgets/translate/main_translate_widget.dart';

class AppSettings {
  static MaterialPageRoute<dynamic>? route(RouteSettings settings) {
    if (settings.name == '/main') {
      return MaterialPageRoute(builder: (context) => const MainTranslate());
    }
    if (settings.arguments == LanType.current) {
      return MaterialPageRoute(
          builder: (context) =>
              const LanguageChange(currentOrTarget: LanType.current));
    }
    if (settings.arguments == LanType.target) {
      return MaterialPageRoute(
          builder: (context) =>
              const LanguageChange(currentOrTarget: LanType.target));
    }
    return null;
  }
}
