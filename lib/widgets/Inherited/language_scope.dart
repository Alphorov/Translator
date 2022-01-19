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
  String currentLanguage = 'Russian';
  String targetLanguage = 'ru';

  void changeCurrentLanguage(String lang) {
    setState(() {
      currentLanguage = lang;
    });
  }

  void changeTargetLanguage(String lang) {
    setState(() {
      targetLanguage = lang;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _LanguageScopeInherited(
      changeTargetLang: changeTargetLanguage,
      changeCurrentLang: changeCurrentLanguage,
      currentLanguage: currentLanguage,
      targetLanguage: targetLanguage,
      child: widget.child,
    );
  }
}

class _LanguageScopeInherited extends InheritedModel {
  const _LanguageScopeInherited({
    Key? key,
    required this.changeTargetLang,
    required this.changeCurrentLang,
    required this.currentLanguage,
    required this.targetLanguage,
    required final Widget child,
  }) : super(key: key, child: child);

  final String currentLanguage;
  final String targetLanguage;
  final void Function(String) changeCurrentLang;
  final void Function(String) changeTargetLang;

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
