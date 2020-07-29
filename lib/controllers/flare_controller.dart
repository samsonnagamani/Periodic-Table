import 'package:PeriodicTable/bloc/animation_bloc.dart';
import 'package:flare_dart/math/mat2d.dart';
import 'package:flare_flutter/flare.dart';
import 'package:flare_flutter/flare_controls.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AnimationControls extends FlareControls {
  /// Build Context
  static BuildContext _context;

  AnimationBloc animationBloc;

  @override
  void initialize(FlutterActorArtboard artboard) {
    super.initialize(artboard);
  }

  void setViewTransform(Mat2D viewTransform) {}

  @override
  bool advance(FlutterActorArtboard artboard, double elapsed) {
    return super.advance(artboard, elapsed);
  }

  @override
  void onCompleted(String name) {
    super.onCompleted(name);
    if (name == 'search') {
      animationBloc.add(AnimationEvents.Completed);
    }

    return;
  }

  void setContext(BuildContext context) {
    _context = context;
    _setAnimationBloc(_context);
  }

  void _setAnimationBloc(context) {
    animationBloc = BlocProvider.of<AnimationBloc>(context);
  }

  @override
  Future<void> play(String name,
      {double mix = 1.0, double mixSeconds = 0.2}) async {
    super.play(name);
  }
}
