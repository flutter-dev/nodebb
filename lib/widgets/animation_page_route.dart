import 'package:flutter/material.dart';

class AnimationPageRoute<T> extends MaterialPageRoute<T> {
  /// 
  Tween<Offset> slideTween;

  Tween<double> fadeTween;

  Tween<double> scaleTween;

  Tween<double> rotationTween;

  AnimationPageRoute({
    WidgetBuilder builder,
    this.slideTween,
    this.fadeTween,
    this.scaleTween,
    this.rotationTween,
    RouteSettings settings,
    bool maintainState: true,
    bool fullscreenDialog: false,
  }) : super(
            builder: builder,
            settings: settings,
            maintainState: maintainState,
            fullscreenDialog: fullscreenDialog);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    Widget widget = new SlideTransition(
      child: new FadeTransition(
        child: new ScaleTransition(
          child: new RotationTransition(
            child: child,
            turns: getRotationAnimation(animation),
          ),
          scale: getScaleAnimation(animation),
        ),
        opacity: getFadeAnimation(animation),
      ),
      position: _getSlideAnimation(animation),
    );
    return widget;
  }

  Animation<double> getRotationAnimation(Animation<double> animation) {
    if(rotationTween == null){
      rotationTween = new Tween<double>(begin: 1.0, end: 1.0);
    }
    return rotationTween.animate(animation);
  }

  Animation<double> getScaleAnimation(Animation<double> animation) {
    if(scaleTween == null){
      scaleTween = new Tween<double>(begin: 1.0, end: 1.0);
    }
    return scaleTween.animate(animation);
  }

  Animation<double> getFadeAnimation(Animation<double> animation) {
    if (fadeTween == null) {
      fadeTween = new Tween<double>(begin: 1.0, end: 1.0);
    }
    return fadeTween.animate(new CurvedAnimation(
      parent: animation,
      curve: Curves.easeIn,
    ));
  }

  Animation<Offset> _getSlideAnimation(Animation<double> animation) {
    if (slideTween == null) {
      slideTween = new Tween<Offset>(
        begin: new Offset(0.0, 0.0),
        end: Offset.zero,
      );
    }
    return slideTween.animate(new CurvedAnimation(
      parent: animation, // The route's linear 0.0 - 1.0 animation.
      curve: Curves.fastOutSlowIn,
    ));
  }
}
