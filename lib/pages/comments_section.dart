import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:platter/change_notifiers/AppStatusNotifier.dart';
import 'package:platter/layout.dart';
import 'package:platter/layout_text.dart';
import 'package:platter/mobile_constants.dart';
import 'package:platter/models/RecipeComments.dart';
import 'package:platter/models/RecipeLikesByUser.dart';
import 'package:provider/provider.dart';
import 'package:textwrap/textwrap.dart';

class CommentsSection extends StatefulWidget {
  const CommentsSection({super.key});

  @override
  State<CommentsSection> createState() => _CommentsSectionState();
}

class _CommentsSectionState extends State<CommentsSection> {
  late AppStatusNotifier notifier =
      Provider.of<AppStatusNotifier>(context, listen: false);
  List<RecipeComments> content = [];

  String URL = '';
  listener() {
    if (notifier.listdata(URL).isNotEmpty) {
      setState(() {
        content = recipeCommentsFromJsonB(notifier.listdata(URL));
      });
      notifier.removeListener(listener);
    }
  }

  @override
  void initState() {
    URL = notifier.routeArgs['CONTENT'];
    
    listener();
    
    notifier.addListener(listener);

    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    notifier.removeListener(listener);
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var iterable = content.length > 0
                    ? (content[0].users?.values ?? [])
                    : [];
    return SingleChildScrollView(
      child: AspectRatio(
          aspectRatio: 363.75 / (600 + (iterable.length * 150)),
          child: OrientedLayout(
              orientation: LayoutOrientation.vertical,
              primaryAxisAlignItems: LayoutAlign.min,
              counterAxisAlignItems: LayoutAlign.min,
              diameter: 363.75,
              padding: [20, 0, 20, 0],
              itemSpacing: 0,
              children: [
                SafeArea(child: SizedBox.shrink()),
                {
                  (27 * 0.75): OrientedLayout(
                      orientation: LayoutOrientation.horizontal,
                      primaryAxisAlignItems: LayoutAlign.space_between,
                      counterAxisAlignItems: LayoutAlign.center,
                      diameter: 27 * 0.75,
                      padding: [15, 0, 15, 0],
                      itemSpacing: 0,
                      children: [
                        {
                          100: LayoutText('9 comments',
                              style: TextStyle(
                                  height: 27 / 22, fontFamily: 'Inter'))
                        },
                        {
                          160: LayoutText('sort by: most recent',
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                  height: 27 / 22, fontFamily: 'Inter'))
                        }
                      ])
                },
                {
                  16: DecoratedBox(
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  width: 2, color: Color(0xFFE0CFCF)))))
                },
                for (String a in iterable)
                  {
                    (64) +
                            EvenComment.estimatedHeight(
                                 a.split(':')?[2] ?? 'empty'):
                        EvenComment(
                            profileImg:
                                'https://images.pexels.com/photos/17102047/pexels-photo-17102047/free-photo-of-couple-kissing-son-on-field.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
                            commentText:
                                a.split(':')?[2] ?? 'empty',
                            author: a.split(':')?[1] ?? 'empty')
                  },
              
              ])),
    );
  }
}

class EvenComment extends StatelessWidget {
  const EvenComment({
    super.key,
    required this.profileImg,
    required this.commentText,
    required this.author,
    this.odd = false,
  });

  final bool odd;

  final String profileImg;
  final String commentText;
  final String author;

  static estimatedHeight(String commentText, {bool odd = false}) {
    var wrap2 = wrap(commentText, width: 24);
    var length = wrap2.length;
    return ((length < 4 ? 4 : length + 1) * 27) + (odd ? 7.5 : 0);
  }

  @override
  Widget build(BuildContext context) {
    var wrap2 = wrap(commentText, width: 24);
    var l = wrap2.length < 4 ? 4 : (wrap2.length + 1);
    var h = (169 - 135) + estimatedHeight(commentText);

    return DecoratedBox(
        decoration: BoxDecoration(
            border:
                Border(bottom: BorderSide(width: 2, color: Color(0xFFE0CFCF)))),
        child: OrientedLayout(
            orientation: LayoutOrientation.vertical,
            primaryAxisAlignItems: LayoutAlign.min,
            counterAxisAlignItems: LayoutAlign.min,
            diameter: 323.75,
            padding: [15, odd ? 21.75 : 18, 2, odd ? 21.75 : 18.75],
            itemSpacing: 10,
            children: [
              {
                h: OrientedLayout(
                    orientation: LayoutOrientation.horizontal,
                    primaryAxisAlignItems: LayoutAlign.min,
                    counterAxisAlignItems: LayoutAlign.min,
                    diameter: h,
                    padding: [0, 0, 0, 0],
                    itemSpacing: 11,
                    children: [
                      {
                        107.887939453125: MinDiameterSupport(
                            diameter: 108,
                            length: 107.887939453125,
                            maximumDiameter: h,
                            orientation: LayoutOrientation.horizontal,
                            primaryAxisAlignItems: LayoutAlign.min,
                            counterAxisAlignItems: LayoutAlign.min,
                            child: DecoratedBox(
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(profileImg)))))
                      },
                      {
                        187.862060546875: OrientedLayout(
                            orientation: LayoutOrientation.vertical,
                            primaryAxisAlignItems: LayoutAlign.min,
                            counterAxisAlignItems: LayoutAlign.min,
                            diameter: 187.862060546875,
                            padding: [0, 0, 0, 0],
                            itemSpacing: 5,
                            children: [
                              {
                                estimatedHeight(commentText): LayoutText(
                                    wrap2.join("\n"),
                                    idtext: 'e\n' * l,
                                    removeLines: true,
                                    // maxLines: l,
                                    style: TextStyle(
                                        height: 27 / 22, fontFamily: 'Inter'))
                              },
                              {
                                29: LayoutText(author,
                                    style: TextStyle(
                                        height: 29 / 22,
                                        color: Color(0xFF5EC9F8),
                                        fontFamily: 'DM Sans',
                                        fontWeight: FontWeight.bold))
                              }
                            ])
                      }
                    ])
              }
            ]));
  }
}
