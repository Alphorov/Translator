import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:translator_deepl/repositoty/repository.dart';

part 'translate_event.dart';
part 'translate_state.dart';

class TranslateBloc extends Bloc<TranslateEvent, TranslateState> {
  TranslateBloc(this._api) : super(TranslateInitial()) {
    on<TranslatingEvent>((event, emitter) async {
      try {
        final result =
            await _api.tranlate(event.userInput, event.translateLanguage);
        emitter.call(TextTranslatedState(result));
      } catch (e) {
        emitter.call(ErrorState(error: e.toString()));
      }
    });
  }
  final Repository _api;
}
