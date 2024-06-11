import 'package:flutter/widgets.dart';

class ScreenAspectRatioContainer extends StatelessWidget {
  final Widget child;

  ScreenAspectRatioContainer({required this.child});

  @override
  Widget build(BuildContext context) {
    // Get the screen size
    final size = MediaQuery.of(context).size;

    // Calculate aspect ratio
    final aspectRatio = size.height / size.width;

    return AspectRatio(
      aspectRatio: 485 / (485 * aspectRatio),
      child: child,
    );
  }
}
