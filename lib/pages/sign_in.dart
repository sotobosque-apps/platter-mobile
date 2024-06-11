import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:msh_checkbox/msh_checkbox.dart';
import 'package:platter/change_notifiers/AppStatusNotifier.dart';
import 'package:platter/fonts.dart';
import 'package:platter/layout.dart';
import 'package:platter/layout_text.dart';
import 'package:platter/mobile_constants.dart';
import 'package:platter/pages/sign_in_password.dart';
import 'package:provider/provider.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool isChecked = false;
  late AppStatusNotifier n =
      Provider.of<AppStatusNotifier>(context, listen: false);
  @override
  Widget build(BuildContext context) {
    var emailEditingController = TextEditingController();
    return SingleChildScrollView(
      child: AspectRatio(
        aspectRatio: 485 * 0.75 / 1300,
        child: OrientedLayout(
          orientation: LayoutOrientation.vertical,
          primaryAxisAlignItems: LayoutAlign.min,
          counterAxisAlignItems: LayoutAlign.min,
          diameter: 485 * 0.75,
          padding: const [49 * 0.75, 0, 50 * 0.75, 0],
          itemSpacing: 0,
          children: [
            SafeArea(child: SizedBox.shrink()),
            // const {(57 + 32): antiwhite},
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
                            child: LayoutTextInput('Your user',
                                maxLines: 1,
                                textEditingController: emailEditingController,
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
                      300: MinDiameterSupport(
                          diameter: 19,
                          length: 300,
                          maximumDiameter: 23,
                          orientation: LayoutOrientation.horizontal,
                          primaryAxisAlignItems: LayoutAlign.min,
                          counterAxisAlignItems: LayoutAlign.min,
                          child: LayoutText('Keep me in',
                              style: TextStyle(
                                  color: Colors.black,
                                  height: 1.19047619,
                                  fontFamily: 'Inter')))
                    }
                  ])
            },
            {(231 * 0.2): antiwhite},
            {
              66: LayButton(
                  onTap: () {
                    n.initBox().then((value) {
                      navigatorGrandKey.currentState!.pushNamedAndRemoveUntil(
                          "loading", (route) => false,
                          arguments: {
                            "route": "sign_in_password",
                            "msg": "Checking your credentials",
                            "EMAIL": emailEditingController.text
                          });
                    });
                  },
                  display: 'Sign in')
            },
            const {29: antiwhite},
            {
              66: LayButton(
                  onTap: () {
                    n.initBox().then((value) {
                      navigatorGrandKey.currentState!.pushNamed("sign_up");
                    });
                  },
                  display: 'Sign up')
            },
          ],
        ),
      ),
    );
  }
}

class LayButton extends StatelessWidget {
  const LayButton({
    super.key,
    required this.onTap,
    required this.display,
  });

  final Null Function() onTap;
  final String display;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: DecoratedBox(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(4)),
                color: Color(0xFF2C2C2C)),
            child: OrientedLayout(
                orientation: LayoutOrientation.horizontal,
                primaryAxisAlignItems: LayoutAlign.center,
                counterAxisAlignItems: LayoutAlign.center,
                diameter: 66,
                padding: [0, 0, 0, 0],
                itemSpacing: 0,
                children: [
                  {
                    250: MinDiameterSupport(
                        diameter: 21,
                        length: 250,
                        maximumDiameter: 66,
                        orientation: LayoutOrientation.horizontal,
                        primaryAxisAlignItems: LayoutAlign.center,
                        counterAxisAlignItems: LayoutAlign.center,
                        child: LayoutText(display,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                height: 1.315789474,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'DM Sans')))
                  }
                ])));
  }
}
