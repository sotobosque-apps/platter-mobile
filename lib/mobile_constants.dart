import 'dart:ui';

import 'package:flutter/material.dart';

final List<int> unicodeCodePoints = List.generate(0x1F9CF - 0x1F600 + 1, (i) => 0x1F600 + i);
  final lerped_black_02 =
      lerped_black_0(const Color.fromRGBO(0, 170, 255, 1), 0.97);
  final lerped_black_03 =
      lerped_black_0(Color.fromARGB(255, 208, 0, 255), 0.025);

final globalWallCandie = Image.asset(
  "assets/backgrounds/Mask group.png",
  gaplessPlayback: true,
  // colorBlendMode: BlendMode.dstATop, 
  fit: BoxFit.fill,
  opacity: const AlwaysStoppedAnimation(0.25),
);

// opacity: const AlwaysStoppedAnimation(0.01),
// opacity: const AlwaysStoppedAnimation(0.0075),

final globalWallCandieB = Image.asset(
  "assets/backgrounds/candie 1.png",
  colorBlendMode: BlendMode.colorBurn,
  gaplessPlayback: true,
  fit: BoxFit.fill,
  opacity: const AlwaysStoppedAnimation(0.25),
);

const Widget antiwhite = Image(
  image: AssetImage("assets/backgrounds/horizontal.png"),
  filterQuality: FilterQuality.high,
  color: Color.fromRGBO(255, 255, 255, 0.015),
  colorBlendMode: BlendMode.modulate,
  fit: BoxFit.fill,
);

const antiwhiteVertical = Image(
  image: AssetImage("assets/backgrounds/vertical.png"),
  filterQuality: FilterQuality.high,
  color: Color.fromRGBO(255, 255, 255, 0.025),
  colorBlendMode: BlendMode.modulate,
  fit: BoxFit.fill,
);

final globalWallCandieC = Image.asset(
  "assets/backgrounds/candie 2.png",
  colorBlendMode: BlendMode.colorBurn,
  gaplessPlayback: true,
  fit: BoxFit.fill,
  opacity: const AlwaysStoppedAnimation(0.5),
);

final globalWallBlur0 = IgnorePointer(
    child: ClipRRect(
  // Clip it cleanly.
  child: BackdropFilter(
    filter: ImageFilter.blur(sigmaX: 0.075, sigmaY: 0.075),
    child: Container(
      color: Colors.grey.withOpacity(0.01),
      alignment: Alignment.center,
    ),
  ),
));
// const globalSideMenu = SideMenu();
// const globalBottombar = BottomBar();

const specialBlack_0 = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFF0A0101), Color(0xFF010000)]);

const specialGreen = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color.fromRGBO(3, 44, 2, 1),
      Color.fromRGBO(2, 30, 18, 1),
      Color.fromRGBO(30, 2, 40, 1)
      // const HSLColor.fromAHSL(1, (119 / 255) * 1, (91 / 255) * 1, (9 / 255) * 1)
      //     .toColor(),
      // const HSLColor.fromAHSL(1, (154 / 255) * 1, (87 / 255) * 1, (6 / 255) * 1)
      //     .toColor(),
      // const HSLColor.fromAHSL(1, (284 / 255) * 1, (90 / 255) * 1, (8 / 255) * 1)
      //     .toColor(),
    ],
    stops: [
      0,
      0.8125,
      1,
    ]);

const black_0 = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF120104),
      Color.fromARGB(255, 53, 51, 68),
      Color.fromARGB(255, 41, 45, 53),
    ],
    stops: [
      0,
      0.58,
      1
    ]);

const yellow_0 = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color.fromARGB(255, 18, 14, 1),
      Color.fromARGB(255, 51, 68, 58),
      Color.fromARGB(255, 41, 53, 53)
    ],
    stops: [
      0,
      0.58,
      1
    ]);
LinearGradient lerped_black_0(Color color, double double) => LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color.lerp(Color.fromARGB(255, 18, 14, 1), color, double)!,
          Color.lerp(Color.fromARGB(255, 51, 68, 58), color, double)!,
          Color.lerp(Color.fromARGB(255, 41, 53, 53), color, double)!,
        ],
        stops: [
          0,
          0.58,
          1
        ]);

LinearGradient lerped_black_1(Color color, double double,
        {List<Color>? colors = null}) =>
    LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: colors != null
            ? colors.map((e) => Color.lerp(e, color, double)!).toList()
            : [
                Color.lerp(Color.fromARGB(255, 18, 14, 1), color, double)!,
                Color.lerp(Color.fromARGB(255, 51, 68, 58), color, double)!,
                Color.lerp(Color.fromARGB(255, 41, 53, 53), color, double)!,
              ],
        stops: [0, 0.58, 1]);

const black_0_hard = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color.fromRGBO(18, 1, 4, 1),
      Color.fromARGB(255, 16, 15, 20),
      Color.fromARGB(255, 10, 11, 14),
    ],
    stops: [
      0,
      0.58,
      1
    ]);

const black_0_reverse = LinearGradient(
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
    colors: [
      Color.fromARGB(255, 41, 45, 53),
      Color.fromARGB(255, 53, 51, 68),
      Color(0xFF120104),
    ],
    stops: [
      0,
      0.58,
      1
    ]);

// const bacco = Color(0xFF919191);
const black_1 = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color.fromRGBO(15, 0, 0, 0.22),
      Color.fromRGBO(4, 0, 15, 0.22),
      Color.fromRGBO(42, 49, 55, 1 / 3),
    ],
    stops: [
      0,
      0.58,
      1
    ]);
const black_1_reverse = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color.fromRGBO(42, 49, 55, 1 / 3),
      Color.fromRGBO(42, 43, 55, 0.325),
      Color.fromRGBO(15, 0, 0, 0.22),
    ],
    stops: [
      0,
      0.58,
      1
    ]);
const black_1b = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color.fromRGBO(15, 0, 0, 0.05),
      Color.fromRGBO(42, 49, 55, 0.15),
    ],
    stops: [
      0,
      0.74
    ]);

const black_2 = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color.fromRGBO(25, 0, 0, 0.65),
      Color.fromRGBO(42, 49, 55, 0.75),
    ],
    stops: [
      0,
      0.58
    ]);

final DecorationTween decorationTween = DecorationTween(
  end: const BoxDecoration(
    border: Border(
        top: BorderSide(width: 1, color: Color.fromARGB(255, 235, 235, 235)),
        bottom: BorderSide(width: 1, color: Color.fromARGB(255, 235, 235, 235)),
        left: BorderSide(width: 1, color: Color.fromARGB(255, 235, 235, 235)),
        right: BorderSide(width: 1, color: Color.fromARGB(255, 235, 235, 235))),
    color: Color(0xFFfffdff),
    borderRadius: BorderRadius.all(Radius.circular(4)),
  ),
  begin: const BoxDecoration(
    border: Border(
        top: BorderSide(width: 1, color: Color.fromARGB(255, 235, 235, 235)),
        bottom: BorderSide(width: 1, color: Color.fromARGB(255, 235, 235, 235)),
        left: BorderSide(width: 1, color: Color.fromARGB(255, 235, 235, 235)),
        right: BorderSide(width: 1, color: Color.fromARGB(255, 235, 235, 235))),
    color: Color(0xFFfffdff),
    borderRadius: BorderRadius.all(Radius.circular(4)),
  ),
);

final DecorationTween decorationTween_0 = DecorationTween(
  end: const BoxDecoration(
    border: Border(
        top: BorderSide(width: 1, color: Color.fromARGB(255, 117, 117, 117)),
        bottom: BorderSide(width: 1, color: Color.fromARGB(255, 117, 117, 117)),
        left: BorderSide(width: 1, color: Color.fromARGB(255, 117, 117, 117)),
        right: BorderSide(width: 1, color: Color.fromARGB(255, 117, 117, 117))),
    color: Color(0xFFfffdff),
    borderRadius: BorderRadius.all(Radius.circular(4)),
  ),
  begin: const BoxDecoration(
    border: Border(
        top: BorderSide(width: 1, color: Color.fromARGB(255, 235, 235, 235)),
        bottom: BorderSide(width: 1, color: Color.fromARGB(255, 235, 235, 235)),
        left: BorderSide(width: 1, color: Color.fromARGB(255, 235, 235, 235)),
        right: BorderSide(width: 1, color: Color.fromARGB(255, 235, 235, 235))),
    color: Color(0xFFfffdff),
    borderRadius: BorderRadius.all(Radius.circular(4)),
  ),
);

final navigatorGrandKey = GlobalKey<NavigatorState>();
final scaffoldGrandKey = GlobalKey<ScaffoldState>();
final emptyScaffoldGrandKey = GlobalKey<ScaffoldState>();
final bottomsheetGrandKey = GlobalKey();

const scaleIn_begin = 0.80;
const scaleIn_end = 1.0;
const scaleIn_curve = Curves.decelerate;
final scaleIn_tween = Tween(begin: scaleIn_begin, end: scaleIn_end)
    .chain(CurveTween(curve: scaleIn_curve));

const scaleIn_begin1 = 0.33;
const scaleIn_end1 = 1.0;
const scaleIn_curve1 = Curves.decelerate;
final scaleIn_tween1 = Tween(begin: scaleIn_begin1, end: scaleIn_end1)
    .chain(CurveTween(curve: scaleIn_curve1));

const defaultIconShadow = [
  BoxShadow(
    offset: Offset(0, 1),
    blurRadius: 40,
    color: Color.fromARGB(10, 26, 30, 255),
  ),
  BoxShadow(
    offset: Offset(0, -1),
    blurRadius: 40,
    color: Color.fromARGB(10, 83, 255, 26),
  ),
];

const defaultIconShadowB = [
  BoxShadow(
    offset: Offset(0, 1),
    blurRadius: 6,
    color: Color.fromARGB(5, 26, 30, 255),
  ),
  BoxShadow(
    offset: Offset(0, -1),
    blurRadius: 6,
    color: Color.fromARGB(5, 83, 255, 26),
  ),
];


const defaultIconShadowC = [
  BoxShadow(
    offset: Offset(0, 1),
    blurRadius: 3,
    color: Color.fromARGB(5, 26, 30, 255),
  ),
  BoxShadow(
    offset: Offset(0, -1),
    blurRadius: 3,
    color: Color.fromARGB(5, 83, 255, 26),
  ),
];

const defaultIconShadowD = [
  BoxShadow(
    offset: Offset(0, 1),
    blurRadius: 40,
    
    color: Color.fromARGB(2, 26, 30, 255),
  ),
  BoxShadow(
    offset: Offset(0, -1),
    blurRadius: 40,
    color: Color.fromARGB(2, 83, 255, 26),
  ),
];

Route scaleIn(Widget page, {Duration? duration, backgroundColor = 0xFFfffdff}) {
  return PageRouteBuilder(
    transitionDuration: duration ?? const Duration(milliseconds: 150),
    reverseTransitionDuration: duration ?? const Duration(milliseconds: 150),
    pageBuilder: (context, animation, secondaryAnimation) => page,
    barrierColor: Colors.transparent,
    transitionsBuilder: (context, animation, secondaryAnimation, page) {
      return FadeTransition(
        opacity: animation.drive((scaleIn_tween1)),
        child: ScaleTransition(
          scale: animation.drive(scaleIn_tween),
          child: DecoratedBox(
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(61, 0, 0, 0),
                  blurRadius: 100,
                  offset: Offset(-4, 4), // Shadow positionx
                ),
              ],
            ),
            child: ColoredBox(
              color: Color(backgroundColor),
              child: page,
            ),
          ),
        ),
      );
    },
  );
}

Route scaleInHero(Widget page,
    {Duration? duration, backgroundColor = 0xFFfffdff}) {
  return PageRouteBuilder(
    transitionDuration: duration ?? const Duration(milliseconds: 150),
    reverseTransitionDuration: duration ?? const Duration(milliseconds: 150),
    pageBuilder: (context, animation, secondaryAnimation) => page,
    barrierColor: Colors.transparent,
    opaque: false,
    transitionsBuilder: (context, animation, secondaryAnimation, page) {
      return ColoredBox(
        color: Colors.white,
        child: page,
      );
    },
  );
}

const curve = Curves.decelerate;
var tween = Tween(begin: const Offset(0.0, 0.25), end: Offset.zero)
    .chain(CurveTween(curve: curve));

const curve2 = Curves.easeInToLinear;
var tween2 = Tween(begin: 0.0, end: 1.0).chain(CurveTween(curve: curve2));

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}

final kInnerDecoration = BoxDecoration(
  color: Colors.white,
  border: Border.all(color: Colors.white),
);

final kGradientBoxDecoration = BoxDecoration(
  gradient: const LinearGradient(colors: [Colors.black, Colors.redAccent]),
  border: Border.all(
    color: Colors.blue,
  ),
);
