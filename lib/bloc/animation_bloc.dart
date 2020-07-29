import 'dart:async';

import 'package:bloc/bloc.dart';

part 'animation_event.dart';

class AnimationBloc extends Bloc<AnimationEvents, String> {
  AnimationBloc() : super('idle');

  @override
  Stream<String> mapEventToState(
    AnimationEvents event,
  ) async* {
    switch (event) {
      case AnimationEvents.Idle:
        yield 'idle';
        break;
      case AnimationEvents.Playing:
        yield 'playing';
        break;
      case AnimationEvents.Completed:
        yield 'completed';
        break;
    }
  }
}
