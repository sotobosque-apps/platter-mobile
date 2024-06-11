import 'package:flutter/material.dart';
import 'package:platter/fonts.dart';
import 'package:platter/layout.dart';
import 'package:platter/layout_text.dart';

// final Map<String, Widget> page= {
//   "sign_in":
//   // "sign_up"
// };

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return OrientedLayout(
        orientation: LayoutOrientation.vertical,
        primaryAxisAlignItems: LayoutAlign.min,
        counterAxisAlignItems: LayoutAlign.min,
        diameter: 363.75,
        padding: [24, 0, 30.75, 0],
        itemSpacing: 0,
        children: [
          {58: DecoratedBox(decoration: BoxDecoration())},
          {
            42: MinDiameterSupport(
                diameter: 229,
                length: 42,
                maximumDiameter: 363.75,
                orientation: LayoutOrientation.vertical,
                primaryAxisAlignItems: LayoutAlign.min,
                counterAxisAlignItems: LayoutAlign.min,
                child: LayoutText('Affiliated store', style: TextStyle()))
          },
          {
            421: OrientedLayout(
                orientation: LayoutOrientation.horizontal,
                primaryAxisAlignItems: LayoutAlign.min,
                counterAxisAlignItems: LayoutAlign.min,
                diameter: 421,
                padding: [25.5, 115, 0, 124],
                itemSpacing: 131,
                children: [
                  {
                    112: OrientedLayout(
                        orientation: LayoutOrientation.vertical,
                        primaryAxisAlignItems: LayoutAlign.min,
                        counterAxisAlignItems: LayoutAlign.min,
                        diameter: 112,
                        padding: [0, 0, 0, 0],
                        itemSpacing: 22,
                        children: [
                          {125: DecoratedBox(decoration: BoxDecoration())},
                          {
                            35: LayoutText(
                                'Tasty Every Day: All of the Flavor, None ',
                                style: TextStyle())
                          }
                        ])
                  },
                  {
                    112: MinDiameterSupport(
                        diameter: 112,
                        length: 177,
                        maximumDiameter: 421,
                        orientation: LayoutOrientation.horizontal,
                        primaryAxisAlignItems: LayoutAlign.min,
                        counterAxisAlignItems: LayoutAlign.min,
                        child: OrientedLayout(
                            orientation: LayoutOrientation.vertical,
                            primaryAxisAlignItems: LayoutAlign.min,
                            counterAxisAlignItems: LayoutAlign.min,
                            diameter: 112,
                            padding: [0, 0, 0, 0],
                            itemSpacing: 22,
                            children: [
                              {125: DecoratedBox(decoration: BoxDecoration())},
                              {
                                30: LayoutText(
                                    'Tasty Every Day: All of the Flavor, None ',
                                    style: TextStyle())
                              }
                            ]))
                  }
                ])
          }
        ]);
    ;
  }
}
