import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:platter/change_notifiers/AppStatusNotifier.dart';
import 'package:platter/change_notifiers/UserSessionNotifier.dart';
import 'package:platter/components/thermomether.dart';
import 'package:platter/layout.dart';
import 'package:platter/layout_text.dart';
import 'package:platter/mobile_constants.dart';
import 'package:platter/models/CurrentWeather.dart';
import 'package:platter/models/RecipeList.dart';
import 'package:provider/provider.dart';
import 'package:textwrap/textwrap.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  Map<String, RecipeList?>? homeContent;
  Map<String, num?>? homePages;

  CurrentWeather? homeWeather;
  String? CONTENT_WEATHER;

  late final AppStatusNotifier notifier =
      Provider.of<AppStatusNotifier>(context, listen: false);

  late Map CONTENT;

  @override
  void initState() {
    // TODO: implement initState
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await rebuild();
      if (mounted) {
        CONTENT = notifier.routeArgs?["CONTENT"] ?? {};

        listener();

        notifier.addListener(listener);

        await notifier.init();
        CONTENT_WEATHER = notifier.currentWeather();

        weatherListener();

        notifier.addListener(weatherListener);
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

  void listener() {
    homeContent ??= {};
    homePages ??= {};

    if (mounted) {
      for (final map in CONTENT.entries) {
        Uri uri = Uri.parse(map.value["URL"]);

        uri = uri.replace(queryParameters: {
          ...uri.queryParameters,
          "page_number": (homePages?[map.key] ?? 0).toString()
        });

        var uriString = uri.toString();

        if (notifier.data(uriString).isEmpty == false) {
          final dataRecipeList = RecipeList.fromJson(notifier.data(uriString));

          // await rebuild();
          setState(() {
            if (homeContent![map.key] == null) {
              homeContent![map.key] = dataRecipeList;
              homePages![map.key] = 1;
            } else {
              if (dataRecipeList.recipes?.pageNumber ==
                  (homePages?[map.key] ?? 1).toString()) {
                homeContent![map.key]
                    ?.recipes
                    ?.recipe
                    ?.addAll(dataRecipeList.recipes?.recipe ?? []);

                homePages?[map.key] = (homePages?[map.key] ?? 1) + 1;
              }
            }
          });
        }
      }
    }
  }

  void weatherListener() {
    print("CONTENT_WEATHER");
    print(CONTENT_WEATHER);
    if (notifier.data(CONTENT_WEATHER ?? '') != null) {
      CurrentWeather dataWeather =
          CurrentWeather.fromJson(notifier.data(CONTENT_WEATHER ?? ''));
      setState(() {
        homeWeather = dataWeather;
      });
      notifier.removeListener(weatherListener);
    }
  }

  @override
  void dispose() {
    notifier.removeListener(listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<double> temperature = ValueNotifier(0.5);

    return Stack(
      fit: StackFit.passthrough,
      children: [
        ListView(
          children: [
            AspectRatio(
              aspectRatio: 485 / 3200,
              child: OrientedLayout(
                  orientation: LayoutOrientation.vertical,
                  primaryAxisAlignItems: LayoutAlign.min,
                  counterAxisAlignItems: LayoutAlign.min,
                  diameter: 485 * 0.75,
                  padding: const [32, 0, 41, 0],
                  itemSpacing: 0,
                  children: [
                    const SafeArea(
                      child: SizedBox.shrink(),
                    ),

                    // const {57: antiwhite},
                    const {(2): antiwhite},
                    {40.09: antiwhite},
                    const {
                      27: LayoutText('Welcome back!',
                          style: TextStyle(
                              fontFamily: "DM Sans",
                              height: 1.2916666666666667,
                              fontWeight: FontWeight.w700))
                    },
                    const {16: antiwhite},

                    const {
                      44: DecoratedBox(
                        decoration:
                            BoxDecoration(boxShadow: defaultIconShadowB),
                        child: LayoutText('Random pick to start - ',
                            idtext: 'e\ne',
                            maxLines: 2,
                            children: [
                              TextSpan(
                                  text: 'Jam and cheese hispanic hojaldres.',
                                  style: TextStyle(color: Color(0xFF5EC9F8)))
                            ],
                            style: TextStyle(
                                fontFamily: "DM Serif Text",
                                height: 1.375,
                                fontWeight: FontWeight.w400)),
                      )
                    },
                    const {16: antiwhite},
                    const {
                      31: LayoutText('Today',
                          style: TextStyle(
                              fontFamily: "DM Sans",
                              height: 1.2916666666666667,
                              fontWeight: FontWeight.w700))
                    },
                    const {21: antiwhite},

                    {
                      96: DecoratedBox(
                          decoration: BoxDecoration(
                              color: const Color.fromRGBO(217, 217, 217, 0.20),
                              border: Border.all(
                                  color:
                                      const Color.fromRGBO(217, 217, 217, 1))),
                          child: OrientedLayout(
                              orientation: LayoutOrientation.horizontal,
                              primaryAxisAlignItems: LayoutAlign.min,
                              counterAxisAlignItems: LayoutAlign.min,
                              diameter: 96,
                              padding: const [21.75, 0, 0, 0],
                              itemSpacing: 0,
                              children: [
                                {
                                  184: OrientedLayout(
                                      orientation: LayoutOrientation.vertical,
                                      primaryAxisAlignItems: LayoutAlign.center,
                                      counterAxisAlignItems: LayoutAlign.min,
                                      diameter: 184,
                                      padding: [0, 10, 0, 10],
                                      itemSpacing: 9,
                                      children: [
                                        {
                                          43: OrientedLayout(
                                              orientation:
                                                  LayoutOrientation.horizontal,
                                              primaryAxisAlignItems:
                                                  LayoutAlign.min,
                                              counterAxisAlignItems:
                                                  LayoutAlign.min,
                                              diameter: 43,
                                              padding: [0, 0, 0, 0],
                                              itemSpacing: 21,
                                              children: [
                                                {
                                                  43: DecoratedBox(
                                                      decoration: BoxDecoration(
                                                          image: DecorationImage(
                                                              fit: BoxFit.cover,
                                                              image: NetworkImage(
                                                                  "https:${homeWeather?.current?.condition?.icon ?? '//cdn.weatherapi.com/weather/64x64/day/116.png'}"))))
                                                },
                                                {
                                                  126: MinDiameterSupport(
                                                      diameter: 31,
                                                      length: 126,
                                                      maximumDiameter: 43,
                                                      orientation:
                                                          LayoutOrientation
                                                              .horizontal,
                                                      primaryAxisAlignItems:
                                                          LayoutAlign.min,
                                                      counterAxisAlignItems:
                                                          LayoutAlign.min,
                                                      child: LayoutText(
                                                          homeWeather
                                                                  ?.current
                                                                  ?.condition
                                                                  ?.text ??
                                                              'Sunny',
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  "DM Sans",
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              height:
                                                                  1.291666667)))
                                                }
                                              ])
                                        },
                                        {
                                          19: MinDiameterSupport(
                                              diameter: 19,
                                              length: 161,
                                              maximumDiameter: 184,
                                              orientation:
                                                  LayoutOrientation.vertical,
                                              primaryAxisAlignItems:
                                                  LayoutAlign.space_between,
                                              counterAxisAlignItems:
                                                  LayoutAlign.min,
                                              child: OrientedLayout(
                                                  orientation: LayoutOrientation
                                                      .horizontal,
                                                  primaryAxisAlignItems:
                                                      LayoutAlign.min,
                                                  counterAxisAlignItems:
                                                      LayoutAlign.min,
                                                  diameter: 19,
                                                  padding: [0, 0, 0, 0],
                                                  itemSpacing: 25,
                                                  children: [
                                                    LayoutText(
                                                        '${homeWeather?.current?.tempC ?? '!'} ℃',
                                                        idtext: 'e',
                                                        removeLines: false,
                                                        style: TextStyle(
                                                            fontFamily: "Inter",
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            height:
                                                                1.19047619)),
                                                    LayoutText(
                                                        '${homeWeather?.current?.precipMm ?? '!'} mm',
                                                        style: TextStyle(
                                                            fontFamily: "Inter",
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            height:
                                                                1.19047619)),
                                                    LayoutText(
                                                        '${homeWeather?.current?.humidity ?? '!'} %',
                                                        style: TextStyle(
                                                            fontFamily: "Inter",
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            height: 1.19047619))
                                                  ]))
                                        }
                                      ])
                                },
                                {
                                  85: OrientedLayout(
                                      orientation: LayoutOrientation.vertical,
                                      primaryAxisAlignItems: LayoutAlign.center,
                                      counterAxisAlignItems: LayoutAlign.center,
                                      diameter: 85,
                                      padding: const [0, 0, 0, 0],
                                      itemSpacing: 10,
                                      children: [
                                        {
                                          54: MinDiameterSupport(
                                              diameter: 11,
                                              length: 54,
                                              maximumDiameter: 85,
                                              orientation:
                                                  LayoutOrientation.vertical,
                                              primaryAxisAlignItems:
                                                  LayoutAlign.center,
                                              counterAxisAlignItems:
                                                  LayoutAlign.center,
                                              child: Thermometer(temperature))
                                        }
                                      ])
                                }
                              ]))
                    },

                    const {
                      56: Center(
                        child: AspectRatio(
                          aspectRatio: ((485 * 0.75) - 73) / 22,
                          child: LayoutText('Current weather May 31 1:35 AM',
                              idtext: 'e',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontFamily: "DM Serif Text",
                                  height: 1.375,
                                  fontWeight: FontWeight.w400,
                                  color: Color.fromARGB(255, 18, 18, 19))),
                        ),
                      )
                    },
                    const {
                      44: DecoratedBox(
                        decoration:
                            BoxDecoration(boxShadow: defaultIconShadowB),
                        child: LayoutText('Mood option: ',
                            idtext: 'e\ne',
                            maxLines: 2,
                            children: [
                              TextSpan(
                                  text: 'Sunrise chine smooth morning eggs.',
                                  style: TextStyle(color: Color(0xFF5EC9F8)))
                            ],
                            style: TextStyle(
                                fontFamily: "DM Serif Text",
                                height: 1.375,
                                fontWeight: FontWeight.w400)),
                      )
                    },
                    // const {
                    //   24: LayoutText(
                    //       'Pick for this moment: Sunrise chine smooth morning eggs',
                    //       idtext: 'e',
                    //       maxLines: 1,
                    //       style: TextStyle(
                    //           fontFamily: "DM Serif Text",
                    //           height: 1.375,
                    //           fontWeight: FontWeight.w400))
                    // },
                    const {16: antiwhite},
                    const {
                      30: SingleChildScrollView(
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
                            const {
                              90: TeasingLabel(length: 90, name: 'smoothie')
                            },
                          ],
                        ),
                      )
                    },
                    const {17: antiwhite},
                    for (final a in CONTENT.entries)
                      {
                        380: homeContentCarpet(
                            title: a.value["name"] ?? '?',
                            description: a.value["description"] ?? '?',
                            url: a.value["_URL"],
                            list: homeContent?[a.key ?? ''] ??
                                RecipeList.fromJson({}))
                      },

                    const {58 + 10: antiwhite},
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
                  ]),
            )
          ],
        )
      ],
    );
  }
}

class homeContentCarpet extends StatefulWidget {
  const homeContentCarpet(
      {super.key,
      required this.title,
      required this.description,
      required this.list,
      required this.url});

  final String title;
  final String description;
  final RecipeList list;
  final Function url;

  @override
  State<homeContentCarpet> createState() => _homeContentCarpetState();
}

class _homeContentCarpetState extends State<homeContentCarpet> {
  int page = 0;
  late int length = widget.list.recipes?.recipe?.length ?? 1;
  bool askingForMoreContent = false;
  int extentAsked = 0;

  @override
  Widget build(BuildContext context) {
    length = widget.list.recipes?.recipe?.length ?? 1;

    return ProportionsColumn(defaultDiameter: 412 * 0.75, children: [
      {
        31: LayoutText(widget.title,
            idtext: 'e',
            style: TextStyle(
                fontFamily: "DM Sans",
                height: 1.2916666666666667,
                fontWeight: FontWeight.bold))
      },
      const {(8 * 2): antiwhite},
      {
        30: LayoutText(widget.description,
            idtext: 'e\ne',
            removeLines: false,
            style: TextStyle(fontFamily: "Inter", height: 1.25))
      },
      const {19: antiwhite},
      {
        269: OrientedLayout(
            orientation: LayoutOrientation.vertical,
            primaryAxisAlignItems: LayoutAlign.min,
            counterAxisAlignItems: LayoutAlign.min,
            diameter: 412 * 0.75,
            padding: const [0, 15, 0, 25],
            itemSpacing: 10,
            children: [
              {
                229: Builder(
                  builder: (context) {
                    return ListView.builder(
                        clipBehavior: Clip.none,
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.all(0),
                        // prototypeItem: AspectRatio(
                        //   aspectRatio: (138 + 40) / 229,
                        //   child: SizedBox.shrink(),
                        // ),
                        itemCount: length,
                        itemBuilder: itemBuilder);
                  },
                )
              },
              // {
              //   229: SingleChildScrollView(
              //     scrollDirection: Axis.horizontal,
              //     clipBehavior: Clip.none,
              //     child: OrientedLayout(
              //         orientation: LayoutOrientation.horizontal,
              //         primaryAxisAlignItems: LayoutAlign.min,
              //         counterAxisAlignItems: LayoutAlign.min,
              //         diameter: 229,
              //         padding: const [0, 0, 0, 0],
              //         itemSpacing: 57,
              //         children: [
              //           for (final Recipe a in list.recipes?.recipe ?? [])
              //             {
              //               138: home_feature_content(
              //                   url: a.recipeImage ?? '',
              //                   text: a.recipeName ?? '??',
              //                   recipeId: a.recipeId ?? '764',
              //                   text2:
              //                       '@platterblog \n\n${a.recipeDescription ?? '??'}.')
              //             },
              //         ]),
              //   )
              // }
            ])
      },
      const {(6 + 25): antiwhite},
    ]);
  }

  void askForMoreContent(int index) {
    if (index / length > 0.50 && askingForMoreContent == false) {
      askingForMoreContent = true;
      extentAsked = index;
      page += 1;
      widget.url(page.toString());
    } else {
      if (index > extentAsked + 1) {
        askingForMoreContent = false;
      }
    }
  }

  Widget? itemBuilder(context, index) {
    askForMoreContent(index);

    return Row(
      children: [
        AspectRatio(
          aspectRatio: 138 / 229,
          child: home_feature_content(
              url: widget.list.recipes?.recipe?[index].recipeImage,
              text: widget.list.recipes?.recipe?[index].recipeName ?? '??',
              recipeId: widget.list.recipes?.recipe?[index].recipeId ?? '764',
              text2:
                  '@platterblog \n\n${widget.list.recipes?.recipe?[index].recipeDescription ?? '??'}.'),
        ),
        AspectRatio(aspectRatio: 57 / 334.47560132948485)
      ],
    );
  }
}

class TeasingLabel extends StatefulWidget {
  const TeasingLabel({
    super.key,
    required this.length,
    required this.name,
    this.active = true,
  });

  final int length;
  final String name;
  final bool active;

  @override
  State<TeasingLabel> createState() => _TeasingLabelState();
}

class _TeasingLabelState extends State<TeasingLabel>
    with SingleTickerProviderStateMixin {
  late final DecorationTween decorationTween = DecorationTween(
    begin: BoxDecoration(
        border: Border.all(
            width: 1, color: widget.active ? Colors.black : Colors.transparent),
        borderRadius: BorderRadius.all(Radius.circular(24))),
    end: BoxDecoration(
        border: Border.all(
            width: 1,
            color: widget.active
                ? Color.fromARGB(255, 208, 214, 214)
                : Colors.transparent),
        borderRadius: BorderRadius.all(Radius.circular(24))),
  );

  late UserSessionNotifier notifier =
      Provider.of<UserSessionNotifier>(context, listen: false);

  late final AnimationController _controller = AnimationController(
    vsync: this,
    reverseDuration: Duration(milliseconds: 200),
    duration: Duration(milliseconds: (200 * 0.33).toInt()),
  );

  void notifierListener() {
    if (notifier.homeSelection0 != widget.name) {
      if (_controller.isCompleted) {
        _controller.reverse();
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (notifier.homeSelection0 == widget.name) {
      _controller.forward();
    }
    notifier.addListener(notifierListener);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.active) {
          if (_controller.isCompleted) {
            // _controller.reverse();
          } else {
            _controller.forward().then((value) {
              navigatorGrandKey.currentState!.pushNamed('suited_trendy_content',
                  arguments: {"SUIT_NAME": widget.name});
            });
            notifier.homeSelectionUpdate(widget.name);
          }
        }
      },
      child: DecoratedBoxTransition(
        decoration: decorationTween.animate(_controller),
        child: MinDiameterSupport(
            orientation: LayoutOrientation.horizontal,
            counterAxisAlignItems: LayoutAlign.center,
            diameter: 24,
            length: widget.length,
            maximumDiameter: 30,
            child: LayoutText(
              widget.name,
              textAlign: TextAlign.center,
              style: TextStyle(
                  height: 1.5,
                  fontFamily: "DM Serif Text",
                  fontStyle: FontStyle.italic),
            )),
      ),
    );
  }
}

class AffiliatedStoreItem extends StatelessWidget {
  const AffiliatedStoreItem({
    super.key,
    required this.url,
    required this.name,
  });

  final String url;
  final String name;

  @override
  Widget build(BuildContext context) {
    return OrientedLayout(
        orientation: LayoutOrientation.vertical,
        primaryAxisAlignItems: LayoutAlign.min,
        counterAxisAlignItems: LayoutAlign.min,
        diameter: 112,
        padding: const [0, 0, 0, 0],
        itemSpacing: 22,
        children: [
          {
            125: DecoratedBox(
                decoration: BoxDecoration(
                    image: DecorationImage(image: NetworkImage(url))))
          },
          {
            35: LayoutText(name,
                style: TextStyle(height: 1.25, fontFamily: 'Inter'))
          }
        ]);
  }
}

class home_feature_content extends StatelessWidget {
  const home_feature_content({
    super.key,
    required this.url,
    required this.text,
    required this.text2,
    this.recipeId = "53084389",
  });

  final String? url;
  final String text;
  final String text2;
  final String recipeId;

  @override
  Widget build(BuildContext context) {
    final words = text2.split(" ");
    final usertag = words.removeAt(0);

    return GestureDetector(
      onTap: () {
        var notifier = Provider.of<AppStatusNotifier>(
            navigatorGrandKey.currentContext!,
            listen: false);
        String URL = notifier
            .fatsecretConsumer("recipe.get.v2", {"recipe_id": recipeId});

        precacheImage(
            NetworkImage(AppStatusNotifier.imgURL(url ?? '')), context);
        print('notifier.session?.user?.email');
        print(notifier.session?.user?.email);
        String LIKES_URL = notifier
            .recipeLikebyUser(notifier.session?.user?.id?.toString() ?? '');

        navigatorGrandKey.currentState!.pushNamed("content_review", arguments: {
          "URL": URL,
          "imageURL": url,
          "recipeTitle": text,
          "recipeId": recipeId,
          "URL_1": LIKES_URL
        });
      },
      child: OrientedLayout(
          orientation: LayoutOrientation.vertical,
          primaryAxisAlignItems: LayoutAlign.min,
          counterAxisAlignItems: LayoutAlign.min,
          diameter: 138,
          padding: const [0, 0, 0, 0],
          itemSpacing: 0,
          children: [
            {
              105: DecoratedBox(
                  decoration: BoxDecoration(
                      image: url != null
                          ? DecorationImage(
                              fit: BoxFit.cover,
                              alignment: Alignment.center,
                              image: NetworkImage(url!))
                          : DecorationImage(
                              fit: BoxFit.cover,
                              alignment: Alignment.center,
                              image: AssetImage(
                                  'assets/backgrounds/placeholder.png'))))
            },
            const {10: antiwhite},
            {
              50: LayoutText(wrap(text, width: 14, maxLines: 2).join("\n"),
                  idtext: "breakfast\nsmoothie",
                  removeLines: false,
                  style: const TextStyle(
                      fontFamily: "DM Serif Display",
                      height: 1.3888888888888888))
            },
            {
              64: LayoutText(
                usertag,
                idtext: "e\ne\ne\ne",
                removeLines: false,
                maxLines: 5,
                style: const TextStyle(
                    fontFamily: "DM Sans",
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF5EC9F8),
                    height: 1.3333333333333333),
                children: [
                  TextSpan(
                      text: words.join(" "),
                      style: const TextStyle(
                          fontFamily: "DM Sans",
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                          height: 1.3333333333333333))
                ],
              )
            }
          ]),
    );
  }
}
