import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:platter/change_notifiers/AppStatusNotifier.dart';
import 'package:platter/content_suite.dart';
import 'package:platter/layout.dart';
import 'package:platter/layout_text.dart';
import 'package:platter/mobile_constants.dart';
import 'package:platter/models/RecipeList.dart';
import 'package:platter/pages/home.dart';
import 'package:provider/provider.dart';

class TrendyContent extends StatefulWidget {
  final bool trendy;

  const TrendyContent({super.key, this.trendy = true});

  @override
  State<TrendyContent> createState() => _TrendyContentState();
}

class _TrendyContentState extends State<TrendyContent> {
  Map<String, RecipeList?>? suitedContent = {};
  Map<String, int?>? suitedPages = {};
  late AppStatusNotifier notifier =
      Provider.of<AppStatusNotifier>(context, listen: false);
  String? name;
  late final RSUITE =
      widget.trendy ? 'suited_trendy_content_' : 'suited_untrendy_content_';
  late final Map CONTENT = CONTENT_SUITE(
      context, "$RSUITE${notifier.routeArgs["SUIT_NAME"] ?? 'snacks'}");

  @override
  void initState() {
    // TODO: implement initState

    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await rebuild();
      if (mounted) {
        listener();

        notifier.removeListener(listener);
        notifier.addListener(listener);
      }
    });
    super.initState();
  }

  Future<bool> rebuild() async {
    if (!mounted) return false;

    // if there's a current frame,
    if (SchedulerBinding.instance.schedulerPhase != SchedulerPhase.idle) {
      // wait for the end of that frame.
      await SchedulerBinding.instance.endOfFrame;
      if (!mounted) return false;
    }

    setState(() {});
    return true;
  }

  @override
  void dispose() {
    notifier.removeListener(listener);
    super.dispose();
  }

  void listener() {
    name = notifier.routeArgs?["name"] ?? '';
    suitedContent ??= {};
    suitedPages ??= {};

    if (mounted) {
      for (final map in CONTENT.entries) {
        Uri uri = Uri.parse(map.value["URL"]);

        uri = uri.replace(queryParameters: {
          ...uri.queryParameters,
          "page_number": (suitedPages?[map.key] ?? 0).toString()
        });

        var uriString = uri.toString();
        
        if (notifier.data(uriString).isEmpty == false) {
          final dataRecipeList =
              RecipeList.fromJson(notifier.data(uriString));

          setState(() {
            if (suitedContent![map.key] == null) {
              suitedContent![map.key] = dataRecipeList;
              suitedPages![map.key] = 1;
            } else {
              if (dataRecipeList.recipes?.pageNumber == '0') {
                suitedContent![map.key] = dataRecipeList;
              }
              if (dataRecipeList.recipes?.pageNumber ==
                  (suitedPages?[map.key] ?? 1).toString()) {
                suitedContent![map.key]
                    ?.recipes
                    ?.recipe
                    ?.addAll(dataRecipeList.recipes?.recipe ?? []);

                suitedPages?[map.key] = (suitedPages?[map.key] ?? 1) + 1;
              }
            }
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: AspectRatio(
          aspectRatio: 485 / 4000,
          child: OrientedLayout(
            orientation: LayoutOrientation.vertical,
            primaryAxisAlignItems: LayoutAlign.min,
            counterAxisAlignItems: LayoutAlign.min,
            diameter: 485 * 0.75,
            padding: const [32, 0, 41, 0],
            itemSpacing: 0,
            children: [
              SafeArea(child: SizedBox.shrink()),
              const {16: antiwhite},
              {
                widget.trendy ? 30 : 22: widget.trendy
                    ? SingleChildScrollView(
                        clipBehavior: Clip.none,
                        scrollDirection: Axis.horizontal,
                        child: ProportionsRow(
                          defaultDiameter: 30,
                          spacing: 6,
                          children: const [
                            {
                              50: TeasingLabel(
                                length: 50,
                                name: 'Trendy',
                                active: false,
                              )
                            },
                            {75: TeasingLabel(length: 75, name: 'healthy')},
                            {75: TeasingLabel(length: 75, name: 'salads')},
                            {90: TeasingLabel(length: 90, name: 'appetizer')},
                            {90: TeasingLabel(length: 90, name: 'smoothie')},
                          ],
                        ),
                      )
                    : DecoratedBox(
                        decoration:
                            BoxDecoration(boxShadow: defaultIconShadowB),
                        child: LayoutText(name ?? '',
                            idtext: 'e',
                            textAlign: TextAlign.left,
                            maxLines: 2,
                            children: [],
                            style: TextStyle(
                                fontFamily: "DM Serif Text",
                                height: 1.375,
                                fontWeight: FontWeight.w400)),
                      )
              },
              const {17: antiwhite},
              for (final a in CONTENT.entries)
                {
                  380: homeContentCarpet(
                      title: a.value["name"] ?? '?',
                      url: a.value["_URL"],
                      description: a.value["description"] ?? '?',
                      list: suitedContent?[a.key ?? ''] ??
                          RecipeList.fromJson({}))
                },
              const {10: antiwhite},
              const {58: DecoratedBox(decoration: BoxDecoration())},
              const {
                31: LayoutText('Affiliated store',
                    style: TextStyle(
                        fontFamily: "DM Sans",
                        height: 1.2916666666666667,
                        fontWeight: FontWeight.w700))
              },
              const {
                421: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: AspectRatio(
                    aspectRatio: 1000 / 421,
                    child: OrientedLayout(
                        orientation: LayoutOrientation.horizontal,
                        primaryAxisAlignItems: LayoutAlign.min,
                        counterAxisAlignItems: LayoutAlign.min,
                        diameter: 421,
                        padding: const [25.5, 115, 26, 124],
                        itemSpacing: 131,
                        children: const [
                          {
                            112: AffiliatedStoreItem(
                                url:
                                    'https://m.media-amazon.com/images/I/91ggSCk+bHL._SL1500_.jpg',
                                name:
                                    'Tasty Every Day: All of the Flavor, None ')
                          },
                          {
                            112: AffiliatedStoreItem(
                                url:
                                    'https://m.media-amazon.com/images/I/91ggSCk+bHL._SL1500_.jpg',
                                name:
                                    'Tasty Every Day: All of the Flavor, None ')
                          },
                        ]),
                  ),
                )
              },
            ],
          )),
    );
  }
}
