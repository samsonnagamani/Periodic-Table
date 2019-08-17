import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class LevelBloc extends Bloc<LevelEvent, dynamic> {
  @override
  get initialState => '';

  @override
  Stream mapEventToState(
    LevelEvent event,
  ) async* {
    switch (event) {
      case LevelEvent.alevel:
        yield 'A-Level';
        break;
      case LevelEvent.gcse:
        yield 'GCSE';
        break;
    }
  }
}
