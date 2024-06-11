import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:platter/change_notifiers/AppStatusNotifier.dart';
import 'package:platter/fonts.dart';
import 'package:platter/layout.dart';
import 'package:platter/layout_text.dart';
import 'package:platter/mobile_constants.dart';
import 'package:platter/models/RecipeList.dart';
import 'package:provider/provider.dart';

class SearchResults extends StatefulWidget {
  const SearchResults({super.key});

  @override
  State<SearchResults> createState() => _SearchResultsState();
}

class _SearchResultsState extends State<SearchResults> {
  late final AppStatusNotifier notifier =
      Provider.of<AppStatusNotifier>(context, listen: false);

  RecipeList? recipeList;

  late String pageUrl = notifier.routeArgs["CONTENT"];
  final scrollController = ScrollController();

  bool isLoadingNextPage = false;
  num loadingExtent = 0;
  int page = 0;
  String? image;
  bool disabling = false;

  @override
  void dispose() {
    notifier.removeListener(listener);
    super.dispose();
  }

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await rebuild();
      if (mounted) {
        listener();

        notifier.setSearchResultsImageVisible(false);

        notifier.removeListener(listener);
        notifier.addListener(listener);

        scrollController.addListener(scrollListener);
      }
    });

    // TODO: implement initState
    super.initState();
  }

  void scrollListener() {
    // print(scrollController.)
    final percent = scrollController.position.pixels /
        scrollController.position.extentTotal;

    // if (notifier.searchResultsImageVisible == true && disabling == false) {
    //   disabling = true;
    //   Future.delayed(Duration(milliseconds: 100), () async {
    //     await rebuild();
    //     notifier.setSearchResultsImageVisible(false);
    //     disabling = false;
    //   });
    // }
    if (isLoadingNextPage == false) {
      // print(percent);

      if (percent > (1 - (0.20 / page))) {
        loadingExtent = recipeList?.recipes?.recipe?.length ?? 0;
        isLoadingNextPage = true;
        page += 1;
        pageUrl = notifier.fatsecretConsumer('recipes.search.v3', {
          "search_expression": notifier.routeArgs["query"],
          "page_number": page.toString()
        });
        notifier.addListener(listener);
        listener();
      }
    } else {
      if (loadingExtent < (recipeList?.recipes?.recipe?.length ?? 0)) {
        isLoadingNextPage = false;
      }
    }
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

  void listener() async {
    if (notifier.data(pageUrl) != null) {
      final dataRecipeList = RecipeList.fromJson(notifier.data(pageUrl));

      setState(() {
        if (recipeList != null &&
            dataRecipeList.recipes?.pageNumber == page.toString()) {
          if (page == 0) {
            recipeList = dataRecipeList;
          } else {
            recipeList?.recipes?.recipe
                ?.addAll(dataRecipeList.recipes?.recipe ?? []);
          }

          notifier.removeListener(listener);
        } else {
          if (page == 0) {
            recipeList = dataRecipeList;
          }
          recipeList ??= dataRecipeList;
        }
      });
    }
  }

// final Animation<double> animation = Tween<double>(begin: 0, end: 0).animate(parent);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as dynamic;

    String query = args["query"] ?? "empty";

    var contentList = recipeList?.recipes?.recipe ?? [];
    var other = contentList.length > 0 ? contentList.length : 1;
    // print(other);
    return Stack(fit: StackFit.passthrough, children: [
      Scrollbar(
        child: SingleChildScrollView(
          controller: scrollController,
          child: AspectRatio(
            aspectRatio: 363.75 / (300 + (216 * other)),
            child: OrientedLayout(
                orientation: LayoutOrientation.vertical,
                primaryAxisAlignItems: LayoutAlign.min,
                counterAxisAlignItems: LayoutAlign.min,
                diameter: 363.75,
                padding: [25.5, 0, 37, 0],
                itemSpacing: 0,
                children: [
                  const SafeArea(child: SizedBox.shrink()),
                  {18: antiwhite},
                  {
                    88: DecoratedBox(
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: const Color(0xFF9E9E9E), width: 1)),
                        child: OrientedLayout(
                            orientation: LayoutOrientation.vertical,
                            primaryAxisAlignItems: LayoutAlign.max,
                            counterAxisAlignItems: LayoutAlign.min,
                            diameter: 289.75,
                            padding: [0, 0, 0, 0],
                            itemSpacing: 10,
                            children: [
                              {
                                66: OrientedLayout(
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
                                            orientation:
                                                LayoutOrientation.horizontal,
                                            primaryAxisAlignItems:
                                                LayoutAlign.min,
                                            counterAxisAlignItems:
                                                LayoutAlign.max,
                                            child: LayoutTextInput('Your query',
                                                onSubmit: (v) {
                                              navigatorGrandKey.currentState!
                                                  .pushNamed("searcher_results",
                                                      arguments: {
                                                    "query": v,
                                                    "CONTENT": notifier
                                                        .fatsecretConsumer(
                                                            'recipes.search.v3',
                                                            {
                                                          "search_expression":
                                                              v,
                                                          "page_number": "0"
                                                        })
                                                  });
                                            },
                                                textEditingController:
                                                    TextEditingController
                                                        .fromValue(
                                                            TextEditingValue(
                                                                text: query)),
                                                maxLines: 1,
                                                style: fonts[
                                                        "common DM Serif Text"]!
                                                    .copyWith(
                                                        height:
                                                            1.3666666666666667)))
                                      }
                                    ]),
                              }
                            ]))
                  },
                  {
                    8: MinDiameterSupport(
                        diameter: 108,
                        length: 8,
                        maximumDiameter: 363.75,
                        orientation: LayoutOrientation.vertical,
                        primaryAxisAlignItems: LayoutAlign.min,
                        counterAxisAlignItems: LayoutAlign.min,
                        child: DecoratedBox(decoration: BoxDecoration()))
                  },
                  {
                    24: LayoutText(
                        '${recipeList?.recipes?.totalResults ?? 'fetching'} results',
                        textAlign: TextAlign.end,
                        style: TextStyle(
                            fontFamily: "DM Sans",
                            fontWeight: FontWeight.bold,
                            height: 1.5))
                  },
                  {
                    16.989999771118164: MinDiameterSupport(
                        diameter: 108,
                        length: 16.989999771118164,
                        maximumDiameter: 363.75,
                        orientation: LayoutOrientation.vertical,
                        primaryAxisAlignItems: LayoutAlign.min,
                        counterAxisAlignItems: LayoutAlign.min,
                        child: DecoratedBox(decoration: BoxDecoration()))
                  },
                  {
                    2: DecoratedBox(
                        decoration: BoxDecoration(color: Color(0xFFB3B8E2)))
                  },
                  {
                    202 * other: ListView(
                      shrinkWrap: true,
                      primary: false,
                      padding: EdgeInsets.all(0),
                      children: [
                        AspectRatio(
                            aspectRatio: 301.25 / (202 * other),
                            child: ProportionsColumn(
                                defaultDiameter: 301.25,
                                children: contentList
                                    .map<dynamic>((a) => (contentList
                                                    .indexOf(a) %
                                                2 ==
                                            1)
                                        ? {
                                            200.99000549316406: GestureDetector(
                                                onTap: () {
                                                  String URL = Provider.of<
                                                              AppStatusNotifier>(
                                                          navigatorGrandKey
                                                              .currentContext!,
                                                          listen: false)
                                                      .fatsecretConsumer(
                                                          "recipe.get.v2", {
                                                    "recipe_id": a.recipeId
                                                  });

                                                  precacheImage(
                                                      NetworkImage(
                                                          AppStatusNotifier
                                                              .imgURL(
                                                                  a.recipeImage ??
                                                                      '')),
                                                      context);
                                                  navigatorGrandKey
                                                      .currentState!
                                                      .pushNamed(
                                                          "content_review",
                                                          arguments: {
                                                        "URL": URL,
                                                        "imageURL":
                                                            a.recipeImage ?? '',
                                                        "recipeTitle":
                                                            a.recipeName ?? ''
                                                      });
                                                },
                                                child: OddSearchResult(
                                                    name:
                                                        "${a.recipeName ?? '??'}",
                                                    image: a.recipeImage ?? '',
                                                    description:
                                                        a.recipeDescription ??
                                                            '??',
                                                    userImage:
                                                        'https://yt3.googleusercontent.com/bFpwiiOB_NLCVsIcVQ9UcwBjb1RzipnMmtNfLSWpeIaHboyGkBCq4KBitmovRbStk9WvIWIZOyo=s900-c-k-c0x00ffffff-no-rj',
                                                    user: '@platterblog'))
                                          }
                                        : {
                                            202: GestureDetector(
                                                onTap: () {
                                                  String URL = Provider.of<
                                                              AppStatusNotifier>(
                                                          navigatorGrandKey
                                                              .currentContext!,
                                                          listen: false)
                                                      .fatsecretConsumer(
                                                          "recipe.get.v2", {
                                                    "recipe_id": a.recipeId
                                                  });

                                                  precacheImage(
                                                      NetworkImage(
                                                          AppStatusNotifier
                                                              .imgURL(
                                                                  a.recipeImage ??
                                                                      '')),
                                                      context);
                                                  navigatorGrandKey
                                                      .currentState!
                                                      .pushNamed(
                                                          "content_review",
                                                          arguments: {
                                                        "URL": URL,
                                                        "imageURL":
                                                            a.recipeImage ?? '',
                                                        "recipeTitle":
                                                            a.recipeName ?? ''
                                                      });
                                                },
                                                child: EvenSearchResult(
                                                    name:
                                                        "${a.recipeName ?? '??'}",
                                                    image: a.recipeImage ?? '',
                                                    description:
                                                        a.recipeDescription ??
                                                            '??',
                                                    userImage:
                                                        'https://yt3.googleusercontent.com/bFpwiiOB_NLCVsIcVQ9UcwBjb1RzipnMmtNfLSWpeIaHboyGkBCq4KBitmovRbStk9WvIWIZOyo=s900-c-k-c0x00ffffff-no-rj',
                                                    user: '@platterblog'))
                                          })
                                    .toList())),
                      ],
                    )
                  }
                ]),
          ),
        ),
      ),
      Align(
        alignment: Alignment.bottomLeft,
        child: Container(
          child: AspectRatio(
            aspectRatio: 363.75 / 137,
            child: OrientedLayout(
              orientation: LayoutOrientation.horizontal,
              diameter: 137,
              padding: [24, 0, 0, 25],
              children: [
                {
                  148: Consumer<AppStatusNotifier>(
                    builder: (context, notifier, widget) => GestureDetector(
                      onPanDown: (e) {
                        navigatorGrandKey.currentState!
                            .pushNamed('gallery', arguments: {
                          "CONTENT": [notifier.searchResultsImage]
                        });
                      },
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 256),
                        reverseDuration: const Duration(milliseconds: 256 - 44),
                        transitionBuilder: (child, animation) {
                          //                       final _offsetAnimation = Tween<Offset>(
                          //   begin: const Offset(0.225, -0.225),
                          //   end: Offset.zero,
                          // );
                          // final _turnsAnimation = Tween<double>(
                          //   end: 0,
                          //   begin: 0.1,
                          // );
                          // final _fadeAnimation = Tween<double>(
                          //   end: 1,
                          //   begin: 0.7,
                          // );
                          final offsetAnimation = Tween<Offset>(
                            begin: const Offset(0.225 / 3, -0.225 / 3),
                            end: Offset.zero,
                          ).animate(CurvedAnimation(
                            parent: animation,
                            curve: Curves.easeOut,
                          ));
                  
                          final turnsAnimation = Tween<double>(
                            end: 0.0,
                            begin: 0.1 / 2,
                          ).animate(CurvedAnimation(
                            parent: animation,
                            curve: Curves.linear,
                          ));
                  
                          final fadeAnimation = Tween<double>(
                            end: 1.0,
                            begin: 0,
                          ).animate(CurvedAnimation(
                              parent: animation,
                              curve: Curves.linear,
                              reverseCurve: Curves.decelerate));
                  
                          return SlideTransition(
                            position: offsetAnimation,
                            child: RotationTransition(
                              turns: turnsAnimation,
                              child: FadeTransition(
                                opacity: fadeAnimation,
                                child: child,
                              ),
                            ),
                          );
                        },
                        switchInCurve: Curves.bounceIn,
                        switchOutCurve: Curves.easeIn,
                        child: Container(
                          padding: EdgeInsets.all(4),
                          key: ValueKey(
                              "visible${notifier.searchResultsImage}${notifier.searchResultsImageVisible.toString()}"),
                          decoration: notifier.searchResultsImageVisible
                              ? BoxDecoration(
                                  color: Color.fromARGB(235, 14, 11, 11),
                                  // boxShadow: defaultIconShadow,
                                  border: Border.all(
                                      width: 4,
                                      color: Color.fromARGB(235, 14, 11, 11)),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4)),
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                          notifier.searchResultsImage)))
                              : BoxDecoration(),
                          child: notifier.searchResultsImageVisible
                              ? ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(0)),
                                child: Image.asset(
                                  'assets/backgrounds/endless_care1.png',
                                  fit: BoxFit.fill,
                                  color: const Color.fromRGBO(
                                      255, 255, 255, (0.10)),
                                  colorBlendMode: BlendMode.modulate,
                                ),
                              )
                              : SizedBox.shrink(),
                        ),
                      ),
                    ),
                  )
                }
              ],
            ),
          ),
        ),
      )
    ]);
  }
}

class EvenSearchResult extends StatelessWidget {
  const EvenSearchResult({
    super.key,
    required this.name,
    required this.description,
    required this.userImage,
    required this.user,
    required this.image,
  });

  final String name;
  final String image;
  final String description;
  final String userImage;
  final String user;

  @override
  Widget build(BuildContext context) {
    AppStatusNotifier notifier =
        Provider.of<AppStatusNotifier>(context, listen: false);
    return DecoratedBox(
        decoration: BoxDecoration(
            border:
                Border(bottom: BorderSide(width: 2, color: Color(0xFFE0CFCF)))),
        child: OrientedLayout(
            orientation: LayoutOrientation.vertical,
            primaryAxisAlignItems: LayoutAlign.min,
            counterAxisAlignItems: LayoutAlign.min,
            diameter: 289.75,
            padding: [3, 39.9900016784668, 0, 20],
            itemSpacing: 0,
            children: [
              {
                27: LayoutText(name,
                    idtext: 'e',
                    maxLines: 1,
                    style:
                        TextStyle(fontFamily: "DM Serif Display", height: 1.35))
              },
              {13: DecoratedBox(decoration: BoxDecoration())},
              {
                48: LayoutText(description,
                    idtext: 'e\ne\ne',
                    maxLines: 2,
                    style: TextStyle(
                        fontFamily: "DM Sans",
                        fontWeight: FontWeight.w400,
                        height: 1.3333333333333333))
              },
              {
                54.0099983215332: OrientedLayout(
                    orientation: LayoutOrientation.horizontal,
                    primaryAxisAlignItems: LayoutAlign.space_between,
                    counterAxisAlignItems: LayoutAlign.min,
                    diameter: 54.0099983215332,
                    padding: [8, 0, 0, 0],
                    itemSpacing: 0,
                    children: [
                      {
                        158: MinDiameterSupport(
                            diameter: 36,
                            length: 158,
                            maximumDiameter: 54.0099983215332,
                            orientation: LayoutOrientation.horizontal,
                            primaryAxisAlignItems: LayoutAlign.space_between,
                            counterAxisAlignItems: LayoutAlign.min,
                            child: OrientedLayout(
                                orientation: LayoutOrientation.horizontal,
                                primaryAxisAlignItems: LayoutAlign.min,
                                counterAxisAlignItems: LayoutAlign.center,
                                diameter: 36,
                                padding: [0, 0, 0, 0],
                                itemSpacing: 14,
                                children: [
                                  {
                                    36: SvgPicture.asset('assets/Group 101.svg')
                                  },
                                  {
                                    108: MinDiameterSupport(
                                        diameter: 16,
                                        length: 108,
                                        maximumDiameter: 36,
                                        orientation:
                                            LayoutOrientation.horizontal,
                                        primaryAxisAlignItems: LayoutAlign.min,
                                        counterAxisAlignItems:
                                            LayoutAlign.center,
                                        child: LayoutText(user,
                                            style: TextStyle(
                                                fontFamily: "DM Sans",
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xFF5EC9F8))))
                                  }
                                ]))
                      },
                      {
                        52: (image.isEmpty == false)
                            ? GestureDetector(
                                onPanDown: (e) {
                                  notifier.setSearchResultsImageVisible(true);
                                  notifier.setSearchResultsImage(image);
                                },
                                onTap: () {
                                  // print("tapped");
                                  notifier.setSearchResultsImageVisible(true);
                                  notifier.setSearchResultsImage(image);
                                },
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                      boxShadow: defaultIconShadow),
                                  child: MinDiameterSupport(
                                    diameter: 52,
                                    length: 52,
                                    maximumDiameter: 54.0099983215332,
                                    orientation: LayoutOrientation.horizontal,
                                    primaryAxisAlignItems:
                                        LayoutAlign.space_between,
                                    counterAxisAlignItems: LayoutAlign.min,
                                    child: SvgPicture.asset(
                                        'assets/eye-button.svg'),
                                  ),
                                ),
                              )
                            : SizedBox.shrink()
                      }
                    ])
              }
            ]));
  }
}

class OddSearchResult extends StatelessWidget {
  const OddSearchResult({
    super.key,
    required this.name,
    required this.description,
    required this.userImage,
    required this.user,
    required this.image,
  });

  final String image;
  final String name;
  final String description;
  final String userImage;
  final String user;

  @override
  Widget build(BuildContext context) {
    AppStatusNotifier notifier =
        Provider.of<AppStatusNotifier>(context, listen: false);
    return DecoratedBox(
        decoration: BoxDecoration(
            border:
                Border(bottom: BorderSide(width: 2, color: Color(0xFFE0CFCF)))),
        child: OrientedLayout(
            orientation: LayoutOrientation.vertical,
            primaryAxisAlignItems: LayoutAlign.min,
            counterAxisAlignItems: LayoutAlign.min,
            diameter: 289.75,
            padding: [3, 39.9900016784668, 0, 20],
            itemSpacing: 0,
            children: [
              {
                27: LayoutText(name,
                    maxLines: 1,
                    idtext: 'e',
                    style:
                        TextStyle(fontFamily: "DM Serif Display", height: 1.35))
              },
              {13: DecoratedBox(decoration: BoxDecoration())},
              {
                48: LayoutText(description,
                    idtext: 'e\ne\ne',
                    maxLines: 2,
                    style: TextStyle(
                        fontFamily: "DM Sans",
                        fontWeight: FontWeight.w400,
                        height: 1.3333333333333333))
              },
              {
                53.000003814697266: OrientedLayout(
                    orientation: LayoutOrientation.horizontal,
                    primaryAxisAlignItems: LayoutAlign.space_between,
                    counterAxisAlignItems: LayoutAlign.min,
                    diameter: 53.000003814697266,
                    padding: [8, 0, 0, 0],
                    itemSpacing: 0,
                    children: [
                      {
                        158: MinDiameterSupport(
                            diameter: 36,
                            length: 158,
                            maximumDiameter: 53.000003814697266,
                            orientation: LayoutOrientation.horizontal,
                            primaryAxisAlignItems: LayoutAlign.space_between,
                            counterAxisAlignItems: LayoutAlign.min,
                            child: OrientedLayout(
                                orientation: LayoutOrientation.horizontal,
                                primaryAxisAlignItems: LayoutAlign.min,
                                counterAxisAlignItems: LayoutAlign.center,
                                diameter: 36,
                                padding: [0, 0, 0, 0],
                                itemSpacing: 14,
                                children: [
                                  {
                                    36: SvgPicture.asset('assets/Group 101.svg')
                                  },
                                  {
                                    108: MinDiameterSupport(
                                        diameter: 16,
                                        length: 108,
                                        maximumDiameter: 36,
                                        orientation:
                                            LayoutOrientation.horizontal,
                                        primaryAxisAlignItems: LayoutAlign.min,
                                        counterAxisAlignItems:
                                            LayoutAlign.center,
                                        child: LayoutText(user,
                                            style: TextStyle(
                                                fontFamily: "DM Sans",
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xFF5EC9F8))))
                                  }
                                ]))
                      },
                      {
                        52: (image.isEmpty == false)
                            ? GestureDetector(
                                onPanDown: (e) {
                                  notifier.setSearchResultsImageVisible(true);
                                  notifier.setSearchResultsImage(image);
                                },
                                onTap: () {
                                  // print("tapped");
                                  notifier.setSearchResultsImageVisible(true);
                                  notifier.setSearchResultsImage(image);
                                },
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                      boxShadow: defaultIconShadow),
                                  child: MinDiameterSupport(
                                    diameter: 52,
                                    length: 52,
                                    maximumDiameter: 54.0099983215332,
                                    orientation: LayoutOrientation.horizontal,
                                    primaryAxisAlignItems:
                                        LayoutAlign.space_between,
                                    counterAxisAlignItems: LayoutAlign.min,
                                    child: SvgPicture.asset(
                                        'assets/eye-button.svg'),
                                  ),
                                ),
                              )
                            : SizedBox.shrink()
                      }
                    ])
              }
            ]));
  }
}
