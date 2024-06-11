import 'package:flutter/material.dart';

class CommonBackground extends StatefulWidget {
  final Widget child;

  const CommonBackground({super.key, required this.child});

  @override
  State<CommonBackground> createState() => _CommonBackgroundState();
}

class _CommonBackgroundState extends State<CommonBackground> {
  bool show = false;
  Widget? a;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(Duration(milliseconds: 200), () {
      setState(() {
        show = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white,
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomCenter,
              colors: [Color(0xFFFFFEFB), Color(0xFFFFFEFC)])),
      child: switch (show) {
        false => SizedBox.shrink(),
        _ => Loader(child: Builder(builder: (context) => widget.child,))
      },
    );
  }
}

class Loader extends StatefulWidget {
  const Loader({super.key, required this.child});
  final Widget child;
  @override
  State<Loader> createState() => _LoaderState();
}

class _LoaderState extends State<Loader> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _controller = AnimationController(
      duration:  Duration(milliseconds: (500 *0.64).toInt()),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );

    // Trigger the animation after the first frame has been built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(opacity: _animation, child: widget.child);
  }
}
