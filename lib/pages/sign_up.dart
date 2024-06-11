import 'package:flutter/material.dart';
import 'package:platter/change_notifiers/AppStatusNotifier.dart';
import 'package:platter/fonts.dart';
import 'package:platter/layout.dart';
import 'package:platter/layout_text.dart';
import 'package:platter/mobile_constants.dart';
import 'package:platter/pages/sign_in.dart';
import 'package:provider/provider.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  bool _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      // This entry is empty ...
      return false;
    }

    // Regex pattern for validating email
    const pattern =
        r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-]+$';
    final regex = RegExp(pattern);

    if (!regex.hasMatch(value)) {
      // 'Enter a valid email address'
      return false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    AppStatusNotifier n =
        Provider.of<AppStatusNotifier>(context, listen: false);

    var emailEditingController = TextEditingController();
    var nicknameEditingController = TextEditingController();
    return SingleChildScrollView(
      child: AspectRatio(
        aspectRatio: 485 / 935,
        child: OrientedLayout(
            orientation: LayoutOrientation.vertical,
            primaryAxisAlignItems: LayoutAlign.min,
            counterAxisAlignItems: LayoutAlign.min,
            diameter: 485 * 0.75,
            padding: [50 * 0.75, 115 * 0.75, 50 * 0.75, 10 * 0.75],
            itemSpacing: 0,
            children: [
              {
                19: LayoutText('Username (optional)',
                    style: TextStyle(
                        fontFamily: "Inter", height: 1.1904761904761905))
              },
              {
                34: MinDiameterSupport(
                    diameter: 150,
                    length: 34,
                    maximumDiameter: 485 - 0.75,
                    orientation: LayoutOrientation.vertical,
                    primaryAxisAlignItems: LayoutAlign.min,
                    counterAxisAlignItems: LayoutAlign.min,
                    child: DecoratedBox(decoration: BoxDecoration()))
              },
              {
                66: Container(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: BoxDecoration(
                      border:
                          Border.all(color: const Color(0xFF9E9E9E), width: 1)),
                  child: OrientedLayout(
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
                              orientation: LayoutOrientation.horizontal,
                              primaryAxisAlignItems: LayoutAlign.min,
                              counterAxisAlignItems: LayoutAlign.max,
                              child: LayoutTextInput('Your username',
                                  textEditingController:
                                      nicknameEditingController,
                                  maxLines: 1,
                                  style: fonts["common DM Serif Text"]!
                                      .copyWith(height: 1.3666666666666667)))
                        }
                      ]),
                )
              },
              {
                105: MinDiameterSupport(
                    diameter: 150,
                    length: 105,
                    maximumDiameter: 486,
                    orientation: LayoutOrientation.vertical,
                    primaryAxisAlignItems: LayoutAlign.min,
                    counterAxisAlignItems: LayoutAlign.min,
                    child: DecoratedBox(decoration: BoxDecoration()))
              },
              {
                19: LayoutText('Email',
                    style: TextStyle(
                        fontFamily: "Inter", height: 1.1904761904761905))
              },
              {
                35: MinDiameterSupport(
                    diameter: 150,
                    length: 35,
                    maximumDiameter: 486,
                    orientation: LayoutOrientation.vertical,
                    primaryAxisAlignItems: LayoutAlign.min,
                    counterAxisAlignItems: LayoutAlign.min,
                    child: DecoratedBox(decoration: BoxDecoration()))
              },
              {
                66: Container(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: BoxDecoration(
                      border:
                          Border.all(color: const Color(0xFF9E9E9E), width: 1)),
                  child: OrientedLayout(
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
                              orientation: LayoutOrientation.horizontal,
                              primaryAxisAlignItems: LayoutAlign.min,
                              counterAxisAlignItems: LayoutAlign.max,
                              child: LayoutTextInput('Your email',
                                  maxLines: 1,
                                  textEditingController: emailEditingController,
                                  style: fonts["common DM Serif Text"]!
                                      .copyWith(height: 1.3666666666666667)))
                        }
                      ]),
                )
              },
              {159 * 0.3: antiwhite},
              {
                66: LayButton(
                    onTap: () {
                      if (_validateEmail(emailEditingController.text)) {
                        navigatorGrandKey.currentState!
                            .pushNamed("sign_up_first_stage", arguments: {
                          "EMAIL": emailEditingController.text,
                          "NICKNAME": nicknameEditingController.text
                        });
                      }
                    },
                    display: 'Complete & continue')
              },
            ]),
      ),
    );
  }
}
