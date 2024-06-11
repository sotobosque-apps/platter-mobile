import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:like_button/like_button.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:platter/change_notifiers/AppStatusNotifier.dart';
import 'package:platter/layout.dart';
import 'package:platter/layout_text.dart';
import 'package:platter/mobile_constants.dart';
import 'package:platter/models/RecipeLikesByUser.dart';
import 'package:platter/models/RecipeReview.dart';
import 'package:platter/pages/home.dart';
import 'package:provider/provider.dart';
import 'package:textwrap/textwrap.dart';

class ContentReview extends StatefulWidget {
  const ContentReview({super.key});

  @override
  State<ContentReview> createState() => _ContentReviewState();
}

class _ContentReviewState extends State<ContentReview> {
  RecipeReview? CONTENT = null;
  List<RecipeLikesByUser>? LIKES_CONTENT = null;
  bool initialized = false;
  bool recipeisLiked = false;

  final notifier = Provider.of<AppStatusNotifier>(
      navigatorGrandKey.currentContext!,
      listen: false);
  late final args = ModalRoute.of(context)!.settings.arguments as dynamic;
  String URL = "";
  String URL_1 = "";
  late String? imageURL = args["imageURL"];
  final likeButtonkey = GlobalKey<LikeButtonState>();
  @override
  void initState() {
    // TODO: implement initState
    if (mounted) {
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        print("POST LISTENER");
        listener();
        URL = args?["URL"] ?? '//';
        URL_1 = args?["URL_1"] ?? '//';
        notifier.addListener(listener);

        listenerB({bool remove = true}) {
          print("LISTENERB");
          if (notifier.listdata(URL_1).isNotEmpty && initialized == false) {
            setState(() {
              print("CONTENT?.recipe?.recipeId");
              print(CONTENT?.recipe?.recipeId);
              LIKES_CONTENT = recipeLikesByUserFromJson(
                  jsonEncode(notifier.listdata(URL_1)));
              recipeisLiked = LIKES_CONTENT?.any((element) =>
                      element.recipeId == CONTENT?.recipe?.recipeId) ??
                  false;

              print("recipeisLiked");
              print(recipeisLiked);

              Future.delayed(Duration(milliseconds: 200), () {
                initialized = true;
                if (recipeisLiked == true) {
                  setState(() {
                    likeButtonkey.currentState?.controller?.forward();
                  });
                }
              });
              if (remove) {
                notifier.removeListener(listenerB);
              }
            });
          }
        }

        listenerB(remove: false);
        notifier.addListener(listenerB);
      });
    }
    super.initState();
  }

  void listener() {
    URL = args?["URL"] ?? '//';

    if (notifier.data(URL).isEmpty == false &&
        RecipeReview.fromJson(notifier.data(URL)) != (CONTENT)) {
      setState(() {
        CONTENT = RecipeReview.fromJson(notifier.data(URL));
      });
    }
  }

  num directionsToHeight() {
    num height = 0;
    final list = CONTENT?.recipe?.directions?.direction ?? [];
    for (Direction a in list) {
      height += 66 +
          69 +
          InstructionContentReview.returnMissingSpace(
              a.directionDescription ?? '');
    }

    return height > 0 ? height * 1.1797752809 : 400;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    notifier.removeListener(listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as dynamic;
    URL = args?["URL"] ?? '//';

    List<Ingredient> originalList =
        CONTENT?.recipe?.ingredients?.ingredient ?? [];
    int splitIndex = originalList.length ~/ 2;

    List<Ingredient> firstPart = originalList.sublist(0, splitIndex);
    List<Ingredient> secondPart = originalList.sublist(splitIndex);

    var recipeImage2 = imageURL;
    var ingredientSectionHeight =
        ((secondPart.length > 0 ? secondPart.length : 4) * (136 * 0.75)) +
            (originalList.length % 2 == 1 ? 0 : 0);
    return ListView(padding: EdgeInsets.all(0), children: [
      AspectRatio(
          aspectRatio:
              363.75 / (2376 + directionsToHeight() + ingredientSectionHeight),
          child: OrientedLayout(
              orientation: LayoutOrientation.vertical,
              primaryAxisAlignItems: LayoutAlign.min,
              counterAxisAlignItems: LayoutAlign.center,
              diameter: 363.75,
              padding: [15, 0, 15, 0],
              itemSpacing: 0,
              children: [
                // {103: DecoratedBox(decoration: BoxDecoration())},
                SafeArea(child: SizedBox.shrink()),
                {41: antiwhite},
                {
                  62: OrientedLayout(
                      orientation: LayoutOrientation.horizontal,
                      primaryAxisAlignItems: LayoutAlign.max,
                      counterAxisAlignItems: LayoutAlign.center,
                      diameter: 62,
                      padding: [0, 0, 18, 0],
                      itemSpacing: 26,
                      children: [
                        {
                          240: MinDiameterSupport(
                              diameter: 47,
                              length: 240,
                              maximumDiameter: 62,
                              orientation: LayoutOrientation.horizontal,
                              primaryAxisAlignItems: LayoutAlign.max,
                              counterAxisAlignItems: LayoutAlign.center,
                              child: OrientedLayout(
                                  orientation: LayoutOrientation.horizontal,
                                  primaryAxisAlignItems: LayoutAlign.center,
                                  counterAxisAlignItems: LayoutAlign.center,
                                  diameter: 47,
                                  padding: [0, 0, 0, 5],
                                  itemSpacing: 10,
                                  children: [
                                    {
                                      240: LayoutText('Feb 16, 2024',
                                          children: [
                                            TextSpan(
                                                text: '\nTeam alpha',
                                                style: TextStyle(
                                                    color: Colors.black)),
                                            TextSpan(
                                                text: ' @platterblog',
                                                style: TextStyle(
                                                    color: Color(0xFF5EC9F8)))
                                          ],
                                          idtext:
                                              '3 hours ago\nGordon ramsay @gordonRR',
                                          removeLines: false,
                                          textAlign: TextAlign.end,
                                          style: TextStyle(
                                              fontFamily: "DM Sans",
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xFFC3B9B9)))
                                    }
                                  ]))
                        },
                        {62: SvgPicture.asset('assets/Group 101.svg')}
                      ])
                },
                {28: DecoratedBox(decoration: BoxDecoration())},
                {
                  215: Stack(children: [
                    Center(
                        child: AspectRatio(
                            aspectRatio: 1,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                  image: recipeImage2 != null
                                      ? DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(recipeImage2))
                                      : const DecorationImage(
                                          fit: BoxFit.cover,
                                          image: AssetImage(
                                              'assets/backgrounds/placeholder.png'))),
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    image: recipeImage2 != null
                                        ? DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                                AppStatusNotifier.imgURL(
                                                    recipeImage2)))
                                        : DecorationImage(
                                            fit: BoxFit.cover,
                                            image: AssetImage(
                                                'assets/backgrounds/placeholder.png'))),
                                child: ClipRect(
                                  child: Image.asset(
                                    'assets/backgrounds/endless_care1.png',
                                    fit: BoxFit.fill,
                                    color: const Color.fromRGBO(
                                        255, 255, 255, (0.10)),
                                    colorBlendMode: BlendMode.modulate,
                                  ),
                                ),
                              ),
                            ))),
                    OrientedLayout(
                        orientation: LayoutOrientation.vertical,
                        primaryAxisAlignItems: LayoutAlign.max,
                        counterAxisAlignItems: LayoutAlign.min,
                        diameter: 333.75,
                        padding: [0, 0, 0, 0],
                        itemSpacing: 0,
                        children: [
                          {
                            61: OrientedLayout(
                                orientation: LayoutOrientation.horizontal,
                                primaryAxisAlignItems:
                                    LayoutAlign.space_between,
                                counterAxisAlignItems: LayoutAlign.center,
                                diameter: 61,
                                padding: [26, 0, 26, 9],
                                itemSpacing: 0,
                                children: [
                                  {
                                    52: GestureDetector(
                                      onTap: () {
                                        if (CONTENT != null) {
                                          print(CONTENT?.recipe?.recipeImages
                                                  ?.recipeImage ??
                                              []);
                                          navigatorGrandKey.currentState!
                                              .pushNamed('gallery', arguments: {
                                            "CONTENT": CONTENT
                                                    ?.recipe
                                                    ?.recipeImages
                                                    ?.recipeImage ??
                                                []
                                          });
                                        }
                                      },
                                      child: SvgPicture.asset(
                                          'assets/picture.svg'),
                                    )
                                  },
                                  {
                                    (54.2): AspectRatio(
                                      aspectRatio: 1,
                                      child: LayoutBuilder(
                                        builder: (context, bc) {
                                          return DecoratedBox(
                                              decoration: const BoxDecoration(
                                                  color: Color(0xFF000000),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              4.0))),
                                              child: GestureDetector(
                                                behavior:
                                                    HitTestBehavior.translucent,
                                                onTap: () {
                                                  print("tapped");
                                                  notifier.recipeLike(
                                                      CONTENT?.recipe
                                                              ?.recipeId ??
                                                          '',
                                                      notifier.session?.user?.id
                                                              ?.toString() ??
                                                          '', CONTENT?.toJsonB() ?? {});
                                                  setState(() {
                                                    recipeisLiked =
                                                        !recipeisLiked;
                                                    if (recipeisLiked) {
                                                      likeButtonkey.currentState
                                                          ?.controller
                                                          ?.forward();
                                                    } else {
                                                      likeButtonkey.currentState
                                                          ?.controller
                                                          ?.reset();
                                                    }
                                                  });
                                                },
                                                child: IgnorePointer(
                                                  child: LikeButton(
                                                    isLiked: recipeisLiked,
                                                    key: likeButtonkey,
                                                    size: bc.biggest.height,
                                                    circleColor:
                                                        const CircleColor(
                                                            start:
                                                                Color.fromARGB(
                                                                    255,
                                                                    161,
                                                                    173,
                                                                    179),
                                                            end: Color.fromARGB(
                                                                255,
                                                                232,
                                                                242,
                                                                247)),
                                                    bubblesColor:
                                                        const BubblesColor(
                                                      dotPrimaryColor:
                                                          Color(0xff33b5e5),
                                                      dotSecondaryColor:
                                                          Color.fromARGB(255,
                                                              232, 242, 247),
                                                    ),
                                                    likeBuilder:
                                                        (bool isLiked) {
                                                      return Icon(
                                                        Icons.favorite,
                                                        color: isLiked
                                                            ? Color.fromARGB(
                                                                255,
                                                                233,
                                                                95,
                                                                136)
                                                            : const Color
                                                                .fromARGB(255,
                                                                232, 242, 247),
                                                        size:
                                                            bc.biggest.height *
                                                                0.5,
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ));
                                        },
                                      ),
                                    )
                                  }
                                ])
                          }
                        ])
                  ])
                },
                {52: DecoratedBox(decoration: BoxDecoration())},
                {
                  (1592 - 810 + 50) + ingredientSectionHeight: OrientedLayout(
                      orientation: LayoutOrientation.vertical,
                      primaryAxisAlignItems: LayoutAlign.min,
                      counterAxisAlignItems: LayoutAlign.min,
                      diameter: 333.75,
                      padding: [30, 0, 30, 0],
                      itemSpacing: 0,
                      children: [
                        {
                          33: MinDiameterSupport(
                              diameter: 104,
                              length: 33,
                              maximumDiameter: 333.75,
                              orientation: LayoutOrientation.vertical,
                              primaryAxisAlignItems: LayoutAlign.min,
                              counterAxisAlignItems: LayoutAlign.min,
                              child: LayoutText('Summary',
                                  style: TextStyle(
                                      fontFamily: "DM Serif Display",
                                      height: 1.375)))
                        },
                        {35: DecoratedBox(decoration: BoxDecoration())},
                        {
                          52: OrientedLayout(
                              orientation: LayoutOrientation.horizontal,
                              primaryAxisAlignItems: LayoutAlign.min,
                              counterAxisAlignItems: LayoutAlign.min,
                              diameter: 52,
                              padding: [0, 0, 0, 0],
                              itemSpacing: 28,
                              children: [
                                {
                                  122.875: OrientedLayout(
                                      orientation: LayoutOrientation.vertical,
                                      primaryAxisAlignItems: LayoutAlign.min,
                                      counterAxisAlignItems: LayoutAlign.min,
                                      diameter: 122.875,
                                      padding: [0, 0, 0, 0],
                                      itemSpacing: 4,
                                      children: [
                                        {
                                          17: LayoutText('Preparation time',
                                              style: TextStyle(
                                                  fontFamily: "Inter",
                                                  fontWeight: FontWeight.w600,
                                                  height: 1.214285714))
                                        },
                                        {
                                          31: OrientedLayout(
                                              orientation:
                                                  LayoutOrientation.horizontal,
                                              primaryAxisAlignItems:
                                                  LayoutAlign.min,
                                              counterAxisAlignItems:
                                                  LayoutAlign.max,
                                              diameter: 31,
                                              padding: [0, 0, 0, 0],
                                              itemSpacing: 6,
                                              children: [
                                                LayoutText(
                                                    CONTENT?.recipe
                                                            ?.preparationTimeMin ??
                                                        "??",
                                                    style: TextStyle(
                                                        height: 1.291666667,
                                                        fontFamily: "DM Sans")),
                                                {
                                                  85.875: MinDiameterSupport(
                                                      length: 85.875,
                                                      diameter: 19,
                                                      maximumDiameter: 31,
                                                      orientation:
                                                          LayoutOrientation
                                                              .horizontal,
                                                      primaryAxisAlignItems:
                                                          LayoutAlign.min,
                                                      counterAxisAlignItems:
                                                          LayoutAlign.max,
                                                      child: OrientedLayout(
                                                          orientation:
                                                              LayoutOrientation
                                                                  .vertical,
                                                          primaryAxisAlignItems:
                                                              LayoutAlign
                                                                  .center,
                                                          counterAxisAlignItems:
                                                              LayoutAlign
                                                                  .center,
                                                          diameter: 85.875,
                                                          padding: [0, 0, 0, 4],
                                                          itemSpacing: 10,
                                                          children: [
                                                            {
                                                              15: LayoutText(
                                                                  'Min',
                                                                  style: TextStyle(
                                                                      height:
                                                                          1.25,
                                                                      fontFamily:
                                                                          "Inter",
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500))
                                                            }
                                                          ]))
                                                }
                                              ])
                                        }
                                      ])
                                },
                                {
                                  122.875: OrientedLayout(
                                      orientation: LayoutOrientation.vertical,
                                      primaryAxisAlignItems: LayoutAlign.min,
                                      counterAxisAlignItems: LayoutAlign.min,
                                      diameter: 122.875,
                                      padding: [0, 0, 0, 0],
                                      itemSpacing: 4,
                                      children: [
                                        {
                                          17: LayoutText('Cooking Time',
                                              style: TextStyle(
                                                  fontFamily: "Inter",
                                                  fontWeight: FontWeight.w600,
                                                  height: 1.214285714))
                                        },
                                        {
                                          31: OrientedLayout(
                                              orientation:
                                                  LayoutOrientation.horizontal,
                                              primaryAxisAlignItems:
                                                  LayoutAlign.min,
                                              counterAxisAlignItems:
                                                  LayoutAlign.max,
                                              diameter: 31,
                                              padding: [0, 0, 0, 0],
                                              itemSpacing: 6,
                                              children: [
                                                {
                                                  31: LayoutText(
                                                      CONTENT?.recipe
                                                              ?.cookingTimeMin ??
                                                          "??",
                                                      style: TextStyle(
                                                          height: 1.291666667,
                                                          fontFamily:
                                                              "DM Sans"))
                                                },
                                                {
                                                  21: MinDiameterSupport(
                                                      diameter: 21,
                                                      length: 19,
                                                      maximumDiameter: 31,
                                                      orientation:
                                                          LayoutOrientation
                                                              .horizontal,
                                                      primaryAxisAlignItems:
                                                          LayoutAlign.min,
                                                      counterAxisAlignItems:
                                                          LayoutAlign.max,
                                                      child: OrientedLayout(
                                                          orientation:
                                                              LayoutOrientation
                                                                  .vertical,
                                                          primaryAxisAlignItems:
                                                              LayoutAlign
                                                                  .center,
                                                          counterAxisAlignItems:
                                                              LayoutAlign
                                                                  .center,
                                                          diameter: 21,
                                                          padding: [0, 0, 0, 4],
                                                          itemSpacing: 10,
                                                          children: [
                                                            {
                                                              15: LayoutText(
                                                                  'Min',
                                                                  style: TextStyle(
                                                                      height:
                                                                          1.25,
                                                                      fontFamily:
                                                                          "Inter",
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500))
                                                            }
                                                          ]))
                                                }
                                              ])
                                        }
                                      ])
                                }
                              ])
                        },
                        {40: DecoratedBox(decoration: BoxDecoration())},
                        {
                          52: OrientedLayout(
                              orientation: LayoutOrientation.horizontal,
                              primaryAxisAlignItems: LayoutAlign.min,
                              counterAxisAlignItems: LayoutAlign.min,
                              diameter: 52,
                              padding: [0, 0, 0, 0],
                              itemSpacing: 28,
                              children: [
                                {
                                  122.875: OrientedLayout(
                                      orientation: LayoutOrientation.vertical,
                                      primaryAxisAlignItems: LayoutAlign.min,
                                      counterAxisAlignItems: LayoutAlign.min,
                                      diameter: 122.875,
                                      padding: [0, 0, 0, 0],
                                      itemSpacing: 4,
                                      children: [
                                        {
                                          17: MinDiameterSupport(
                                              diameter: 60,
                                              length: 17,
                                              maximumDiameter: 122.875,
                                              orientation:
                                                  LayoutOrientation.vertical,
                                              primaryAxisAlignItems:
                                                  LayoutAlign.min,
                                              counterAxisAlignItems:
                                                  LayoutAlign.min,
                                              child: LayoutText('Servings',
                                                  style: TextStyle(
                                                      fontFamily: "Inter",
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      height: 1.214285714)))
                                        },
                                        {
                                          31: OrientedLayout(
                                              orientation:
                                                  LayoutOrientation.horizontal,
                                              primaryAxisAlignItems:
                                                  LayoutAlign.min,
                                              counterAxisAlignItems:
                                                  LayoutAlign.max,
                                              diameter: 31,
                                              padding: [0, 0, 0, 0],
                                              itemSpacing: 6,
                                              children: [
                                                {
                                                  31: LayoutText(
                                                      CONTENT?.recipe
                                                              ?.numberOfServings ??
                                                          "??",
                                                      style: TextStyle(
                                                          height: 1.291666667,
                                                          fontFamily:
                                                              "DM Sans"))
                                                },
                                                {
                                                  85.875: MinDiameterSupport(
                                                      length: 85.875,
                                                      diameter: 19,
                                                      maximumDiameter: 31,
                                                      orientation:
                                                          LayoutOrientation
                                                              .horizontal,
                                                      primaryAxisAlignItems:
                                                          LayoutAlign.min,
                                                      counterAxisAlignItems:
                                                          LayoutAlign.max,
                                                      child: OrientedLayout(
                                                          orientation:
                                                              LayoutOrientation
                                                                  .vertical,
                                                          primaryAxisAlignItems:
                                                              LayoutAlign
                                                                  .center,
                                                          counterAxisAlignItems:
                                                              LayoutAlign
                                                                  .center,
                                                          diameter: 85.875,
                                                          padding: [0, 0, 0, 4],
                                                          itemSpacing: 10,
                                                          children: [
                                                            {
                                                              15: LayoutText(
                                                                  'Servings',
                                                                  style: TextStyle(
                                                                      height:
                                                                          1.25,
                                                                      fontFamily:
                                                                          "Inter",
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500))
                                                            }
                                                          ]))
                                                }
                                              ])
                                        }
                                      ])
                                },
                                {
                                  120: OrientedLayout(
                                      orientation: LayoutOrientation.vertical,
                                      primaryAxisAlignItems: LayoutAlign.min,
                                      counterAxisAlignItems: LayoutAlign.min,
                                      diameter: 120,
                                      padding: [0, 0, 0, 0],
                                      itemSpacing: 4,
                                      children: [
                                        {
                                          17: MinDiameterSupport(
                                              diameter: 82,
                                              length: 17,
                                              maximumDiameter: 122.875,
                                              orientation:
                                                  LayoutOrientation.vertical,
                                              primaryAxisAlignItems:
                                                  LayoutAlign.min,
                                              counterAxisAlignItems:
                                                  LayoutAlign.min,
                                              child: LayoutText('Instructions',
                                                  style: TextStyle(
                                                      fontFamily: "Inter",
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      height: 1.214285714)))
                                        },
                                        {
                                          31: OrientedLayout(
                                              orientation:
                                                  LayoutOrientation.horizontal,
                                              primaryAxisAlignItems:
                                                  LayoutAlign.min,
                                              counterAxisAlignItems:
                                                  LayoutAlign.max,
                                              diameter: 31,
                                              padding: [0, 0, 0, 0],
                                              itemSpacing: 6,
                                              children: [
                                                {
                                                  31: LayoutText(
                                                      CONTENT
                                                              ?.recipe
                                                              ?.directions
                                                              ?.direction
                                                              ?.length
                                                              .toString() ??
                                                          "??",
                                                      style: TextStyle(
                                                          height: 1.291666667,
                                                          fontFamily:
                                                              "DM Sans"))
                                                },
                                                {
                                                  85.875: MinDiameterSupport(
                                                      length: 85.875,
                                                      diameter: 19,
                                                      maximumDiameter: 31,
                                                      orientation:
                                                          LayoutOrientation
                                                              .horizontal,
                                                      primaryAxisAlignItems:
                                                          LayoutAlign.min,
                                                      counterAxisAlignItems:
                                                          LayoutAlign.max,
                                                      child: OrientedLayout(
                                                          orientation:
                                                              LayoutOrientation
                                                                  .vertical,
                                                          primaryAxisAlignItems:
                                                              LayoutAlign
                                                                  .center,
                                                          counterAxisAlignItems:
                                                              LayoutAlign
                                                                  .center,
                                                          diameter: 85.875,
                                                          padding: [0, 0, 0, 4],
                                                          itemSpacing: 10,
                                                          children: [
                                                            {
                                                              15: LayoutText(
                                                                  'Steps',
                                                                  style: TextStyle(
                                                                      height:
                                                                          1.25,
                                                                      fontFamily:
                                                                          "Inter",
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500))
                                                            }
                                                          ]))
                                                }
                                              ])
                                        }
                                      ])
                                }
                              ])
                        },
                        {32: DecoratedBox(decoration: BoxDecoration())},
                        {
                          51: LayoutText('Description: ',
                              letterSpacing: 0.01,
                              children: [
                                TextSpan(
                                    text: CONTENT?.recipe?.recipeDescription ??
                                        '??',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w400))
                              ],
                              idtext: 'Description: e\ne\ne',
                              style: TextStyle(
                                  height: 1.214285714,
                                  fontWeight: FontWeight.bold))
                        },
                        {53: DecoratedBox(decoration: BoxDecoration())},
                        {
                          33: MinDiameterSupport(
                              diameter: 122,
                              length: 33,
                              maximumDiameter: 333.75,
                              orientation: LayoutOrientation.vertical,
                              primaryAxisAlignItems: LayoutAlign.min,
                              counterAxisAlignItems: LayoutAlign.min,
                              child: LayoutText('Ingredients',
                                  style: TextStyle(
                                      height: 1.375,
                                      fontFamily: "DM Serif Display")))
                        },
                        {45: DecoratedBox(decoration: BoxDecoration())},
                        {
                          ingredientSectionHeight: OrientedLayout(
                              orientation: LayoutOrientation.horizontal,
                              primaryAxisAlignItems: LayoutAlign.min,
                              counterAxisAlignItems: LayoutAlign.min,
                              diameter: ingredientSectionHeight,
                              padding: [0, 0, 0, 0],
                              itemSpacing: 0,
                              children: [
                                {
                                  136.875: OrientedLayout(
                                      orientation: LayoutOrientation.vertical,
                                      primaryAxisAlignItems: LayoutAlign.min,
                                      counterAxisAlignItems: LayoutAlign.min,
                                      diameter: 136.875,
                                      padding: [0, 0, 10.5, 0],
                                      itemSpacing: 102,
                                      children: [
                                        for (final Ingredient a in firstPart)
                                          {
                                            34: RightSideContentReviewIngredient(
                                                count: num.parse(
                                                        a.numberOfUnits ?? '1')
                                                    .toInt()
                                                    .toString(),
                                                name:
                                                    "${a.ingredientDescription}")
                                          },
                                      ])
                                },
                                {
                                  136.875: OrientedLayout(
                                      orientation: LayoutOrientation.vertical,
                                      primaryAxisAlignItems: LayoutAlign.min,
                                      counterAxisAlignItems: LayoutAlign.min,
                                      diameter: 136.875,
                                      padding: [0, 0, 10.5, 0],
                                      itemSpacing: 102,
                                      children: [
                                        for (final Ingredient a in secondPart)
                                          {
                                            34: RightSideContentReviewIngredient(
                                                count: num.parse(
                                                        a.numberOfUnits ?? '1')
                                                    .toInt()
                                                    .toString(),
                                                right: true,
                                                name:
                                                    "${a.ingredientDescription}")
                                          },
                                      ])
                                },
                              ])
                        },
                        {75: DecoratedBox(decoration: BoxDecoration())},
                        {
                          66: GestureDetector(
                            onTap: () {
                              navigatorGrandKey.currentState!
                                  .pushNamed('product_matches');
                            },
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                  color: Color(0xFF2C2C2C),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4.0))),
                              child: MinDiameterSupport(
                                  diameter: 333.75,
                                  length: 21,
                                  maximumDiameter: 333.75,
                                  orientation: LayoutOrientation.vertical,
                                  primaryAxisAlignItems: LayoutAlign.center,
                                  counterAxisAlignItems: LayoutAlign.center,
                                  child: LayoutText('Shop for items',
                                      idtext: 'e',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontFamily: 'DM Sans',
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                          height: 21 / 15.96))),
                            ),
                          )
                        },
                        {75: DecoratedBox(decoration: BoxDecoration())},
                        {
                          33: MinDiameterSupport(
                              diameter: 129,
                              length: 33,
                              maximumDiameter: 333.75,
                              orientation: LayoutOrientation.vertical,
                              primaryAxisAlignItems: LayoutAlign.min,
                              counterAxisAlignItems: LayoutAlign.min,
                              child: LayoutText('Instructions',
                                  style: TextStyle(
                                      height: 1.375,
                                      fontFamily: "DM Serif Display")))
                        },
                      ])
                },
                for (final Direction a
                    in CONTENT?.recipe?.directions?.direction ?? []) ...[
                  {
                    66: InstructionContentReview(
                        number: a.directionNumber ?? '',
                        direction: a.directionDescription ?? '')
                  },
                  InstructionContentReview.returnMissingSpace(
                              a.directionDescription ?? '') >
                          0
                      ? InstructionContentReview.returnMissingSpace(
                          a.directionDescription ?? '')
                      : const SizedBox.shrink(),
                  69
                ],
                {
                  (372 + 31 + 421 + 50): OrientedLayout(
                      orientation: LayoutOrientation.vertical,
                      primaryAxisAlignItems: LayoutAlign.min,
                      counterAxisAlignItems: LayoutAlign.center,
                      diameter: 334,
                      padding: [0, 0, 0, 0],
                      itemSpacing: 0,
                      children: [
                        {6: DecoratedBox(decoration: BoxDecoration())},
                        {
                          32.973305961: LayoutText('Related cooking',
                              style: TextStyle(
                                  fontFamily: "DM Sans",
                                  height: 1.2916666666666667,
                                  fontWeight: FontWeight.w700))
                        },
                        {8: DecoratedBox(decoration: BoxDecoration())},
                        {
                          30: LayoutText('For this afternoon.\n',
                              style:
                                  TextStyle(fontFamily: "Inter", height: 1.25))
                        },
                        {10: DecoratedBox(decoration: BoxDecoration())},
                        {
                          269: OrientedLayout(
                              orientation: LayoutOrientation.vertical,
                              primaryAxisAlignItems: LayoutAlign.min,
                              counterAxisAlignItems: LayoutAlign.min,
                              diameter: (333.75),
                              padding: [0, 15, 0, 25],
                              itemSpacing: 10,
                              children: [
                                {
                                  229: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: OrientedLayout(
                                        orientation:
                                            LayoutOrientation.horizontal,
                                        primaryAxisAlignItems: LayoutAlign.min,
                                        counterAxisAlignItems: LayoutAlign.min,
                                        diameter: 229,
                                        padding: [0, 0, 0, 0],
                                        itemSpacing: 57,
                                        children: [
                                          {
                                            138: home_feature_content(
                                                url:
                                                    "https://images.pexels.com/photos/5745991/pexels-photo-5745991.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
                                                text:
                                                    'Mushrooms scrambled morning eggs',
                                                text2:
                                                    '@armandosoto \n\nThis is a great description.')
                                          },
                                          {
                                            138: home_feature_content(
                                                url:
                                                    "https://images.pexels.com/photos/5745991/pexels-photo-5745991.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
                                                text:
                                                    'Mushrooms scrambled morning eggs',
                                                text2:
                                                    '@armandosoto \n\nThis is a great description.')
                                          },
                                          {
                                            138: home_feature_content(
                                                url:
                                                    "https://images.pexels.com/photos/5745991/pexels-photo-5745991.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
                                                text:
                                                    'Mushrooms scrambled morning eggs',
                                                text2:
                                                    '@armandosoto \n\nThis is a great description.')
                                          }
                                        ]),
                                  )
                                }
                              ])
                        },
                        {10: DecoratedBox(decoration: BoxDecoration())},
                        {
                          32.973305961: LayoutText('Affiliated store',
                              style: TextStyle(
                                  fontFamily: "DM Sans",
                                  height: 1.2916666666666667,
                                  fontWeight: FontWeight.bold))
                        },
                        {
                          421: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: AspectRatio(
                              aspectRatio: 1000 / 421,
                              child: OrientedLayout(
                                  orientation: LayoutOrientation.horizontal,
                                  primaryAxisAlignItems: LayoutAlign.min,
                                  counterAxisAlignItems: LayoutAlign.min,
                                  diameter: 421,
                                  padding: [25.5, 115, 26, 124],
                                  itemSpacing: 131,
                                  children: [
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
                      ])
                }
              ])),
    ]);
  }
}

class RightSideContentReviewIngredient extends StatelessWidget {
  const RightSideContentReviewIngredient({
    super.key,
    required this.count,
    required this.name,
    this.right = false,
  });

  final String count;
  final String name;
  final bool right;

  @override
  Widget build(BuildContext context) {
    // String measure;
    // final words = name.split(" ");

    // var hasMatch = RegExp(r'^[0-9]+$').hasMatch(words.first);

    // if (hasMatch) {
    //   measure = words.removeAt(0);
    //   return ProportionsRow(defaultDiameter: 34, spacing: 10, children: [
    //     LayoutText(measure,
    //         idtext: 'e\ne',
    //         textAlign: TextAlign.end,
    //         style: TextStyle(
    //             fontFamily: "Inter",
    //             fontWeight: FontWeight.bold,
    //             height: 17 / 14)),
    //     Expanded(
    //         child: LayoutText(words.join(" "),
    //             idtext: 'e\ne',
    //             textAlign: TextAlign.end,
    //             style: TextStyle(
    //                 fontFamily: "Inter",
    //                 fontWeight: FontWeight.bold,
    //                 color: right ? Color(0xFF211A1A) : Colors.black,
    //                 height: 17 / 14)))
    //   ]);
    // }

    return LayoutText(name,
        idtext: 'e\ne',
        textAlign: TextAlign.end,
        style: TextStyle(
            fontFamily: "Inter", fontWeight: FontWeight.bold, height: 17 / 14));
  }
}

class ContentReviewIngredient extends StatelessWidget {
  const ContentReviewIngredient({
    super.key,
    required this.count,
    required this.name,
  });

  final String count;
  final String name;

  @override
  Widget build(BuildContext context) {
    return LayoutText(wrap(name, width: 14).join("\n"),
        removeLines: false,
        idtext: '1 can reduced\nsodium kidney',
        textAlign: TextAlign.end,
        style: TextStyle(
            fontFamily: "Inter",
            fontWeight: FontWeight.bold,
            height: 1.214285714));
  }
}

class InstructionContentReview extends StatelessWidget {
  const InstructionContentReview({
    super.key,
    required this.number,
    required this.direction,
  });
  static returnMissingSpace(String direction) {
    final t = wrap(direction, width: 24);
    if (t.length > 3) {
      var d = ((t.length) * 19) - (19 * 3);
      return d;
    } else {
      return 0;
    }
  }

  final String number;
  final String direction;

  @override
  Widget build(BuildContext context) {
    final t = wrap(direction, width: 24).join("\n");
    final tt = wrap(direction, width: 24);
    final words = t.split(" ");
    final first_word = words.removeAt(0);
    return Align(
      alignment: Alignment.topLeft,
      child: OrientedLayout(
          orientation: LayoutOrientation.horizontal,
          primaryAxisAlignItems: LayoutAlign.min,
          counterAxisAlignItems: LayoutAlign.min,
          diameter: 66,
          padding: [30, 0, 30, 0],
          itemSpacing: 44,
          children: [
            {
              21: OrientedLayout(
                  orientation: LayoutOrientation.vertical,
                  primaryAxisAlignItems: LayoutAlign.center,
                  counterAxisAlignItems: LayoutAlign.center,
                  diameter: 21,
                  padding: [0, 6, 0, 0],
                  itemSpacing: 10,
                  children: [
                    {
                      60: LayoutText(number,
                          style: TextStyle(
                              fontFamily: 'DM Serif Display', height: 1))
                    }
                  ])
            },
            {
              208.75: MinDiameterSupport(
                  diameter: 19,
                  length: 208.75,
                  maximumDiameter: 66,
                  orientation: LayoutOrientation.horizontal,
                  primaryAxisAlignItems: LayoutAlign.min,
                  counterAxisAlignItems: LayoutAlign.min,
                  child: LayoutText(
                    first_word + ' ',
                    letterSpacing: 0.02,
                    idtext: 'e',
                    removeLines: false,
                    style: TextStyle(
                        height: 1.1875,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Inter'),
                    children: [
                      TextSpan(
                          text: words.join(" "),
                          style: TextStyle(fontWeight: FontWeight.w400))
                    ],
                  ))
            }
          ]),
    );
  }
}

class InstructionBlock extends StatelessWidget {
  const InstructionBlock({
    super.key,
    required this.text2,
    required this.text,
  });

  final String text2;
  final String text;

  @override
  Widget build(BuildContext context) {
    final t = wrap(text, width: 37).join("\n");
    final tt = wrap(text, width: 37);
    final words = text.split(" ");
    final first_word = words.removeAt(0);
    return OrientedLayout(
        orientation: LayoutOrientation.horizontal,
        primaryAxisAlignItems: LayoutAlign.min,
        counterAxisAlignItems: LayoutAlign.min,
        diameter: 66,
        padding: [0, 0, 0, 0],
        itemSpacing: 44,
        children: [
          {
            21: OrientedLayout(
                orientation: LayoutOrientation.vertical,
                primaryAxisAlignItems: LayoutAlign.center,
                counterAxisAlignItems: LayoutAlign.center,
                diameter: 21,
                padding: [0, 6, 0, 0],
                itemSpacing: 10,
                children: [
                  {
                    60: LayoutText(text2,
                        style: TextStyle(
                            fontFamily: 'DM Serif Display', height: 1))
                  }
                ])
          },
          {
            301: MinDiameterSupport(
                diameter: 19 * tt.length,
                length: 301,
                maximumDiameter: 66,
                orientation: LayoutOrientation.horizontal,
                primaryAxisAlignItems: LayoutAlign.min,
                counterAxisAlignItems: LayoutAlign.min,
                child: LayoutText(
                  first_word + ' ',
                  letterSpacing: 0.02,
                  idtext: t,
                  removeLines: true,
                  style: TextStyle(
                      height: 1.1875,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Inter'),
                  children: [
                    TextSpan(
                        text: words.join(" "),
                        style: TextStyle(fontWeight: FontWeight.w400))
                  ],
                ))
          }
        ]);
  }
}


//  final query =
//         Uri(queryParameters: {'url': img, 'width': "1280", 'height': "960"})
//             .query;
//     final descriptionstringlines = wrap(description.toCapitalized(),
//         maxLines: titlestringlines.length > 1 ? 2 : 3,
//         width: 24,
//         placeholder: "     ",
//         breakLongWords: true,
//         fixSentenceEndings: false);

//     final other = (titlestringlines.length * 20);

//     var i = 16 * descriptionstringlines.length;

//     // String file = img.replaceAll(r"/^.*[\\/]/", '');

//     return GestureDetector(
//       // behavior: HitTestBehavior.deferToChild,
//       onTap: () {
//         navigationGrandKey.currentState!.push(
//           scaleIn(ContentReview(
//             id: id,
//             request: FatsecretSelector.selectParams(
//                 {"format": "json", "recipe_id": id}, "recipe.get.v2"),
//             imageStringQuery: "$mainDomain/api/resize/image.png?$query",