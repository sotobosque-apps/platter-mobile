
import 'package:flutter/material.dart';
import 'package:platter/change_notifiers/AppStatusNotifier.dart';
import 'package:platter/fonts.dart';
import 'package:platter/layout.dart';
import 'package:platter/layout_text.dart';
import 'package:platter/mobile_constants.dart';
import 'package:provider/provider.dart';
import 'package:textwrap/textwrap.dart';

class HomeSearch extends StatelessWidget {
  HomeSearch({super.key});
  final textEditingController = TextEditingController();
  // @override
  // void dispose() {
  //   // Clean up the controller when the widget is removed from the widget tree.
  //   // This also removes the _printLatestValue listener.
  //   textEditingController.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    textEditingController.addListener(
      () {
        // textEditingController.s
      },
    );

    final AppStatusNotifier notifier =
      Provider.of<AppStatusNotifier>(context, listen: false);
    return SingleChildScrollView(
      child: AspectRatio(
        aspectRatio: 485 / 1800,
        child: OrientedLayout(
            orientation: LayoutOrientation.vertical,
            primaryAxisAlignItems: LayoutAlign.min,
            counterAxisAlignItems: LayoutAlign.center,
            diameter: 363.75,
            padding: [25.5, 0, 37, 0],
            itemSpacing: 0,
            children: [
              SafeArea(child: SizedBox.shrink()),
              {18: antiwhite},
              {
                66: DecoratedBox(
                  decoration: BoxDecoration(
                      border:
                          Border.all(color: const Color(0xFF9E9E9E), width: 1)),
                  child: OrientedLayout(
                      orientation: LayoutOrientation.horizontal,
                      primaryAxisAlignItems: LayoutAlign.min,
                      counterAxisAlignItems: LayoutAlign.max,
                      diameter: 66,
                      padding: const [
                        33 * 0.75,
                        11 * 0.75,
                        33 * 0.75,
                        11 * 0.75
                      ],
                      itemSpacing: 0,
                      children: [
                        // Expanded(, child: ColoredBox(color: Colors.red,),)
                        {
                          320: MinDiameterSupport(
                              diameter: 30.75,
                              length: 320,
                              maximumDiameter: 66,
                              orientation: LayoutOrientation.horizontal,
                              primaryAxisAlignItems: LayoutAlign.min,
                              counterAxisAlignItems: LayoutAlign.max,
                              child: LayoutTextInput('Any name & ingredient',
                                  onSubmit: (v) {
                                navigatorGrandKey.currentState!
                                    .pushNamed("searcher_results", arguments: {
                                  "query": v,
                                  "CONTENT": notifier.fatsecretConsumer(
                                      'recipes.search.v3',
                                      {"search_expression": v, "page_number": "0"})
                                });
                              },
                                  textEditingController: textEditingController,
                                  maxLines: 1,
                                  style: fonts["common DM Serif Text"]!
                                      .copyWith(height: 1.3666666666666667)))
                        }
                      ]),
                )
              },
              {
                44: MinDiameterSupport(
                    diameter: 74,
                    length: 44,
                    maximumDiameter: 485,
                    orientation: LayoutOrientation.vertical,
                    primaryAxisAlignItems: LayoutAlign.min,
                    counterAxisAlignItems: LayoutAlign.center,
                    child: DecoratedBox(decoration: BoxDecoration()))
              },
              {
                31: LayoutText('Search Simplified!',
                    idtext: 'Search simplified!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: "DM Sans",
                        height: 1.2938230383973288,
                        fontWeight: FontWeight.w500))
              },
              {
                51: MinDiameterSupport(
                    diameter: 74,
                    length: 51,
                    maximumDiameter: 485,
                    orientation: LayoutOrientation.vertical,
                    primaryAxisAlignItems: LayoutAlign.min,
                    counterAxisAlignItems: LayoutAlign.center,
                    child: DecoratedBox(decoration: BoxDecoration()))
              },
              {
                19: LayoutText('All categories',
                    idtext: 'All categories',
                    letterSpacing: 0.01,
                    textAlign: TextAlign.center,
                    children: [],
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        height: 1.1904761904761905,
                        fontFamily: "Inter"))
              },
              {
                19: MinDiameterSupport(
                    diameter: 74,
                    length: 19,
                    maximumDiameter: 485,
                    orientation: LayoutOrientation.vertical,
                    primaryAxisAlignItems: LayoutAlign.min,
                    counterAxisAlignItems: LayoutAlign.center,
                    child: DecoratedBox(decoration: BoxDecoration()))
              },
              {
                (85.6500015258789 * 10): OrientedLayout(
                    orientation: LayoutOrientation.vertical,
                    primaryAxisAlignItems: LayoutAlign.min,
                    counterAxisAlignItems: LayoutAlign.center,
                    diameter: 323.75,
                    padding: [0, 0, 0, 0],
                    itemSpacing: 49,
                    children: [
                      {
                        85.6500015258789: OrientedLayout(
                            orientation: LayoutOrientation.horizontal,
                            primaryAxisAlignItems: LayoutAlign.min,
                            counterAxisAlignItems: LayoutAlign.min,
                            diameter: 85.6500015258789,
                            padding: [0, 0, 0, 0],
                            itemSpacing: 12,
                            children: [
                              {
                                155.875: SearchCategoryLabel(
                                    assetName: 'assets/appetizer-category.png',
                                    name: 'Appetizer')
                              },
                              {
                                155.875: SearchCategoryLabel(
                                    assetName: 'assets/bakery-category.jpg',
                                    name: 'Bakery Products')
                              }
                            ])
                      },
                      {
                        85.6500015258789: OrientedLayout(
                            orientation: LayoutOrientation.horizontal,
                            primaryAxisAlignItems: LayoutAlign.min,
                            counterAxisAlignItems: LayoutAlign.min,
                            diameter: 85.6500015258789,
                            padding: [0, 0, 0, 0],
                            itemSpacing: 12,
                            children: [
                              {
                                155.875: SearchCategoryLabel(
                                    assetName: 'assets/breakfast-category.png',
                                    name: 'Breakfast')
                              },
                              {
                                155.875: SearchCategoryLabel(
                                    assetName: 'assets/lunch-category.jpg',
                                    name: 'Lunch')
                              }
                            ])
                      },
                      {
                        85.6500015258789: OrientedLayout(
                            orientation: LayoutOrientation.horizontal,
                            primaryAxisAlignItems: LayoutAlign.min,
                            counterAxisAlignItems: LayoutAlign.min,
                            diameter: 85.6500015258789,
                            padding: [0, 0, 0, 0],
                            itemSpacing: 12,
                            children: [
                              {
                                155.875: SearchCategoryLabel(
                                    assetName: 'assets/dessert-category.jpg',
                                    name: 'Dessert')
                              },
                              {
                                155.875: SearchCategoryLabel(
                                    assetName: 'assets/drinks-category.jpg',
                                    name: 'Drinks & Beverages')
                              }
                            ])
                      },
                      {
                        85.6500015258789: OrientedLayout(
                            orientation: LayoutOrientation.horizontal,
                            primaryAxisAlignItems: LayoutAlign.min,
                            counterAxisAlignItems: LayoutAlign.min,
                            diameter: 85.6500015258789,
                            padding: [0, 0, 0, 0],
                            itemSpacing: 12,
                            children: [
                              {
                                155.875: SearchCategoryLabel(
                                    assetName: 'assets/main-dish-category.jpg',
                                    name: 'Main Dish')
                              },
                              {
                                155.875: SearchCategoryLabel(
                                    assetName: 'assets/salad-category.jpg',
                                    name: 'Salad & Dressings')
                              }
                            ])
                      },
                      {
                        85.6500015258789: OrientedLayout(
                            orientation: LayoutOrientation.horizontal,
                            primaryAxisAlignItems: LayoutAlign.min,
                            counterAxisAlignItems: LayoutAlign.min,
                            diameter: 85.6500015258789,
                            padding: [0, 0, 0, 0],
                            itemSpacing: 12,
                            children: [
                              {
                                155.875: SearchCategoryLabel(
                                    assetName: 'assets/sauces-category.jpg',
                                    name: 'Sauces & Dressings')
                              },
                              {
                                155.875: SearchCategoryLabel(
                                    assetName: 'assets/side-dish-category.jpg',
                                    name: 'Side Dish')
                              }
                            ])
                      },
                      {
                        85.6500015258789: OrientedLayout(
                            orientation: LayoutOrientation.horizontal,
                            primaryAxisAlignItems: LayoutAlign.min,
                            counterAxisAlignItems: LayoutAlign.min,
                            diameter: 85.6500015258789,
                            padding: [0, 0, 0, 0],
                            itemSpacing: 12,
                            children: [
                              {
                                155.875: SearchCategoryLabel(
                                    assetName: 'assets/snack-category.jpg',
                                    name: 'Snacks')
                              },
                              {
                                155.875: SearchCategoryLabel(
                                    assetName: 'assets/soup-category.jpg',
                                    name: 'Soup')
                              }
                            ])
                      },
                    ])
              }
            ]),
      ),
    );
  }
}

class SearchCategoryLabel extends StatelessWidget {
  const SearchCategoryLabel({
    super.key,
    required this.assetName,
    required this.name,
  });

  final String assetName;
  final String name;

  @override
  Widget build(BuildContext context) {
    final lines = wrap(name, width: 12).length;
    // print('lines');
    // print(lines);
    return GestureDetector(
      onTap: () {
        navigatorGrandKey.currentState!.pushNamed('suited_untrendy_content',
            arguments: {"name": name, "SUIT_NAME": name.toLowerCase()});
      },
      child: DecoratedBox(
        decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(4.0),
            image: DecorationImage(image: AssetImage(assetName))),
        child: MinDiameterSupport(
            diameter: 85.64835357666016,
            length: 155.875,
            maximumDiameter: 85.6500015258789,
            orientation: LayoutOrientation.horizontal,
            primaryAxisAlignItems: LayoutAlign.min,
            counterAxisAlignItems: LayoutAlign.min,
            child: OrientedLayout(
                orientation: LayoutOrientation.horizontal,
                primaryAxisAlignItems: LayoutAlign.max,
                counterAxisAlignItems: LayoutAlign.max,
                diameter: 85.64835357666016,
                padding: [18, 15, 18, 15],
                itemSpacing: 10,
                children: [
                  {
                    110: MinDiameterSupport(
                      diameter: 22,
                      length: 110,
                      maximumDiameter: 85.64835357666016,
                      orientation: LayoutOrientation.horizontal,
                      primaryAxisAlignItems: LayoutAlign.max,
                      counterAxisAlignItems: LayoutAlign.max,
                      child: LayoutBuilder(
                        builder: (c, bc) => Transform.translate(
                          offset: Offset(0, (bc.maxHeight * -1) * (lines - 1)),
                          child: LayoutText(wrap(name, width: 12).join("\n"),
                              idtext: 'Appetizer',
                              removeLines: false,
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                  height: 1.3784461152882206,
                                  color: Colors.white,
                                  fontFamily: "DM Serif Display")),
                        ),
                      ),
                    )
                  }
                ])),
      ),
    );
  }
}
