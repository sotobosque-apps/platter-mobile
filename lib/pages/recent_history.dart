import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:platter/layout.dart';
import 'package:platter/layout_text.dart';
import 'package:platter/mobile_constants.dart';

class RecentHistory extends StatelessWidget {
  const RecentHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: AspectRatio(
          aspectRatio: 485 / 1300,
          child: OrientedLayout(
              orientation: LayoutOrientation.vertical,
              primaryAxisAlignItems: LayoutAlign.min,
              counterAxisAlignItems: LayoutAlign.min,
              diameter: 363.75,
              padding: const [27, 0, 17.25, 0],
              itemSpacing: 0,
              children: [
                SafeArea(child: SizedBox.shrink()),
                {
                  78: OrientedLayout(
                      orientation: LayoutOrientation.horizontal,
                      primaryAxisAlignItems: LayoutAlign.min,
                      counterAxisAlignItems: LayoutAlign.center,
                      diameter: 78,
                      padding: [0, 0, 0, 0],
                      itemSpacing: 20,
                      children: [
                        {76: SvgPicture.asset('assets/Group 97.svg')},
                        {
                          219: const MinDiameterSupport(
                              diameter: 34,
                              length: 219,
                              maximumDiameter: 78,
                              orientation: LayoutOrientation.horizontal,
                              primaryAxisAlignItems: LayoutAlign.min,
                              counterAxisAlignItems: LayoutAlign.center,
                              child: LayoutText('Recent history',
                                  style: TextStyle(
                                      height: 34 / 24,
                                      fontFamily: 'Noto Serif HK')))
                        }
                      ])
                },
                const {15: DecoratedBox(decoration: BoxDecoration())},
                const {
                  194: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: OrientedLayout(
                        orientation: LayoutOrientation.horizontal,
                        primaryAxisAlignItems: LayoutAlign.min,
                        counterAxisAlignItems: LayoutAlign.center,
                        diameter: 194,
                        padding: [0, 0, 0, 0],
                        itemSpacing: 36,
                        children: [
                          {
                            125: RecentHistoryItem(
                                image:
                                    'https://images.pexels.com/photos/23897672/pexels-photo-23897672/free-photo-of-curry-chicken-in-bowl.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
                                title: 'Chinese rice',
                                description: 'this is a great description.')
                          },
                          {
                            125: RecentHistoryItem(
                                image:
                                    'https://images.pexels.com/photos/23897672/pexels-photo-23897672/free-photo-of-curry-chicken-in-bowl.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
                                title: 'Chinese rice',
                                description: 'this is a great description.')
                          },
                          {
                            125: RecentHistoryItem(
                                image:
                                    'https://images.pexels.com/photos/23897672/pexels-photo-23897672/free-photo-of-curry-chicken-in-bowl.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
                                title: 'Chinese rice',
                                description: 'this is a great description.')
                          },
                          {
                            125: RecentHistoryItem(
                                image:
                                    'https://images.pexels.com/photos/23897672/pexels-photo-23897672/free-photo-of-curry-chicken-in-bowl.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
                                title: 'Chinese rice',
                                description: 'this is a great description.')
                          },
                        ]),
                  )
                },
                {29.25: const DecoratedBox(decoration: BoxDecoration())},
                const {
                  39: LayoutText('Social feed',
                      style: TextStyle(
                          height: 34 / 24, fontFamily: 'Noto Serif HK'))
                },
                {49.5: const DecoratedBox(decoration: BoxDecoration())},
                const {
                  194: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: OrientedLayout(
                        orientation: LayoutOrientation.horizontal,
                        primaryAxisAlignItems: LayoutAlign.min,
                        counterAxisAlignItems: LayoutAlign.center,
                        diameter: 194,
                        padding: [0, 0, 0, 0],
                        itemSpacing: 36,
                        children: [
                          {
                            125: RecentHistoryItem(
                                image:
                                    'https://images.pexels.com/photos/23897672/pexels-photo-23897672/free-photo-of-curry-chicken-in-bowl.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
                                title: 'Chinese rice',
                                description: 'this is a great description.')
                          },
                          {
                            125: RecentHistoryItem(
                                image:
                                    'https://images.pexels.com/photos/23897672/pexels-photo-23897672/free-photo-of-curry-chicken-in-bowl.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
                                title: 'Chinese rice',
                                description: 'this is a great description.')
                          },
                          {
                            125: RecentHistoryItem(
                                image:
                                    'https://images.pexels.com/photos/23897672/pexels-photo-23897672/free-photo-of-curry-chicken-in-bowl.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
                                title: 'Chinese rice',
                                description: 'this is a great description.')
                          },
                        ]),
                  )
                },
              ])),
    );
  }
}

class RecentHistoryItem extends StatelessWidget {
  const RecentHistoryItem({
    super.key,
    required this.image,
    required this.title,
    required this.description,
  });

  final String image;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          navigatorGrandKey.currentState!.pushNamed("content_review");
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
                121: DecoratedBox(
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
                25: LayoutText(title,
                    idtext: 'e',
                    maxLines: 1,
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
                32: MinDiameterSupport(
                    diameter: 92,
                    length: 32,
                    maximumDiameter: 125,
                    orientation: LayoutOrientation.vertical,
                    primaryAxisAlignItems: LayoutAlign.min,
                    counterAxisAlignItems: LayoutAlign.min,
                    child: LayoutText(description,
                        style:
                            TextStyle(height: 16 / 12, fontFamily: 'DM Sans')))
              }
            ]));
  }
}
