part of 'translate_bloc.dart';

@immutable
abstract class TranslateState {}

class TranslateInitial extends TranslateState {}

@immutable
class TextTranslatedState extends TranslateState {
  final String outputText;
  TextTranslatedState(this.outputText);
}

@immutable
class ErrorState extends TranslateState {
  final String error;
  ErrorState({required this.error});
}
