import 'package:flutter/material.dart';
import 'package:platter/components/ScreenAspectRatioContainer.dart';
import 'package:platter/fonts.dart';
import 'package:platter/layout.dart';
import 'package:platter/layout_text.dart';
import 'package:platter/mobile_constants.dart';
import 'package:platter/pages/home_search.dart';

final globalCommentEntryEditingController = TextEditingController();

class InputScreen extends StatelessWidget {
  const InputScreen({super.key});

  @override
  Widget build(BuildContext context) {
    
    return  SingleChildScrollView(
      // physics: ScrollPhysics,
      child: ScreenAspectRatioContainer(
        child: OrientedLayout(
            orientation: LayoutOrientation.vertical,
            primaryAxisAlignItems: LayoutAlign.min,
            counterAxisAlignItems: LayoutAlign.center,
                 diameter: 363.75,
            padding: const [25.5, 0, 37, 0],
            itemSpacing: 0,
            children: [
              const SafeArea(child: SizedBox.shrink()),
              const {18: antiwhite},
              {
                150: DecoratedBox(
                  decoration: BoxDecoration(
                      border:
                          Border.all(color: const Color(0xFF9E9E9E), width: 1)),
                  child: OrientedLayout(
                      orientation: LayoutOrientation.horizontal,
                      primaryAxisAlignItems: LayoutAlign.min,
                      counterAxisAlignItems: LayoutAlign.max,
                      diameter: 150,
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
                              diameter: 150,
                              length: 320,
                              maximumDiameter: 150,
                              orientation: LayoutOrientation.horizontal,
                              primaryAxisAlignItems: LayoutAlign.min,
                              counterAxisAlignItems: LayoutAlign.max,
                              child: LayoutTextInput('Any thoughs',
                                  postFontSize: 0.5,
                                  textEditingController: globalCommentEntryEditingController,
                                  action: TextInputAction.newline,
                                  onSubmit: (v) {
                                // navigatorGrandKey.currentState!.pushNamed(
                                //     "searcher_results",
                                //     arguments: {"query": v });
                              },
                                  maxLines: 10,
                                  style: fonts["common DM Serif Text"]!
                                      .copyWith(height: 1.3666666666666667)))
                        }
                      ]),
                )
              },
             ]),
      ),
    );
  }
}