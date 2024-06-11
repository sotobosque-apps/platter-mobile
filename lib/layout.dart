import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:platter/main.dart';
import 'package:platter/mobile_constants.dart';

const num defaultScreenWidth = 485;
const num defaultScreenHeight = 862.22;

FlutterView view = WidgetsBinding.instance.platformDispatcher.views.first;

Size size = view.physicalSize / view.devicePixelRatio;

List addSpacing(List originalList, num no, num defaultDiameter,
    LayoutOrientation orientation) {
  List modifiedList = []; // Empty array to store modified elements
  if (no > 0) {
    for (int i = 0; i < originalList.length; i++) {
      // Add the original element

      if (i > 0) {
        // If the index is odd
        modifiedList.add(AspectRatio(
          aspectRatio: orientation == LayoutOrientation.vertical
              ? defaultDiameter / no
              : no / defaultDiameter,
          child: orientation == LayoutOrientation.vertical
              ? antiwhite
              : antiwhiteVertical,
        )); // Insert the element at odd position, here 0 is inserted
      }
      modifiedList.add(originalList[i]);
    }
    return (modifiedList);
  } else {
    return originalList;
  }
}

class Turner {
  final BuildContext context;

  Turner(this.context);

  double WidthProp(num no) {
    final double width = MediaQuery.of(context).size.width;
    return no / width;
    // return no / width;
  }

  double HeighProp(num no) {
    double height = MediaQuery.of(context).size.height;
    return no / height;
  }

  num WidthasProportioned(num no) {
    return ((WidthProp(no)) * defaultScreenWidth);
  }

  num HeightasProportioned(num no) {
    return (HeighProp(no)) * defaultScreenHeight;
  }
}

class ProportionsColumn extends StatelessWidget {
  final List<dynamic> children;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final num spacing;
  
  final List<num> padding;

  final num defaultDiameter;

  const ProportionsColumn(
      {super.key,
      required this.defaultDiameter,
      this.padding = const [0, 0, 0, 0],
      required this.children,
      this.spacing = 0,
      this.mainAxisAlignment = MainAxisAlignment.start,
      this.crossAxisAlignment = CrossAxisAlignment.center});
  
  @override
  Widget build(BuildContext context) {
    bool measureWidth = defaultDiameter != null;

    var cast = children
        .map((e) => e is Widget
            ? e
            : ((e is Map<dynamic, dynamic>)
                ? Column(
                    mainAxisAlignment: mainAxisAlignment,
                    crossAxisAlignment: crossAxisAlignment,
                    children: e.entries
                        .map((ent) => AspectRatio(
                              aspectRatio: measureWidth
                                  ? (defaultDiameter! / ent.key)
                                  : ent.key,
                              child: ent.value,
                            ))
                        .toList()
                        .cast<Widget>(),
                  )
                : AspectRatio(
                    aspectRatio: measureWidth ? (defaultDiameter! / e) : e)))
        .toList()
        .cast<Widget>();

    return LayoutBuilder(
      builder: (context, bc) {
        var t = Turner(context);
        var paddingLeft = padding[0] > 0
            ? AspectRatio(
                aspectRatio:
                    padding[0] / t.HeightasProportioned(bc.biggest.height), child: antiwhiteVertical,)
            : const SizedBox();

        var paddingRight = padding[2] > 0
            ? AspectRatio(
                aspectRatio:
                    padding[2] / t.HeightasProportioned(bc.biggest.height), child: antiwhiteVertical,)
            : const SizedBox();

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            paddingLeft,
            Expanded(child: LayoutBuilder(
              builder: (c, innerbc) {
                var paddingTop = padding[1] > 0
                    ? AspectRatio(
                        aspectRatio:
                            t.WidthasProportioned(innerbc.biggest.width) /
                                padding[1], child: antiwhite)
                    : SizedBox();
                var paddingBottom = padding[3] > 0
                    ? AspectRatio(
                        aspectRatio: t.WidthasProportioned(bc.biggest.width) /
                            padding[3], child: antiwhite)
                    : SizedBox();

                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    paddingTop,
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: mainAxisAlignment,
                        crossAxisAlignment: crossAxisAlignment,
                        children: [
                          ...addSpacing(
                              cast,
                              spacing,
                              t.WidthasProportioned(innerbc.biggest.width),
                              LayoutOrientation.vertical),
                        ],
                      ),
                    ),
                    paddingBottom
                  ],
                );
              },
            )),
            paddingRight,
          ],
        );
      },
    );
  }
}

class ProportionsRow extends StatelessWidget {
  final List<dynamic> children;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final num spacing;
  final List<num> padding;
  final num defaultDiameter;
  const ProportionsRow(
      {super.key,
      required this.defaultDiameter,
      required this.children,
      this.spacing = 0,
      this.padding = const [0, 0, 0, 0],
      this.mainAxisAlignment = MainAxisAlignment.start,
      this.crossAxisAlignment = CrossAxisAlignment.start});

  @override
  Widget build(BuildContext context) {
    bool measureHeight = defaultDiameter != null;
    var cast = children
        .map((e) => e is Widget
            ? e
            : ((e is Map<dynamic, dynamic>)
                ? Row(
                    children: e.entries
                        .map((ent) => AspectRatio(
                              aspectRatio: measureHeight
                                  ? (ent.key / defaultDiameter)
                                  : ent.key,
                              child: ent.value,
                            ))
                        .toList()
                        .cast<Widget>(),
                  )
                : AspectRatio(
                    aspectRatio: measureHeight ? (e / defaultDiameter!) : e)))
        .toList()
        .cast<Widget>();

    return LayoutBuilder(
      builder: (context, bc) {
        var t = Turner(context);
        return verticalPadding(padding, bc, LayoutBuilder(
          builder: (c, innerbc) {
            return horizontalPadding(
                padding,
                innerbc,
                Row(
                  mainAxisAlignment: mainAxisAlignment,
                  crossAxisAlignment: crossAxisAlignment,
                  children: [
                    ...addSpacing(
                        cast,
                        spacing,
                        t.HeightasProportioned(innerbc.biggest.height),
                        LayoutOrientation.horizontal),
                  ],
                ),
                t);
          },
        ), t);
      },
    );
  }

  Widget verticalPadding(
      List<num> padding, BoxConstraints bc, Widget child, Turner t) {
    final paddingTop = padding[1] > 0
        ? AspectRatio(
            aspectRatio: t.WidthasProportioned(bc.biggest.width) / padding[1], child: antiwhite)
        : SizedBox();
    final paddingBottom = padding[3] > 0
        ? AspectRatio(
            aspectRatio: t.WidthasProportioned(bc.biggest.width) / padding[3], child: antiwhite)
        : SizedBox();

    bool noPaddingTop = paddingTop.runtimeType == SizedBox().runtimeType;
    bool noPaddingBottom = paddingBottom.runtimeType == SizedBox().runtimeType;

    return noPaddingTop && noPaddingBottom
        ? child
        : Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              paddingTop,
              Expanded(child: child),
              paddingBottom,
            ],
          );
  }

  Widget horizontalPadding(
      List<num> padding, BoxConstraints innerbc, Row row, Turner t) {
    final paddingLeft = padding[0] > 0
        ? AspectRatio(
            aspectRatio:
                padding[0] / t.HeightasProportioned(innerbc.biggest.height), child: antiwhiteVertical,)
        : SizedBox();

    final paddingRigth = padding[2] > 0
        ? AspectRatio(
            aspectRatio:
                padding[2] / t.HeightasProportioned(innerbc.biggest.height), child: antiwhiteVertical,)
        : SizedBox();

    bool noPaddingLeft = paddingLeft.runtimeType == SizedBox().runtimeType;
    bool noPaddingRight = paddingRigth.runtimeType == SizedBox().runtimeType;

    return noPaddingLeft && noPaddingRight
        ? row
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              paddingLeft,
              Expanded(
                child: row,
              ),
              paddingRigth,
            ],
          );
  }
}

enum LayoutOrientation { horizontal, vertical }

enum LayoutAlign { min, max, space_between, center, stretch }

class OrientedLayout extends StatelessWidget {
  final LayoutOrientation orientation;
  final LayoutAlign primaryAxisAlignItems;
  final LayoutAlign counterAxisAlignItems;
  final num diameter;
  final num itemSpacing;
  final List<num> padding;
  final List<dynamic> children;

  MainAxisAlignment tomainAxisAlignment(LayoutAlign align) {
    return {
      LayoutAlign.center: MainAxisAlignment.center,
      LayoutAlign.max: MainAxisAlignment.end,
      LayoutAlign.min: MainAxisAlignment.start,
      LayoutAlign.space_between: MainAxisAlignment.spaceBetween,
      LayoutAlign.stretch: MainAxisAlignment.center,
    }[align]!;
  }

  CrossAxisAlignment tocrossAxisAlignment(LayoutAlign align) {
    return {
      LayoutAlign.center: CrossAxisAlignment.center,
      LayoutAlign.max: CrossAxisAlignment.end,
      LayoutAlign.min: CrossAxisAlignment.start,
      LayoutAlign.space_between: CrossAxisAlignment.stretch,
      LayoutAlign.stretch: CrossAxisAlignment.center,
    }[align]!;
  }

  const OrientedLayout(
      {super.key,
      required this.orientation,
      this.itemSpacing = 0,
      required this.children,
      this.primaryAxisAlignItems = LayoutAlign.min,
      this.counterAxisAlignItems = LayoutAlign.min,
      required this.diameter,
      this.padding = const [0, 0, 0, 0]});

  @override
  Widget build(BuildContext context) => switch (orientation) {
        (LayoutOrientation.horizontal) => ProportionsRow(
            mainAxisAlignment: tomainAxisAlignment(primaryAxisAlignItems),
            crossAxisAlignment: tocrossAxisAlignment(primaryAxisAlignItems),
            spacing: itemSpacing,
            defaultDiameter: diameter - (padding[1] + padding[3]),
            padding: padding,
            children: children),
        (LayoutOrientation.vertical) => ProportionsColumn(
            mainAxisAlignment: tomainAxisAlignment(primaryAxisAlignItems),
            crossAxisAlignment: tocrossAxisAlignment(primaryAxisAlignItems),
            spacing: itemSpacing,
            defaultDiameter: diameter - (padding[0] + padding[2]),
            padding: padding,
            children: children,
          )
      };
}

class MinDiameterSupport extends StatelessWidget {
  final LayoutOrientation orientation;
  final LayoutAlign primaryAxisAlignItems;
  final LayoutAlign counterAxisAlignItems;
  final num diameter;
  final num maximumDiameter;
  final List<num?>? padding;
  final Widget child;
  final num length;

  const MinDiameterSupport(
      {super.key,
      required this.orientation,
      this.primaryAxisAlignItems = LayoutAlign.min,
      this.counterAxisAlignItems = LayoutAlign.min,
      required this.diameter,
      required this.length,
      required this.maximumDiameter,
      required this.child,
      this.padding});

  Alignment layoutAlignToAlign(LayoutAlign x, LayoutAlign y) {
    Map<LayoutAlign, double> a = {
      LayoutAlign.min: -1.0,
      LayoutAlign.center: 0.0,
      LayoutAlign.max: 1.0,
      LayoutAlign.space_between: 0.0,
      LayoutAlign.stretch: 0.0,
    };

    return orientation == LayoutOrientation.horizontal
        ? Alignment(a[x]!, a[y]!)
        : Alignment(a[y]!, a[x]!);
  }

  @override
  Widget build(BuildContext context) => switch (orientation) {
        (LayoutOrientation.horizontal) => AspectRatio(
            aspectRatio: length / maximumDiameter,
            child: Align(
              alignment: layoutAlignToAlign(
                  primaryAxisAlignItems, counterAxisAlignItems),
              child: AspectRatio(
                aspectRatio: length / diameter,
                child: child,
              ),
            ),
          ),
        (LayoutOrientation.vertical) => AspectRatio(
            aspectRatio: maximumDiameter / length,
            child: Align(
              alignment: layoutAlignToAlign(
                  primaryAxisAlignItems, counterAxisAlignItems),
              child: AspectRatio(
                aspectRatio: diameter / length,
                child: child,
              ),
            ),
          )
      };
}
