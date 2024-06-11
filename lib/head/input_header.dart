import 'package:expand_tap_area/expand_tap_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:platter/alert/menu.dart';
import 'package:platter/change_notifiers/AppStatusNotifier.dart';
import 'package:platter/layout.dart';
import 'package:platter/layout_text.dart';
import 'package:platter/mobile_constants.dart';
import 'package:platter/pages/input_screen.dart';
import 'package:provider/provider.dart';
import 'package:textwrap/textwrap.dart';

class InputHeader extends StatelessWidget
    implements PreferredSizeWidget {
 @override
  Size get preferredSize {
    final t = Turner(navigatorGrandKey.currentContext!);
    return Size.fromHeight(t.HeightasProportioned(153 * 1.25).toDouble());
  }

  const InputHeader({super.key});
  void onCall(BuildContext context) {
    showDialog<String>(
      context: navigatorGrandKey.currentContext!,
      useRootNavigator: true,
      barrierColor: Colors.transparent,
      barrierDismissible: true,
      builder: (BuildContext context) => Dialog.fullscreen(
        backgroundColor: Colors.transparent,
        child: Menu(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    AppStatusNotifier notifier = Provider.of<AppStatusNotifier>(context, listen: false);
    final args = ModalRoute.of(context)!.settings.arguments as dynamic;
    String msg = args?["msg"] ?? 'Entry';

    var text = wrap('Entry', width: 15);
    return SafeArea(
      child: Align(
        alignment: Alignment.topLeft,
        child: AspectRatio(
          aspectRatio: 363.75 / (153),
          child: ColoredBox(
            color: Colors.white,
            child: OrientedLayout(
                orientation: LayoutOrientation.vertical,
                primaryAxisAlignItems: LayoutAlign.min,
                counterAxisAlignItems: LayoutAlign.max,
                diameter: 363.75,
                padding: [24.5, 22, 24.5, 0],
                itemSpacing: 18,
                children: [
                  {
                    52: DecoratedBox(
                        decoration:
                            const BoxDecoration(boxShadow: defaultIconShadow),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: GestureDetector(
                            onTap: () {
                              onCall(context);
                            },
                            child: AspectRatio(
                              aspectRatio: 1,
                              child: SvgPicture.asset('assets/dot.svg'),
                            ),
                          ),
                        ))
                  },
                  {
                    52: OrientedLayout(
                        orientation: LayoutOrientation.horizontal,
                        primaryAxisAlignItems: LayoutAlign.space_between,
                        counterAxisAlignItems: LayoutAlign.center,
                        diameter: 52,
                        padding: [0, 0, 0, 0],
                        itemSpacing: 0,
                        children: [
                          {
                            52: GestureDetector(
                              onTap: () {
                                navigatorGrandKey.currentState!.pop();
                              },
                              child: SvgPicture.asset('assets/goback.svg'),
                            )
                          },
                          {
                            187: MinDiameterSupport(
                                diameter: text.length > 1 ? 52 : 33,
                                length: 187,
                                maximumDiameter: 52,
                                orientation: LayoutOrientation.horizontal,
                                primaryAxisAlignItems:
                                    LayoutAlign.space_between,
                                counterAxisAlignItems: LayoutAlign.center,
                                child: LayoutText(text.join("\n"),
                                textAlign: TextAlign.center,
                                removeLines: false,
                                    style: TextStyle(
                                        height: 1.375,
                                        fontFamily: 'DM Serif Display')))
                          },
                          {
                            52: GestureDetector(
                                onTap: () {
                                  notifier.recipeComment(notifier.routeArgs['recipeId'], notifier.session?.user?.id.toString() ?? '', globalCommentEntryEditingController.text);
                                  Future.delayed(Duration(milliseconds: 300), () {
                                    globalCommentEntryEditingController.clear();
                                    notifier.routeArgs["CONTENT"] = notifier.recipeCommentByRecipe(notifier.routeArgs["recipeId"]);
                                  });
                                  notifier.routeArgs["route"] = "comments_section";
                                  notifier.routeArgs["msg"] = "one last check";

                                  navigatorGrandKey.currentState! 
                                      .pushNamedAndRemoveUntil(
                                          "loading", (route) => false,
                                          arguments: notifier.routeArgs);
                                },
                                child: SvgPicture.asset('assets/send.svg'))
                          }
                        ])
                  }
                ]),
          ),
        ),
      ),
    );
  }

 
}

