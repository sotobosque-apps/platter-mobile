import 'package:flutter/material.dart';
import 'package:platter/change_notifiers/AppStatusNotifier.dart';
import 'package:platter/fonts.dart';
import 'package:platter/layout.dart';
import 'package:platter/layout_text.dart';
import 'package:platter/mobile_constants.dart';
import 'package:platter/pages/sign_in.dart';
import 'package:provider/provider.dart';

class SignUpFirstStage extends StatelessWidget {
  const SignUpFirstStage({super.key});

  @override
  Widget build(BuildContext context) {
    AppStatusNotifier n =
        Provider.of<AppStatusNotifier>(context, listen: false);

    String email = n.routeArgs["EMAIL"] ?? '';
    String nickname = n.routeArgs["NICKNAME"] ?? email;
    if (nickname.isEmpty) {
      nickname = email;
    }

    var passwordCEditingController = TextEditingController();
    var passwordEditingController = TextEditingController();

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
                19: LayoutText('Password',
                    style: TextStyle(
                        fontFamily: "Inter", height: 1.1904761904761905))
              },
              {
                34: MinDiameterSupport(
                    diameter: 150,
                    length: 34,
                    maximumDiameter: 485 * 0.75,
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
                              child: LayoutTextInput('***',
                                  textEditingController:
                                      passwordEditingController,
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
                    maximumDiameter: 485 * 0.75,
                    orientation: LayoutOrientation.vertical,
                    primaryAxisAlignItems: LayoutAlign.min,
                    counterAxisAlignItems: LayoutAlign.min,
                    child: DecoratedBox(decoration: BoxDecoration()))
              },
              {
                19: LayoutText('Password confirmation',
                    style: TextStyle(
                        fontFamily: "Inter", height: 1.1904761904761905))
              },
              {
                35: MinDiameterSupport(
                    diameter: 150,
                    length: 35,
                    maximumDiameter: 485 * 0.75,
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
                              child: LayoutTextInput('******',
                                  textEditingController:
                                      passwordCEditingController,
                                  maxLines: 1,
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
                      print(passwordCEditingController.text);
                      print(passwordEditingController.text);
                      print(email);
                      print(nickname);

                      if (passwordCEditingController.text ==
                          passwordEditingController.text) {
                        print('am in');
                        String content = n.register(
                            nickname, email, passwordEditingController.text);
                        print('$content');
                        navigatorGrandKey.currentState!
                            .pushNamed("sign_up_final_stage", arguments: {
                          "CONTENT": content,
                          "EMAIL": email,
                          "NICKNAME": nickname
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
