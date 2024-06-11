import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:platter/change_notifiers/AppStatusNotifier.dart';
import 'package:platter/components/ScreenAspectRatioContainer.dart';
import 'package:platter/content_suite.dart';
import 'package:platter/layout.dart';
import 'package:platter/layout_text.dart';
import 'package:platter/mobile_constants.dart';
import 'package:platter/pages/collection.dart';
import 'package:platter/pages/home.dart';
import 'package:platter/pages/product_matches.dart';
import 'package:platter/pages/profile.dart';
import 'package:provider/provider.dart';

class DialogExample extends StatelessWidget {
  const DialogExample({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => showDialog<String>(
        context: context,
        useRootNavigator: true,
        builder: (BuildContext context) => const Dialog.fullscreen(
          child: Menu(),
        ),
      ),
      child: const Text('Show Dialog'),
    );
  }
}

class Menu extends StatelessWidget {
  const Menu({
    super.key,
  });

  void navigateTo(BuildContext context, String name) {
    AppStatusNotifier notifier = Provider.of<AppStatusNotifier>(context, listen: false);
    navigatorGrandKey.currentState!.pop();

    switch (name) {
      case "home":
        navigatorGrandKey.currentState!.pushNamed('home', arguments: { "CONTENT": CONTENT_SUITE( context, "home"),});
        break;
      case "my collection":
        navigatorGrandKey.currentState!.pushNamed('library', arguments: 
        {"CONTENT": notifier.recipeLikebyUser(notifier.session?.user?.id.toString() ?? '')});
        break;
      case "recent matches":
        navigatorGrandKey.currentState!.pushNamed('recent_history');
        break;
      case "profile":
        navigatorGrandKey.currentState!.pushNamed('profile');
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    var textStyle =
        TextStyle(height: 1.4444444444444444, fontFamily: "Noto Serif HK");
    return Padding(
      padding: EdgeInsets.all(10),
      child: ScreenAspectRatioContainer(
        child: Align(
          alignment: Alignment.center,
          child: MinDiameterSupport(
              diameter: 379 * 0.75,
              length: 505,
              maximumDiameter: 485 * 0.75,
              orientation: LayoutOrientation.vertical,
              primaryAxisAlignItems: LayoutAlign.center,
              counterAxisAlignItems: LayoutAlign.center,
              child: DecoratedBox(
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shadows: [
                      BoxShadow(
                          spreadRadius: -5,
                          blurRadius: 30,
                          color: Colors.grey.shade500)
                    ],
                    shape: SmoothRectangleBorder(
                      borderRadius: SmoothBorderRadius(
                        cornerRadius: 34,
                        cornerSmoothing: 1,
                      ),
                    ),
                  ),
                  child: OrientedLayout(
                      orientation: LayoutOrientation.vertical,
                      primaryAxisAlignItems: LayoutAlign.min,
                      counterAxisAlignItems: LayoutAlign.center,
                      diameter: 379 * 0.75,
                      padding: [0, 44, 0, 10],
                      itemSpacing: 0,
                      children: [
                        {
                          79.00003051757812: GestureDetector(
                            onTap: () => navigateTo(context,'home'),
                            child:OrientedLayout(
                              orientation: LayoutOrientation.vertical,
                              primaryAxisAlignItems: LayoutAlign.min,
                              counterAxisAlignItems: LayoutAlign.min,
                              diameter: 378 * 0.75,
                              padding: [29, 0, 29, 0],
                              itemSpacing: 0,
                              children: [
                                {21: antiwhite},
                                {
                                  30: OrientedLayout(
                                      orientation: LayoutOrientation.horizontal,
                                      primaryAxisAlignItems: LayoutAlign.min,
                                      counterAxisAlignItems: LayoutAlign.center,
                                      diameter: 30,
                                      padding: [0, 0, 0, 0],
                                      itemSpacing: 11,
                                      children: [
                                        {
                                          24: SvgPicture.asset(
                                              'assets/House_02.svg')
                                        },
                                        {
                                          53: OrientedLayout(
                                              orientation:
                                                  LayoutOrientation.vertical,
                                              primaryAxisAlignItems:
                                                  LayoutAlign.min,
                                              counterAxisAlignItems:
                                                  LayoutAlign.min,
                                              diameter: 53,
                                              padding: [0, 0, 0, 0],
                                              itemSpacing: 10,
                                              children: [
                                                {
                                                  26: LayoutText('Home',
                                                      style: textStyle)
                                                }
                                              ])
                                        }
                                      ])
                                },
                                {
                                  28: DecoratedBox(
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  width: 1,
                                                  color: Color(0xFFD1C2C2)))))
                                }
                              ])
                       ) },
                        {
                          79.00003051757812: GestureDetector(
                            onTap: () => navigateTo(context,'my collection'),
                            child: OrientedLayout(
                              orientation: LayoutOrientation.vertical,
                              primaryAxisAlignItems: LayoutAlign.min,
                              counterAxisAlignItems: LayoutAlign.min,
                              diameter: 378 * 0.75,
                              padding: [29, 0, 29, 0],
                              itemSpacing: 0,
                              children: [
                                {21: antiwhite},
                                {
                                  30: OrientedLayout(
                                      orientation: LayoutOrientation.horizontal,
                                      primaryAxisAlignItems: LayoutAlign.min,
                                      counterAxisAlignItems: LayoutAlign.center,
                                      diameter: 30,
                                      padding: [0, 0, 0, 0],
                                      itemSpacing: 11,
                                      children: [
                                        {
                                          24: SvgPicture.asset(
                                              'assets/Book_Open.svg')
                                        },
                                        {
                                          119: OrientedLayout(
                                              orientation:
                                                  LayoutOrientation.vertical,
                                              primaryAxisAlignItems:
                                                  LayoutAlign.min,
                                              counterAxisAlignItems:
                                                  LayoutAlign.min,
                                              diameter: 119,
                                              padding: [0, 0, 0, 0],
                                              itemSpacing: 10,
                                              children: [
                                                {
                                                  26: LayoutText(
                                                      'My collection',
                                                      style: textStyle)
                                                }
                                              ])
                                        }
                                      ])
                                },
                                {
                                  28: DecoratedBox(
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  width: 1,
                                                  color: Color(0xFFD1C2C2)))))
                                }
                              ])
                        ,)},
                        {
                          79.00003051757812: GestureDetector(
                            onTap: () => navigateTo(context,'recent matches'),
                            child:OrientedLayout(
                              orientation: LayoutOrientation.vertical,
                              primaryAxisAlignItems: LayoutAlign.min,
                              counterAxisAlignItems: LayoutAlign.min,
                              diameter: 378 * 0.75,
                              padding: [29, 0, 29, 0],
                              itemSpacing: 0,
                              children: [
                                {21: antiwhite},
                                {
                                  30: OrientedLayout(
                                      orientation: LayoutOrientation.horizontal,
                                      primaryAxisAlignItems: LayoutAlign.min,
                                      counterAxisAlignItems: LayoutAlign.center,
                                      diameter: 30,
                                      padding: [0, 0, 0, 0],
                                      itemSpacing: 11,
                                      children: [
                                        {
                                          24: SvgPicture.asset(
                                              'assets/Arrow_Reload_02.svg')
                                        },
                                        {
                                          139: OrientedLayout(
                                              orientation:
                                                  LayoutOrientation.vertical,
                                              primaryAxisAlignItems:
                                                  LayoutAlign.min,
                                              counterAxisAlignItems:
                                                  LayoutAlign.min,
                                              diameter: 139,
                                              padding: [0, 0, 0, 0],
                                              itemSpacing: 10,
                                              children: [
                                                {
                                                  26: LayoutText(
                                                      'Recent history',
                                                      style: textStyle)
                                                }
                                              ])
                                        }
                                      ])
                                },
                                {
                                  28: DecoratedBox(
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  width: 1,
                                                  color: Color(0xFFD1C2C2)))))
                                }
                              ])
                   ) },
                        {
                          79.00003051757812:GestureDetector(
                            onTap: () => navigateTo(context,'profile'),
                            child: OrientedLayout(
                              orientation: LayoutOrientation.vertical,
                              primaryAxisAlignItems: LayoutAlign.min,
                              counterAxisAlignItems: LayoutAlign.min,
                              diameter: 378 * 0.75,
                              padding: [29, 0, 29, 0],
                              itemSpacing: 0,
                              children: [
                                {21: antiwhite},
                                {
                                  30: OrientedLayout(
                                      orientation: LayoutOrientation.horizontal,
                                      primaryAxisAlignItems: LayoutAlign.min,
                                      counterAxisAlignItems: LayoutAlign.center,
                                      diameter: 30,
                                      padding: [0, 0, 0, 0],
                                      itemSpacing: 11,
                                      children: [
                                        {
                                          24: SvgPicture.asset(
                                              'assets/User_03.svg')
                                        },
                                        {
                                          90: OrientedLayout(
                                              orientation:
                                                  LayoutOrientation.vertical,
                                              primaryAxisAlignItems:
                                                  LayoutAlign.min,
                                              counterAxisAlignItems:
                                                  LayoutAlign.min,
                                              diameter: 90,
                                              padding: [0, 0, 0, 0],
                                              itemSpacing: 10,
                                              children: [
                                                {
                                                  26: LayoutText('My profile',
                                                      style: textStyle)
                                                }
                                              ])
                                        }
                                      ])
                                },
                                {28: antiwhite}
                              ])
                      )    },
                        {33: antiwhite},
                        {
                          86: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: MinDiameterSupport(
                                diameter: 99,
                                length: 86,
                                maximumDiameter: 378 * 0.75,
                                orientation: LayoutOrientation.vertical,
                                primaryAxisAlignItems: LayoutAlign.min,
                                counterAxisAlignItems: LayoutAlign.center,
                                child: LayoutText('Platter',
                                    textAlign: TextAlign.center,
                                    idtext: 'Platter\n\nGreat vibes',
                                    children: [
                                      TextSpan(
                                          text: '\n\nGreat vibes',
                                          style: TextStyle(
                                              height: 1.5555555555555556,
                                              fontFamily: "DM Sans",
                                              fontWeight: FontWeight.w500))
                                    ],
                                    style: TextStyle(
                                        height: 1.5555555555555556,
                                        fontFamily: "Noto Serif HK",
                                        fontWeight: FontWeight.bold))),
                          )
                        }
                      ]))),
        ),
      ),
    );
  }
}

class MenuButton extends StatelessWidget {
  final bool last;
  const MenuButton({
    super.key,
    required this.assetName,
    required this.text2,
    this.last = false,
  });

  final String assetName;
  final String text2;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  color: last ? Colors.transparent : const Color(0xFFD1C2C2)))),
      child: OrientedLayout(
          orientation: LayoutOrientation.vertical,
          primaryAxisAlignItems: LayoutAlign.center,
          counterAxisAlignItems: LayoutAlign.min,
          diameter: 378 * 0.75,
          padding: [29, 0, 29, 0],
          itemSpacing: 0,
          children: [
            {21: antiwhite},
            {
              30: OrientedLayout(
                  orientation: LayoutOrientation.horizontal,
                  primaryAxisAlignItems: LayoutAlign.min,
                  counterAxisAlignItems: LayoutAlign.center,
                  diameter: 30,
                  padding: [0, 0, 0, 0],
                  itemSpacing: 11,
                  children: [
                    {
                      24: MinDiameterSupport(
                          diameter: 24,
                          length: 24,
                          maximumDiameter: 30,
                          orientation: LayoutOrientation.horizontal,
                          primaryAxisAlignItems: LayoutAlign.min,
                          counterAxisAlignItems: LayoutAlign.center,
                          child: LayoutBuilder(
                            builder: (context, bc) => SvgPicture.asset(
                              assetName,
                              height: bc.biggest.height,
                            ),
                          ))
                    },
                    {
                      200: OrientedLayout(
                          orientation: LayoutOrientation.vertical,
                          primaryAxisAlignItems: LayoutAlign.center,
                          counterAxisAlignItems: LayoutAlign.min,
                          diameter: 200,
                          padding: [0, 0, 0, 0],
                          itemSpacing: 10,
                          children: [
                            {
                              26: LayoutText(text2,
                                  style: const TextStyle(
                                      fontFamily: "Noto Serif HK",
                                      height: 1.444444444))
                            }
                          ])
                    }
                  ])
            },
            {21: antiwhite}
          ]),
    );
  }
}
