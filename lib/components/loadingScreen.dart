import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:platter/layout.dart';
import 'package:platter/layout_text.dart';
import 'package:platter/mobile_constants.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as dynamic;
    String msg = args?["msg"] ?? "Wait a second";

    return Center(
      child: ProportionsColumn(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        defaultDiameter: 485 * 0.75,
        children: [
          {
            50: MinDiameterSupport(
              length: 50,
              maximumDiameter: 485,
              diameter: 50,
              orientation: LayoutOrientation.vertical,
              primaryAxisAlignItems: LayoutAlign.center,
              counterAxisAlignItems: LayoutAlign.center,
              child: LayoutBuilder(
              builder: (c, bc) => LoadingAnimationWidget.twistingDots(
                leftDotColor: Colors.white,
                rightDotColor: Colors.grey,
                size: bc.biggest.height,
              ),
            ),),
          },
          {14: antiwhite},
          {
            19: LayoutText(msg,
            textAlign: TextAlign.center,
            letterSpacing: 0.01,
                style: TextStyle(
                    color: Colors.white,
                    height: 1.25,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Inter'))
          }
        ],
      ),
    );
  }
}
