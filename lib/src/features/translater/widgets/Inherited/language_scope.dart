import 'package:flutter/material.dart';

class LanguageScope extends StatefulWidget {
  const LanguageScope({Key? key, required this.child}) : super(key: key);
  final Widget child;

  static LanguageScopeState of(BuildContext context) {
    return (context
            .dependOnInheritedWidgetOfExactType<_LanguageScopeInherited>())!
        .data;
  }

  @override
  LanguageScopeState createState() => LanguageScopeState();
}

class LanguageScopeState extends State<LanguageScope> {
  String currentLanguage = 'Русский';
  String requestCurrentLang = 'ru';
  String targetLanguage = 'Английский';
  String requestTargetLang = 'en';

  void changeCurrentLang(Map<String, String> lang) {
    currentLanguage = lang['name'] ?? '';
    requestCurrentLang = lang['code'] ?? '';

    setState(() {});
  }

  void changeTargetLang(Map<String, String> lang) {
    setState(() {
      targetLanguage = lang['name'] ?? '';
      requestTargetLang = lang['code'] ?? '';
    });
  }

  void changeLanguages() {
    if (requestCurrentLang != "auto") {
      var swap1 = requestCurrentLang;
      var swap2 = requestTargetLang;
      var swap3 = currentLanguage;
      var swap4 = targetLanguage;

      requestCurrentLang = swap2;
      requestTargetLang = swap1;
      currentLanguage = swap4;
      targetLanguage = swap3;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return _LanguageScopeInherited(
      child: widget.child,
      data: this,
      currentLanguage: currentLanguage,
      requestCurrentLang: requestCurrentLang,
      requestTargetLang: requestTargetLang,
      targetLanguage: targetLanguage,
    );
  }
}

class _LanguageScopeInherited extends InheritedWidget {
  _LanguageScopeInherited({
    Key? key,
    required this.child,
    required this.data,
    required this.currentLanguage,
    required this.requestCurrentLang,
    required this.targetLanguage,
    required this.requestTargetLang,
  }) : super(key: key, child: child);

  String currentLanguage;
  String requestCurrentLang;
  String targetLanguage;
  String requestTargetLang;
  final Widget child;
  final LanguageScopeState data;

  @override
  bool updateShouldNotify(_LanguageScopeInherited oldWidget) {
    return true;
  }
}
