import 'package:flutter/widgets.dart';

Route _createRoute(Widget screen) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => screen,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
  return IgnorePointer(
    // ignore when animating
    ignoring: (animation.value < 1 && animation.value > 0) ||
        (secondaryAnimation.value < 1 && secondaryAnimation.value > 0),
    // simple slide transition as example
    child: SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(1, 0),
        end: const Offset(0, 0),
      ).animate(animation), // Tween
      child: child
    ), // SlideTransition
  ); // IgnorePointer
},
  );
}