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
  String requestLanguage = 'ru';
  String targetLanguage = 'Английский';

  void changeCurrentLanguage(String lang) {
    currentLanguage = lang;
    setState(() {});
  }

  void changeTargetLanguage(String lang) {
    setState(() {
      targetLanguage = lang;
    });
  }

  void changeRequestLanguage(String lang) {
    setState(() {
      requestLanguage = lang;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _LanguageScopeInherited(
      changeRequestLang: changeRequestLanguage,
      changeTargetLang: changeTargetLanguage,
      changeCurrentLang: changeCurrentLanguage,
      requestLanguage: requestLanguage,
      currentLanguage: currentLanguage,
      targetLanguage: targetLanguage,
      child: widget.child,
    );
  }
}

class _LanguageScopeInherited extends InheritedModel {
  const _LanguageScopeInherited({
    required this.requestLanguage,
    required this.changeRequestLang,
    Key? key,
    required this.changeTargetLang,
    required this.changeCurrentLang,
    required this.currentLanguage,
    required this.targetLanguage,
    required final Widget child,
  }) : super(key: key, child: child);

  final String currentLanguage;
  final String targetLanguage;
  final String requestLanguage;
  final void Function(String) changeCurrentLang;
  final void Function(String) changeTargetLang;
  final void Function(String) changeRequestLang;

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
