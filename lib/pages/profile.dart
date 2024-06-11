import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:platter/change_notifiers/AppStatusNotifier.dart';
import 'package:platter/layout.dart';
import 'package:platter/layout_text.dart';
import 'package:platter/mobile_constants.dart';
import 'package:platter/models/Jwt.dart';
import 'package:provider/provider.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    AppStatusNotifier notifier =
        Provider.of<AppStatusNotifier>(context, listen: false);
    Jwt? session = notifier.session;

    print(jsonEncode(session?.toJson()));
    return SingleChildScrollView(
      child: AspectRatio(
        aspectRatio: 485 / 1300,
        child: OrientedLayout(
            orientation: LayoutOrientation.vertical,
            primaryAxisAlignItems: LayoutAlign.min,
            counterAxisAlignItems: LayoutAlign.center,
            diameter: 363.75,
            padding: const [0, 0, 0, 0],
            itemSpacing: 0,
            children: [
              const SafeArea(child: SizedBox.shrink()),
              {69: antiwhite},
              {
                136: MinDiameterSupport(
                    diameter: 136,
                    length: 136,
                    maximumDiameter: 363.75,
                    orientation: LayoutOrientation.vertical,
                    primaryAxisAlignItems: LayoutAlign.min,
                    counterAxisAlignItems: LayoutAlign.center,
                    child: DecoratedBox(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: NetworkImage(
                                    'https://upload.wikimedia.org/wikipedia/commons/8/89/Portrait_Placeholder.png?20170328184010')))))
              },
              {30.75: antiwhite},
              {
                32: LayoutText(session?.user?.username ?? 'placeholder',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: "Noto Serif HK",
                        height: 1.4545454545454546))
              },
              {49.63500213623047: antiwhite},
              // {
              //   135.36500549316406: DecoratedBox(
              //       decoration: BoxDecoration(
              //           border: Border(
              //               top: BorderSide(width: 2, color: Colors.black))),
              //       child: OrientedLayout(
              //           orientation: LayoutOrientation.horizontal,
              //           primaryAxisAlignItems: LayoutAlign.center,
              //           counterAxisAlignItems: LayoutAlign.min,
              //           diameter: 135.36500549316406,
              //           padding: const [42, 4.364999771118164, 42, 0],
              //           itemSpacing: 0,
              //           children: [
              //             {
              //               139.875: const MinDiameterSupport(
              //                   diameter: 139.875,
              //                   length: 131,
              //                   maximumDiameter: 135.36500549316406,
              //                   orientation: LayoutOrientation.horizontal,
              //                   primaryAxisAlignItems: LayoutAlign.center,
              //                   counterAxisAlignItems: LayoutAlign.min,
              //                   child: OrientedLayout(
              //                       orientation: LayoutOrientation.vertical,
              //                       primaryAxisAlignItems: LayoutAlign.min,
              //                       counterAxisAlignItems: LayoutAlign.min,
              //                       diameter: 139.875,
              //                       padding: [0, 0, 0, 0],
              //                       itemSpacing: 0,
              //                       children: [
              //                         {
              //                           29: LayoutText('Summary',
              //                               textAlign: TextAlign.center,
              //                               style: TextStyle(
              //                                   fontFamily: 'DM Sans',
              //                                   fontWeight: FontWeight.bold,
              //                                   height: 1.3181818181818181))
              //                         },
              //                         {
              //                           20: DecoratedBox(
              //                               decoration: BoxDecoration())
              //                         },
              //                         {
              //                           41: LayoutText('· Likes carrots ',
              //                               style: TextStyle(
              //                                   fontFamily: "Noto Serif HK",
              //                                   height: 2.54))
              //                         },
              //                         {
              //                           41: LayoutText('· Likes carrots ',
              //                               style: TextStyle(
              //                                   fontFamily: "Noto Serif HK",
              //                                   height: 2.54))
              //                         }
              //                       ]))
              //             },
              //             {
              //               139.875: const MinDiameterSupport(
              //                   diameter: 139.875,
              //                   length: 131,
              //                   maximumDiameter: 135.36500549316406,
              //                   orientation: LayoutOrientation.horizontal,
              //                   primaryAxisAlignItems: LayoutAlign.center,
              //                   counterAxisAlignItems: LayoutAlign.min,
              //                   child: OrientedLayout(
              //                       orientation: LayoutOrientation.vertical,
              //                       primaryAxisAlignItems: LayoutAlign.min,
              //                       counterAxisAlignItems: LayoutAlign.min,
              //                       diameter: 139.875,
              //                       padding: [0, 0, 0, 0],
              //                       itemSpacing: 0,
              //                       children: [
              //                         {
              //                           29: LayoutText('Diet',
              //                               textAlign: TextAlign.center,
              //                               style: TextStyle(
              //                                   fontFamily: 'DM Sans',
              //                                   fontWeight: FontWeight.bold,
              //                                   height: 1.3181818181818181))
              //                         },
              //                         {
              //                           20: DecoratedBox(
              //                               decoration: BoxDecoration())
              //                         },
              //                         {
              //                           82: LayoutText(
              //                               '· under a medical diet.',
              //                               style: TextStyle(
              //                                   fontFamily: "Noto Serif HK",
              //                                   height: 2.54))
              //                         }
              //                       ]))
              //             }
              //           ]))
              // }
         
            ]),
      ),
    );
  }
}
