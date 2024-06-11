import 'package:flutter/material.dart';
import 'package:platter/components/ScreenAspectRatioContainer.dart';
import 'package:platter/layout.dart';
import 'package:platter/layout_text.dart';
import 'package:platter/mobile_constants.dart';
import 'package:textwrap/textwrap.dart';

class OnboardFirstStage extends StatelessWidget {
  final url;
  final title;
  final display;
  final routeName;

  const OnboardFirstStage(
      {super.key,
      this.routeName = 'onboard_second_stage',
      this.url =
          "https://images.pexels.com/photos/9750949/pexels-photo-9750949.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
      this.title = 'Connect with all your necessities',
      this.display =
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod  tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim  veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea  commodo consequat.'});

  @override
  Widget build(BuildContext context) {
    var t =  wrap(title, width: 33);
    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: DecoratedBox(
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.contain,
                scale: 0.5,
                alignment: Alignment.topCenter,
                
                image: NetworkImage(url))),
        child: ScreenAspectRatioContainer(
          child: OrientedLayout(
              orientation: LayoutOrientation.vertical,
              primaryAxisAlignItems: LayoutAlign.max,
              counterAxisAlignItems: LayoutAlign.center,
              diameter: 485*0.75,
              padding: [0, 0, 0, 0],
              itemSpacing: 0,
              children: [
                {
                  42: LayoutText('Great vibes',
                  textAlign: TextAlign.center,
                          style: TextStyle(
                              height: 1.315789474,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontFamily: "DM Sans"))
                },
                {131: DecoratedBox(decoration: BoxDecoration())},
                {
                  55: MinDiameterSupport(
                      diameter: 314,
                      length: 55,
                      maximumDiameter: 485 *0.75,
                      orientation: LayoutOrientation.vertical,
                      primaryAxisAlignItems: LayoutAlign.max,
                      counterAxisAlignItems: LayoutAlign.center,
                      child: GestureDetector(
                        behavior: HitTestBehavior.translucent,
                          onTap: () {
                            navigatorGrandKey.currentState!
                                .pushNamed(routeName, arguments: { "great name": "name"});
                          },
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4))),
                            child: OrientedLayout(
                                orientation: LayoutOrientation.horizontal,
                                primaryAxisAlignItems: LayoutAlign.center,
                                counterAxisAlignItems: LayoutAlign.center,
                                diameter: 55,
                                padding: [0, 17, 0, 17],
                                itemSpacing: 10,
                                children: [
                                  {
                                    150: LayoutText(
                                      'Next',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: "DM Sans",
                                          height: 1.3157894736842104),
                                    )
                                  }
                                ]),
                          )))
                },
                {17: DecoratedBox(decoration: BoxDecoration())},
                {
                  250: DecoratedBox(
                    decoration: BoxDecoration(color: Colors.black),
                    child: OrientedLayout(
                        orientation: LayoutOrientation.vertical,
                        primaryAxisAlignItems: LayoutAlign.min,
                        counterAxisAlignItems: LayoutAlign.min,
                        diameter: 485 * 0.75,
                        padding: [28, 40, 22, 0],
                        itemSpacing: 66,
                        children: [
                          {
                            (31 * t.length): LayoutText(t.join("\n"),
                            idtext: 'Connect with all your necessities',
                            removeLines: false,
                                style: TextStyle(
                                    color: Colors.white,
                                    height: 1.2267510882469332,
                                    fontFamily: "Inter",
                                    fontWeight: FontWeight.bold))
                          },
                          {
                            105: LayoutText(display,
                                idtext: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod  tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim  veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea  commodo consequat.',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "DM Sans",
                                    height: 1.3157894736842104))
                          }
                        ]),
                  )
                }
              ]),
        ),
      ),
    );
  }
}
