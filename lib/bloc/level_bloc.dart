import 'dart:async';
import 'package:bloc/bloc.dart';

part 'level_event.dart';

class LevelBloc extends Bloc<LevelEvents, String> {
  LevelBloc() : super('A-Level');

  @override
  Stream<String> mapEventToState(
    LevelEvents event,
  ) async* {
    switch (event) {
      case LevelEvents.alevel:
        yield 'A-Level';
        break;
      case LevelEvents.gcse:
        yield 'GCSE';
        break;
    }
  }
}
