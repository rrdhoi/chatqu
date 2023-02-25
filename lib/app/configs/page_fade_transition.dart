import 'package:flutter/material.dart';

class FadeTransitionBuilder extends PageTransitionsBuilder {
  final AxisDirection direction;
  const FadeTransitionBuilder({this.direction = AxisDirection.right});

  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return _FadeTransitionBuilder(routeAnimation: animation, child: child);
    // return SlideTransition(position: Tween<Offset>(begin: getBeginOffset(), end: Offset.zero).animate(animation),child: child);
  }

  Offset getBeginOffset() {
    switch (direction) {
      case AxisDirection.up:
        return const Offset(0, 1);
      case AxisDirection.down:
        return const Offset(0, -1);
      case AxisDirection.right:
        return const Offset(-1, 0);
      case AxisDirection.left:
        return const Offset(1, 0);
    }
  }
}

class _FadeTransitionBuilder extends StatelessWidget {
  _FadeTransitionBuilder({
    Key? key,
    required Animation<double> routeAnimation,
    required this.child,
  })  : _opacityAnimation = routeAnimation.drive(_easeInTween),
        super(key: key);

  static final Animatable<double> _easeInTween =
      CurveTween(curve: Curves.easeIn);

  final Animation<double> _opacityAnimation;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacityAnimation,
      child: child,
    );
  }
}
