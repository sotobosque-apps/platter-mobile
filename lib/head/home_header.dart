import 'dart:ui';

import 'package:expand_tap_area/expand_tap_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:platter/alert/homeWaterMenu.dart';
import 'package:platter/alert/menu.dart';
import 'package:platter/layout.dart';
import 'package:platter/mobile_constants.dart';

class HomeHeader extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize {
     final t = Turner(navigatorGrandKey.currentContext!);
    return Size.fromHeight(t.HeightasProportioned(74 * 1.25).toDouble());
  }

  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Align(
        alignment: Alignment.topLeft,
        child: AspectRatio(
          aspectRatio: (485 * 0.75) / 74,
          child: ColoredBox(
              color: Colors.transparent,
              child: OrientedLayout(
                  orientation: LayoutOrientation.horizontal,
                  primaryAxisAlignItems: LayoutAlign.space_between,
                  counterAxisAlignItems: LayoutAlign.center,
                  diameter: 74,
                  padding: [32, 22, 24.5, 0],
                  itemSpacing: 0,
                  children: [
                    {
                      52: GestureDetector(
                          onTap: () {
                            onCallB(context);
                          },
                          child: SvgPicture.asset("assets/water-button.svg"))
                    },
                    {
                      52: GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () {
                            onCall(context);
                          },
                          child: DecoratedBox(
                              decoration: const BoxDecoration(
                                  boxShadow: defaultIconShadow),
                              child: SvgPicture.asset("assets/dot.svg")))
                    },
                  ])),
        ),
      ),
    );
  }

  void onCall(BuildContext context) {
    showDialog<String>(
      context: navigatorGrandKey.currentContext!,
      useRootNavigator: true,
      barrierColor: Colors.transparent,
      barrierDismissible: true,
      builder: (BuildContext context) => Dialog.fullscreen(
        backgroundColor: Colors.transparent,
        child: Menu(),
      ),
    );
  }

  void onCallB(BuildContext context) {
    showDialog<String>(
      context: navigatorGrandKey.currentContext!,
      useRootNavigator: true,
      barrierColor: Colors.transparent,
      barrierDismissible: true,
      builder: (BuildContext context) => Dialog.fullscreen(
        backgroundColor: Colors.transparent,
        child: WaterMenu(),
      ),
    );
  }
}
