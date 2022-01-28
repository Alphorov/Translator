import 'package:translator/translator.dart';

class Repository {
  final translator = GoogleTranslator();
  Future<String> tranlate(
      String text, String targetLanguage, String currentLanguage) async {
    final output = await translator.translate(text,
        from: targetLanguage, to: currentLanguage);
    return output.toString();
  }
}
