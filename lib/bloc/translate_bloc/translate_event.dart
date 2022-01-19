part of 'translate_bloc.dart';

@immutable
abstract class TranslateEvent {}

@immutable
class TranslatingEvent extends TranslateEvent {
  final String userInput;
  final String translateLanguage;
  TranslatingEvent({required this.translateLanguage, required this.userInput});
}
