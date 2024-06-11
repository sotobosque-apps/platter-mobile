import 'package:flutter/material.dart';
import 'package:msh_checkbox/msh_checkbox.dart';
import 'package:platter/fonts.dart';
import 'package:platter/layout.dart';
import 'package:platter/layout_text.dart';

class TestSuite extends StatefulWidget {
  const TestSuite({super.key});

  @override
  State<TestSuite> createState() => _TestSuiteState();
}

class _TestSuiteState extends State<TestSuite> {
  bool isChecked = false;
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
            padding: [36.75, 0, 36.75, 0],
            itemSpacing: 0,
            children: [
              {42: DecoratedBox(decoration: BoxDecoration())},
              {
                10: OrientedLayout(
                    orientation: LayoutOrientation.vertical,
                    primaryAxisAlignItems: LayoutAlign.min,
                    counterAxisAlignItems: LayoutAlign.max,
                    diameter: 251.45001220703125,
                    padding: [0, 0, 0, 0],
                    itemSpacing: 10,
                    children: [
                      {
                        10: MinDiameterSupport(
                            diameter: 10,
                            length: 10,
                            maximumDiameter: 251.45001220703125,
                            orientation: LayoutOrientation.vertical,
                            primaryAxisAlignItems: LayoutAlign.min,
                            counterAxisAlignItems: LayoutAlign.max,
                            child: DecoratedBox(decoration: BoxDecoration()))
                      }
                    ])
              },
              {15: DecoratedBox(decoration: BoxDecoration())},
              {
                28: OrientedLayout(
                    orientation: LayoutOrientation.horizontal,
                    primaryAxisAlignItems: LayoutAlign.center,
                    counterAxisAlignItems: LayoutAlign.center,
                    diameter: 28,
                    padding: [0, 0, 0, 0],
                    itemSpacing: 10,
                    children: [
                      {62: LayoutText('Platter ', style: TextStyle(height: 1.533, fontFamily: "Noto Serif HK", fontWeight: FontWeight.bold))}
                    ])
              },
              {31: DecoratedBox(decoration: BoxDecoration())},
              {
                66: DecoratedBox(
                  decoration: BoxDecoration(
                      border:
                          Border.all(color: const Color(0xFF9E9E9E), width: 1)),
                  child: OrientedLayout(
                      orientation: LayoutOrientation.horizontal,
                      primaryAxisAlignItems: LayoutAlign.min,
                      counterAxisAlignItems: LayoutAlign.max,
                      diameter: 88,
                      padding: const [33, 11, 33, 11],
                      itemSpacing: 0,
                      children: [
                        // Expanded(, child: ColoredBox(color: Colors.red,),)
                        {
                          320: MinDiameterSupport(
                              diameter: 41,
                              length: 320,
                              maximumDiameter: 88,
                              orientation: LayoutOrientation.horizontal,
                              primaryAxisAlignItems: LayoutAlign.min,
                              counterAxisAlignItems: LayoutAlign.max,
                              child: LayoutTextInput('Your user',
                                  maxLines: 1,
                                  style: fonts["common DM Serif Text"]!
                                      .copyWith(height: 1.3666666666666667)))
                        }
                      ]),
                )
              },
              {16: DecoratedBox(decoration: BoxDecoration())},
              {
                23: OrientedLayout(
                    orientation: LayoutOrientation.horizontal,
                    primaryAxisAlignItems: LayoutAlign.min,
                    counterAxisAlignItems: LayoutAlign.center,
                    diameter: 23,
                    padding: [0, 0, 0, 0],
                    itemSpacing: 10,
                    children: [
                      {
                        173: MinDiameterSupport(
                            diameter: 19,
                            length: 173,
                            maximumDiameter: 23,
                            orientation: LayoutOrientation.horizontal,
                            primaryAxisAlignItems: LayoutAlign.min,
                            counterAxisAlignItems: LayoutAlign.center,
                            child: LayoutText('Forgot your password?',
                                style: TextStyle(height: 1.1904761904761905, fontFamily: "Inter")))
                      }
                    ])
              },
              {20: DecoratedBox(decoration: BoxDecoration())},
              {
                23: OrientedLayout(
                    orientation: LayoutOrientation.horizontal,
                    primaryAxisAlignItems: LayoutAlign.min,
                    counterAxisAlignItems: LayoutAlign.min,
                    diameter: 23,
                    padding: [0, 0, 0, 0],
                    itemSpacing: 7,
                    children: [
                      {
                        26: LayoutBuilder(
                          builder: (c, bc) => MSHCheckbox(
                            size: bc.biggest.height,
                            value: isChecked,
                            duration: Duration(milliseconds: 357),
                            colorConfig:
                                MSHColorConfig.fromCheckedUncheckedDisabled(
                              checkedColor: Colors.blue,
                            ),
                            style: MSHCheckboxStyle.fillScaleCheck,
                            onChanged: (selected) {
                              setState(() {
                                isChecked = selected;
                              });
                            },
                          ),
                        )
                      },
                      {
                        84: MinDiameterSupport(
                            diameter: 19,
                            length: 84,
                            maximumDiameter: 23,
                            orientation: LayoutOrientation.horizontal,
                            primaryAxisAlignItems: LayoutAlign.min,
                            counterAxisAlignItems: LayoutAlign.min,
                            child: LayoutText('Keep me in', style: TextStyle(height: 1.1904761904761905, fontFamily: "Inter")))
                      }
                    ])
              },
              {78: DecoratedBox(decoration: BoxDecoration())},
              {
                58.959999084472656: DecoratedBox(
                    decoration: BoxDecoration(
                        color: Color(0xFF2C2C2C),
                        borderRadius: BorderRadius.all(Radius.circular(4))),
                    child: OrientedLayout(
                        orientation: LayoutOrientation.horizontal,
                        primaryAxisAlignItems: LayoutAlign.center,
                        counterAxisAlignItems: LayoutAlign.center,
                        diameter: 58.959999084472656,
                        padding: [0, 0, 0, 0],
                        itemSpacing: 0,
                        children: [
                          {
                            251.45001220703125: MinDiameterSupport(
                                diameter: 21,
                                length: 251.45001220703125,
                                maximumDiameter: 58.959999084472656,
                                orientation: LayoutOrientation.horizontal,
                                primaryAxisAlignItems: LayoutAlign.center,
                                counterAxisAlignItems: LayoutAlign.center,
                                child:
                                    LayoutText('Sign in' ,textAlign: TextAlign.center, style: TextStyle(color: Colors.white,fontFamily: "DM Sans", fontWeight: FontWeight.w500, height: 1.3157894736842104)))
                          }
                        ]))
              },
              {29: DecoratedBox(decoration: BoxDecoration())},
              {
                58.959999084472656: DecoratedBox(
                    decoration: BoxDecoration(
                        color: Color(0xFF2C2C2C),
                        borderRadius: BorderRadius.all(Radius.circular(4))),
                    child: OrientedLayout(
                        orientation: LayoutOrientation.horizontal,
                        primaryAxisAlignItems: LayoutAlign.center,
                        counterAxisAlignItems: LayoutAlign.center,
                        diameter: 58.959999084472656,
                        padding: [0, 0, 0, 0],
                        itemSpacing: 0,
                        children: [
                          {
                            251.45001220703125: MinDiameterSupport(
                                diameter: 21,
                                length: 251.45001220703125,
                                maximumDiameter: 58.959999084472656,
                                orientation: LayoutOrientation.horizontal,
                                primaryAxisAlignItems: LayoutAlign.center,
                                counterAxisAlignItems: LayoutAlign.center,
                                child:
                                    LayoutText('Sign up',textAlign: TextAlign.center, style: TextStyle(color: Colors.white,fontFamily: "DM Sans", fontWeight: FontWeight.w500, height: 1.3157894736842104)))
                          }
                        ]))
              },
            ]),
      ),
    );
  }
}
