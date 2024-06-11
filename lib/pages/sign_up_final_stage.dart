import 'package:flutter/material.dart';
import 'package:platter/change_notifiers/AppStatusNotifier.dart';
import 'package:platter/layout.dart';
import 'package:platter/layout_text.dart';
import 'package:platter/mobile_constants.dart';
import 'package:platter/pages/sign_in.dart';
import 'package:provider/provider.dart';

class SignUpFinalStage extends StatelessWidget {
  const SignUpFinalStage({super.key});

  @override
  Widget build(BuildContext context) {
    AppStatusNotifier n =
        Provider.of<AppStatusNotifier>(context, listen: false);
    final content = n.routeArgs["CONTENT"] ?? 'no content';
    final email = n.routeArgs["EMAIL"] ?? 'no content';
    print(content);
    print(n.data(content));

    var tokenEditingController = TextEditingController();
    return SingleChildScrollView(
      child: AspectRatio(
        aspectRatio: 485 / 1300,
        child: OrientedLayout(
            orientation: LayoutOrientation.vertical,
            primaryAxisAlignItems: LayoutAlign.min,
            counterAxisAlignItems: LayoutAlign.center,
            diameter: 485 * 0.75,
            padding: [50 * 0.75, 151 * 0.75, 50 * 0.75, 0 * 0.75],
            itemSpacing: 0,
            children: [
              {
                36: LayoutText('One time verification',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        height: 1.2,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w600))
              },
              {47: DecoratedBox(decoration: BoxDecoration())},
              {
                115: DecoratedBox(
                  decoration: BoxDecoration(
                      border:
                          Border.all(color: const Color(0xFF9E9E9E), width: 1)),
                  child: OrientedLayout(
                      orientation: LayoutOrientation.horizontal,
                      primaryAxisAlignItems: LayoutAlign.center,
                      counterAxisAlignItems: LayoutAlign.max,
                      diameter: 115,
                      padding: [0, 0, 0, 11],
                      itemSpacing: 10,
                      children: [
                        {
                          275: MinDiameterSupport(
                              diameter: 53,
                              length: 275,
                              maximumDiameter: 115,
                              orientation: LayoutOrientation.horizontal,
                              primaryAxisAlignItems: LayoutAlign.center,
                              counterAxisAlignItems: LayoutAlign.max,
                              child: LayoutTextInput('XXXYYY',
                                  textAlign: TextAlign.center,
                                  textEditingController: tokenEditingController,
                                  letterSpacing: 0.13,
                                  style: TextStyle(
                                      height: 1.2926829268292683,
                                      fontFamily: "DM Sans",
                                      fontWeight: FontWeight.bold)))
                        }
                      ]),
                )
              },
              {60: DecoratedBox(decoration: BoxDecoration())},
              {
                36: LayoutText('OTP',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        height: 1.2,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w500))
              },
              {24: DecoratedBox(decoration: BoxDecoration())},
              {
                30: LayoutText(
                    'One step before you ready, please confirm that you recieved a code in your email and copy it back to the text field above.',
                    style: TextStyle(
                        height: 1.25,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w500))
              },
              {142 * 0.3: DecoratedBox(decoration: BoxDecoration())},
              {
                66: LayButton(
                    onTap: () {
                      if (tokenEditingController.text.isNotEmpty) {
                        n.platterConfirmValidation(
                            email, tokenEditingController.text);
                        navigatorGrandKey.currentState!.pushNamedAndRemoveUntil(
                            "loading", (route) => false, arguments: {
                          "route": "home",
                          "msg": "Authentication check",
                          
                        });
                      }
                    },
                    display: 'Complete & start')
              },
            ]),
      ),
    );
  }
}
