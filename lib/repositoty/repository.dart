import 'package:translator/translator.dart';

class Repository {
  final translator = GoogleTranslator();
  Future<String> tranlate(String text, String language) async {
    final output = await translator.translate(text, from: 'auto', to: language);
    return output.toString();
  }
}
