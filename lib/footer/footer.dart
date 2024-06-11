import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:platter/change_notifiers/UserSessionNotifier.dart';
import 'package:platter/content_suite.dart';
import 'package:platter/layout.dart';
import 'package:platter/mobile_constants.dart';
import 'package:provider/provider.dart';

class Footer extends StatefulWidget {
  const Footer({super.key});

  @override
  State<Footer> createState() => _FooterState();
}

class _FooterState extends State<Footer> {
  String selected = "home";

  @override
  Widget build(BuildContext context) {
    return Consumer<UserSessionNotifier>(
      builder: (context, value, child) => switch (value.sessionOn) {
        false => SizedBox.shrink(),
        _ => AspectRatio(
            aspectRatio: (485 * 0.75) / 85,
            child: DecoratedBox(
              decoration: BoxDecoration(
                  color: Color(0xFFF9FAFA), boxShadow: defaultIconShadowB),
              child: OrientedLayout(
                  orientation: LayoutOrientation.horizontal,
                  primaryAxisAlignItems: LayoutAlign.center,
                  counterAxisAlignItems: LayoutAlign.center,
                  diameter: 85,
                  padding: [0, 10.3100004196167 * 0.75, 0, 0],
                  itemSpacing: 0,
                  children: [
                    {
                      176.875: GestureDetector(
                          onTap: () {
                            setState(() {
                              selected = 'home';
                            });
                            navigatorGrandKey.currentState!.pushNamed('home', arguments: { "CONTENT": CONTENT_SUITE(context,"home")});
                          },
                          child: MinDiameterSupport(
                              diameter: 61,
                              length: 242.5,
                              maximumDiameter: 85,
                              orientation: LayoutOrientation.horizontal,
                              primaryAxisAlignItems: LayoutAlign.center,
                              counterAxisAlignItems: LayoutAlign.center,
                              child: OrientedLayout(
                                  orientation: LayoutOrientation.horizontal,
                                  primaryAxisAlignItems: LayoutAlign.center,
                                  counterAxisAlignItems: LayoutAlign.center,
                                  diameter: 61,
                                  padding: [0, 0, 0, 0],
                                  itemSpacing: 10,
                                  children: [
                                    {
                                      61: AnimatedSwitcher(
                                          duration:
                                              const Duration(milliseconds: 357),
                                          child: Transform.scale(
                                            key: ValueKey(selected),
                                              scale: 1.25,
                                              child: DecoratedBox(
                                                decoration: BoxDecoration(boxShadow: switch (selected == 'home') {
                                                    false =>
                                                      [],
                                                    _ =>
                                                      defaultIconShadow
                                                  }),
                                                child: SvgPicture.asset(
                                                  switch (selected == 'home') {
                                                    false =>
                                                      'assets/footer-house.svg',
                                                    _ =>
                                                      'assets/footer-house-hover.svg'
                                                  },
                                                  colorFilter: ColorFilter.mode(
                                                      Colors.white.withOpacity(
                                                          switch (selected ==
                                                              'home') {
                                                        false => 0.5,
                                                        _ => 1
                                                      }),
                                                      BlendMode.modulate),
                                                ),
                                              )))
                                    }
                                  ])))
                    },
                    {
                      176.875: GestureDetector(
                        onTap: () {
                          setState(() {
                            selected = 'searcher';
                          });
                          navigatorGrandKey.currentState!.pushNamed('searcher');
                        },
                        child: MinDiameterSupport(
                            diameter: 61,
                            length: 242.5,
                            maximumDiameter: 85,
                            orientation: LayoutOrientation.horizontal,
                            primaryAxisAlignItems: LayoutAlign.center,
                            counterAxisAlignItems: LayoutAlign.center,
                            child: OrientedLayout(
                                orientation: LayoutOrientation.horizontal,
                                primaryAxisAlignItems: LayoutAlign.center,
                                counterAxisAlignItems: LayoutAlign.center,
                                diameter: 61,
                                padding: [0, 0, 0, 0],
                                itemSpacing: 10,
                                children: [
                                  {
                                    61: AnimatedSwitcher(
                                        duration:
                                            const Duration(milliseconds: 357),
                                        child: Transform.scale(
                                          key: ValueKey(
                                                selected),
                                          scale: 1.25,
                                          child: DecoratedBox(
                                                decoration: BoxDecoration(boxShadow: switch (selected == 'searcher') {
                                                    false =>
                                                      [],
                                                    _ =>
                                                      defaultIconShadow
                                                  }),
                                                child:SvgPicture.asset(
                                            
                                            switch (selected) {
                                              false =>
                                                'assets/footer-search.svg',
                                              _ =>
                                                'assets/footer-search-hover.svg'
                                            },
                                            colorFilter: ColorFilter.mode(
                                                Colors.white.withOpacity(
                                                    switch (selected ==
                                                        'searcher') {
                                                  false => 0.5,
                                                  _ => 1
                                                }),
                                                BlendMode.modulate),
                                          )),
                                        ))
                                  }
                                ])),
                      )
                    }
                  ]),
            )),
      },
    );
  }
}
