import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:platter/change_notifiers/AppStatusNotifier.dart';
import 'package:platter/head/header.dart';
import 'package:platter/layout.dart';
import 'package:platter/layout_text.dart';
import 'package:platter/mobile_constants.dart';
import 'package:platter/models/RecipeLikesByUser.dart';
import 'package:provider/provider.dart';
import 'package:textwrap/textwrap.dart';

extension ChunkSlices on List {
  Iterable<List> slices(int length) sync* {
    if (length < 1) throw RangeError.range(length, 1, null, 'length');

    var iterator = this.iterator;
    while (iterator.moveNext()) {
      var slice = [iterator.current];
      for (var i = 1; i < length && iterator.moveNext(); i++) {
        slice.add(iterator.current);
      }
      yield slice;
    }
  }
}

class Library extends StatefulWidget {
  const Library({super.key});

  @override
  State<Library> createState() => _LibraryState();
}

class _LibraryState extends State<Library> {
  String URL = '';
  late AppStatusNotifier notifier =
      Provider.of<AppStatusNotifier>(context, listen: false);
  List<RecipeLikesByUser> content = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    URL = notifier.routeArgs['CONTENT'];
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      listener({bool remove = true}) {
        print("notifier.listdata(URL)");
        print(notifier.listdata(URL));
        if (notifier.listdata(URL).isNotEmpty) {
          setState(() {
            content = recipeLikesByUserFromDynamic(notifier.listdata(URL));
            print("content.length");
            print(content.length);
          });
        }
        if (remove == true) {
          notifier.removeListener(listener);
        }
      }

      listener(remove: false);
      notifier.addListener(listener);
    });
  }

  @override
  Widget build(BuildContext context) {
    var length2 = content.slices(2).length;
    return SingleChildScrollView(
        child: AspectRatio(
      aspectRatio:
          363.75 / (200 + ((length2 > 0 ? length2 : 1) * (194 + 38.25))),
      child: OrientedLayout(
          orientation: LayoutOrientation.vertical,
          primaryAxisAlignItems: LayoutAlign.min,
          counterAxisAlignItems: LayoutAlign.center,
          diameter: 363.75,
          padding: [20, 0, 19, 0],
          itemSpacing: 0,
          children: [
            {28 + 5.25 + 47: antiwhite},
            {
              31: OrientedLayout(
                  orientation: LayoutOrientation.horizontal,
                  primaryAxisAlignItems: LayoutAlign.min,
                  counterAxisAlignItems: LayoutAlign.center,
                  diameter: 31,
                  padding: [0, 0, 0, 0],
                  itemSpacing: 10,
                  children: [
                    {
                      324.75: LayoutText('My Collection',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              height: 31 / 24,
                              fontFamily: 'DM Sans',
                              fontWeight: FontWeight.w500))
                    },
                  ])
            },
            {30.75: DecoratedBox(decoration: BoxDecoration())},
            for (List<dynamic> x in content.slices(2))
              {
                194: OrientedLayout(
                    orientation: LayoutOrientation.horizontal,
                    primaryAxisAlignItems: LayoutAlign.center,
                    counterAxisAlignItems: LayoutAlign.center,
                    diameter: 194,
                    padding: const [0, 0, 0, 0],
                    itemSpacing: 36,
                    children: [
                      {
                        125: CollectionItem(
                            image: x[0].recipe?.recipeImage ?? '',
                            name: x[0].recipe?.recipeName ?? '',
                            recipeId: x[0].recipe?.recipeId ?? '',
                            description: x[0].recipe?.recipeDescription ?? '')
                      },
                      x.length > 1
                          ? {
                              125: CollectionItem(
                                  image: x[1].recipe?.recipeImage ?? '',
                                  name: x[1].recipe?.recipeName ?? '',
                                  recipeId: x[1].recipe?.recipeId ?? '',
                                  description:
                                      x[1].recipe?.recipeDescription ?? '')
                            }
                          : {125: antiwhiteVertical},
                    ]),
                38.25: antiwhite
              },
          ]),
    ));
  }
}

class CollectionItem extends StatelessWidget {
  const CollectionItem({
    super.key,
    required this.image,
    required this.name,
    required this.recipeId,
    required this.description,
  });

  final String image;
  final String name;
  final String recipeId;
  final String description;

  @override
  Widget build(BuildContext context) {
    var wrapedName = wrap(name, width: 13);
    return GestureDetector(
        onTap: () {
          var notifier = Provider.of<AppStatusNotifier>(
              navigatorGrandKey.currentContext!,
              listen: false);
          String URL = notifier
              .fatsecretConsumer("recipe.get.v2", {"recipe_id": recipeId});

          precacheImage(
              NetworkImage(AppStatusNotifier.imgURL(image ?? '')), context);
          print('notifier.session?.user?.email');
          print(notifier.session?.user?.email);
          String LIKES_URL = notifier
              .recipeLikebyUser(notifier.session?.user?.id?.toString() ?? '');

          navigatorGrandKey.currentState!.pushNamed("content_review",
              arguments: {
                "URL": URL,
                "imageURL": image,
                "recipeTitle": name,
                "recipeId": recipeId,
                "URL_1": LIKES_URL
              });
        },
        child: OrientedLayout(
            orientation: LayoutOrientation.vertical,
            primaryAxisAlignItems: LayoutAlign.min,
            counterAxisAlignItems: LayoutAlign.min,
            diameter: 125,
            padding: [0, 0, 0, 0],
            itemSpacing: 0,
            children: [
              {
                121: image.isEmpty
                    ? DecoratedBox(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(
                                    'assets/backgrounds/placeholder.png'))))
                    : DecoratedBox(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover, image: NetworkImage(image))))
              },
              {
                11: MinDiameterSupport(
                    diameter: 34,
                    length: 11,
                    maximumDiameter: 125,
                    orientation: LayoutOrientation.vertical,
                    primaryAxisAlignItems: LayoutAlign.min,
                    counterAxisAlignItems: LayoutAlign.min,
                    child: DecoratedBox(decoration: BoxDecoration()))
              },
              {
                wrapedName.length * 25: LayoutText(wrapedName.join("\n"),
                    removeLines: false,
                    maxLines: 2,
                    idtext: 'e${'\ne' * (wrapedName.length - 1)}',
                    style: TextStyle(
                        fontFamily: 'DM Serif Display', height: 25 / 18))
              },
              {
                5: MinDiameterSupport(
                    diameter: 34,
                    length: 5,
                    maximumDiameter: 125,
                    orientation: LayoutOrientation.vertical,
                    primaryAxisAlignItems: LayoutAlign.min,
                    counterAxisAlignItems: LayoutAlign.min,
                    child: DecoratedBox(decoration: BoxDecoration()))
              },
              {
                wrapedName.length > 1 ? 16 : 32: LayoutText(description,
                    idtext: wrapedName.length > 1 ? 'e' : 'e\ne',
                    maxLines: wrapedName.length > 1 ? 1 : 2,
                    style: TextStyle(fontFamily: 'DM Sans', height: 16 / 12))
              }
            ]));
  }
}

class LibraryContent extends StatelessWidget {
  const LibraryContent({
    super.key,
    required this.url,
    required this.text,
    required this.text2,
  });

  final String url;
  final String text;
  final String text2;

  @override
  Widget build(BuildContext context) {
    return OrientedLayout(
        orientation: LayoutOrientation.vertical,
        primaryAxisAlignItems: LayoutAlign.min,
        counterAxisAlignItems: LayoutAlign.min,
        diameter: 125,
        padding: [0, 0, 0, 0],
        itemSpacing: 0,
        children: [
          {
            121: DecoratedBox(
                decoration: BoxDecoration(
                    image: DecorationImage(image: NetworkImage(url))))
          },
          {
            11: MinDiameterSupport(
                diameter: 34,
                length: 11,
                maximumDiameter: 125,
                orientation: LayoutOrientation.vertical,
                primaryAxisAlignItems: LayoutAlign.min,
                counterAxisAlignItems: LayoutAlign.min,
                child: antiwhite)
          },
          {
            25: MinDiameterSupport(
                diameter: 66,
                length: 25,
                maximumDiameter: 125,
                orientation: LayoutOrientation.vertical,
                primaryAxisAlignItems: LayoutAlign.min,
                counterAxisAlignItems: LayoutAlign.min,
                child: LayoutText(text,
                    style: TextStyle(
                        height: 1.3888888888888888,
                        fontFamily: "DM Serif Display")))
          },
          {
            5: MinDiameterSupport(
                diameter: 34,
                length: 5,
                maximumDiameter: 125,
                orientation: LayoutOrientation.vertical,
                primaryAxisAlignItems: LayoutAlign.min,
                counterAxisAlignItems: LayoutAlign.min,
                child: antiwhite)
          },
          {
            32: MinDiameterSupport(
                diameter: 92,
                length: 32,
                maximumDiameter: 125,
                orientation: LayoutOrientation.vertical,
                primaryAxisAlignItems: LayoutAlign.min,
                counterAxisAlignItems: LayoutAlign.min,
                child: LayoutText(text2,
                    style: TextStyle(
                        height: 1.3333333333333333, fontFamily: "DM Sans")))
          }
        ]);
  }
}
