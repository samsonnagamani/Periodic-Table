import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:PeriodicTable/controllers/flare_controller.dart';

enum AnimationToPlay {
  Open,
  Close,
  Search,
}

class Nav extends StatefulWidget {
  @override
  _NavState createState() => _NavState();
}

class _NavState extends State<Nav> {
  // Create Flare Controls
  final AnimationControls animationControls = AnimationControls();

  AnimationToPlay _animationToPlay = AnimationToPlay.Close;
  AnimationToPlay _lastPlayedAnimation;

  // Width and Height of artboard
  static const double AnimationHeight = 157.3;
  static const double AnimationWidth = 58.0;

  bool isOpen = false;

  @override
  Widget build(BuildContext context) {
    // Set build context variable in AnimationControls instance
    animationControls.setContext(context);

    return Container(
      height: AnimationHeight,
      width: AnimationWidth,
      child: GestureDetector(
        onTapUp: (tapInfo) {
          var localTouchPosition = (context.findRenderObject() as RenderBox)
              .globalToLocal(tapInfo.globalPosition);

          var topHalfTouched = localTouchPosition.dy < AnimationHeight / 2;
          var bottomHalfTouched = localTouchPosition.dy > AnimationHeight / 2;

          if (topHalfTouched) {
            var isHiddenAnimation = _isHiddenAnimation(
                AnimationToPlay.Search, _lastPlayedAnimation);
            _setAnimationToPlay(AnimationToPlay.Search);

            if (isHiddenAnimation) return;
          } else if (bottomHalfTouched) {
            if (isOpen) {
              _setAnimationToPlay(AnimationToPlay.Close);
            } else {
              _setAnimationToPlay(AnimationToPlay.Open);
            }
          }

          setState(() {
            isOpen = !isOpen;
          });
        },
        child: FlareActor(
          'assets/Nav.flr',
          alignment: Alignment.bottomCenter,
          fit: BoxFit.contain,
          controller: animationControls,
          animation: _getAnimationName(_animationToPlay),
        ),
      ),
    );
  }

  String _getAnimationName(AnimationToPlay animationToPlay) {
    switch (animationToPlay) {
      case AnimationToPlay.Close:
        return 'close';
        break;
      case AnimationToPlay.Open:
        return 'open';
        break;
      case AnimationToPlay.Search:
        return 'search';
        break;
      default:
        return '';
        break;
    }
  }

  void _setAnimationToPlay(AnimationToPlay animation) {
    bool isHiddenAnimation =
        _isHiddenAnimation(animation, _lastPlayedAnimation);

    if (isHiddenAnimation) return;

    animationControls.play(_getAnimationName(animation));

    _lastPlayedAnimation = animation;
  }

  bool _isHiddenAnimation(
      AnimationToPlay animation, AnimationToPlay lastPlayedAnimation) {
    var isSearchAnimation = _getAnimationName(animation).contains('search');

    if (isSearchAnimation && _lastPlayedAnimation == AnimationToPlay.Close) {
      return true;
    }
    return false;
  }
}
