import 'package:flutter/material.dart';

class LanguageScope extends StatefulWidget {
  const LanguageScope({Key? key, required this.child}) : super(key: key);
  final Widget child;
  static _LanguageScopeInherited of(BuildContext context) {
    final inhW =
        context.dependOnInheritedWidgetOfExactType<_LanguageScopeInherited>();
    final languageScope = inhW is _LanguageScopeInherited ? inhW : null;
    return languageScope ?? _notFound();
  }

  static Never _notFound() => throw UnsupportedError('Did not found element');
  @override
  _LanguageScopeState createState() => _LanguageScopeState();
}

class _LanguageScopeState extends State<LanguageScope> {
  String currentLanguage = 'Русский';
  String requestCurrentLang = 'ru';
  String targetLanguage = 'Английский';
  String requestTargetLang = 'en';

  void changeCurrentLanguage(String lang) {
    currentLanguage = lang;
    setState(() {});
  }

  void changeTargetLanguage(String lang) {
    setState(() {
      targetLanguage = lang;
    });
  }

  void changeRequestCurrentLanguage(String lang) {
    setState(() {
      requestCurrentLang = lang;
    });
  }

  void changeRequestTargetLanguage(String lang) {
    setState(() {
      requestTargetLang = lang;
    });
  }

  void changeLanguages() {
    var swap1 = requestCurrentLang;
    var swap2 = requestTargetLang;
    var swap3 = currentLanguage;
    var swap4 = targetLanguage;

    requestCurrentLang = swap2;
    requestTargetLang = swap1;
    currentLanguage = swap4;
    targetLanguage = swap3;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return _LanguageScopeInherited(
      changeLanguages: changeLanguages,
      changeTargetLang: changeTargetLanguage,
      changeCurrentLang: changeCurrentLanguage,
      changeRequestTargetLanguage: changeRequestTargetLanguage,
      changeRequestCurrentLanguage: changeRequestCurrentLanguage,
      currentLanguage: currentLanguage,
      targetLanguage: targetLanguage,
      requestCurrentLang: requestCurrentLang,
      requestTargetLang: requestTargetLang,
      child: widget.child,
    );
  }
}

class _LanguageScopeInherited extends InheritedModel {
  const _LanguageScopeInherited({
    Key? key,
    required this.changeLanguages,
    required this.requestCurrentLang,
    required this.requestTargetLang,
    required this.changeRequestCurrentLanguage,
    required this.changeRequestTargetLanguage,
    required this.changeTargetLang,
    required this.changeCurrentLang,
    required this.currentLanguage,
    required this.targetLanguage,
    required final Widget child,
  }) : super(key: key, child: child);

  final String currentLanguage;
  final String targetLanguage;
  final String requestCurrentLang;
  final String requestTargetLang;
  final void Function(String) changeCurrentLang;
  final void Function(String) changeTargetLang;
  final void Function(String) changeRequestCurrentLanguage;
  final void Function(String) changeRequestTargetLanguage;
  final void Function() changeLanguages;

  @override
  bool updateShouldNotify(_LanguageScopeInherited oldWidget) {
    return true;
  }

  @override
  bool updateShouldNotifyDependent(
      covariant InheritedModel oldWidget, Set dependencies) {
    return true;
  }
}
