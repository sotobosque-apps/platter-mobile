import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:platter/change_notifiers/AppStatusNotifier.dart';
import 'package:platter/content_suite.dart';
import 'package:platter/fonts.dart';
import 'package:platter/layout.dart';
import 'package:platter/layout_text.dart';
import 'package:platter/mobile_constants.dart';
import 'package:platter/models/Jwt.dart';
import 'package:platter/pages/home.dart';
import 'package:platter/pages/sign_in.dart';
import 'package:provider/provider.dart';

class SignInPassword extends StatelessWidget {
  const SignInPassword({super.key});

  @override
  Widget build(BuildContext context) {
    AppStatusNotifier notifier =
        Provider.of<AppStatusNotifier>(context, listen: false);

    var passwordEditingController = TextEditingController();

    String email = notifier.routeArgs['EMAIL'] ?? '';

    return SingleChildScrollView(
      child: AspectRatio(
        aspectRatio: 485 / 1300,
        child: OrientedLayout(
          orientation: LayoutOrientation.vertical,
          primaryAxisAlignItems: LayoutAlign.min,
          counterAxisAlignItems: LayoutAlign.min,
          diameter: 485 * 0.75,
          padding: const [49 * 0.75, 0, 50 * 0.75, 0],
          itemSpacing: 0,
          children: [
            const SafeArea(
              child: SizedBox.shrink(),
            ),

            // const {57: antiwhite},
            const {10: antiwhite},

            {
              28: LayoutText('Platter ',
                  textAlign: TextAlign.center,
                  style: fonts["common Noto Serif HK"]!.copyWith(
                      fontWeight: FontWeight.w800, height: 1.5555555555555556))
            },
            const {68: antiwhite},
            {
              66: DecoratedBox(
                decoration: BoxDecoration(
                    border:
                        Border.all(color: const Color(0xFF9E9E9E), width: 1)),
                child: OrientedLayout(
                    orientation: LayoutOrientation.horizontal,
                    primaryAxisAlignItems: LayoutAlign.min,
                    counterAxisAlignItems: LayoutAlign.max,
                    diameter: 66,
                    padding: const [33 * 0.75, 11 * 0.75, 33 * 0.75, 11 * 0.75],
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
                            child: LayoutTextInput('Password',
                                textEditingController:
                                    passwordEditingController,
                                maxLines: 1,
                                style: fonts["common DM Serif Text"]!
                                    .copyWith(height: 1.3666666666666667)))
                      }
                    ]),
              )
            },
            {71 * 0.1: antiwhite},
            const {
              23: OrientedLayout(
                  orientation: LayoutOrientation.horizontal,
                  primaryAxisAlignItems: LayoutAlign.min,
                  counterAxisAlignItems: LayoutAlign.center,
                  diameter: 23,
                  padding: [0, 0, 0, 0],
                  itemSpacing: 10,
                  children: [
                    {
                      300: MinDiameterSupport(
                          diameter: 19,
                          length: 300,
                          maximumDiameter: 23,
                          orientation: LayoutOrientation.horizontal,
                          primaryAxisAlignItems: LayoutAlign.min,
                          counterAxisAlignItems: LayoutAlign.center,
                          child: LayoutText('Forgot your password?',
                              style: TextStyle(
                                  color: Colors.black,
                                  height: 1.19047619,
                                  fontFamily: 'Inter')))
                    }
                  ])
            },
            {57 * 0.2: antiwhite},
            23,
            {231 * 0.2: antiwhite},
            {
              66: LayButton(
                  onTap: () {
                    String URL = notifier.identify(
                        email: email, password: passwordEditingController.text);
                    void listen() {
                      Future.delayed(Duration(milliseconds: 200), () {
                        print('notifier.data(URL).isNotEmpty');
                        print(notifier.data(URL).isNotEmpty);
                        if (notifier.data(URL).isNotEmpty) {
                          print(notifier.data(URL));
                          notifier.setSession(Jwt.fromJson(notifier.data(URL)));
                        }
                      });
                      notifier.removeListener(listen);
                    }

                    notifier.addListener(listen);

                    notifier.initBox().then((value) {
                      navigatorGrandKey.currentState!.pushNamedAndRemoveUntil(
                          "loading", (route) => false,
                          arguments: {
                            "_route": "sign_in_password",
                            "route": "home",
                            "msg": "One last check",
                            "CONTENT_ERROR_CHECK": URL,
                            "CONTENT": CONTENT_SUITE(context, "home"),
                          });
                    });
                  },
                  display: 'Sign in')
            },

            const {29: antiwhite},
            {
              66: LayButton(
                  onTap: () {
                    navigatorGrandKey.currentState!.pushNamed("sign_in");
                  },
                  display: 'Go back')
            },
          ],
        ),
      ),
    );
  }
}
