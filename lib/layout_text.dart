import 'package:flutter/material.dart';
import 'package:memoized/memoized.dart';

double Function(TextSpan text, double maxHeight, double maxWidth)
    recursiveFontSizeCheck = Memoized3<double, TextSpan, double, double>(
        (TextSpan text, double maxHeight, double maxWidth) {
  TextSpan nextSpan = TextSpan(
      text: text.text,
      style:
          text.style?.copyWith(fontSize: (text.style!.fontSize ?? 12) + 0.05));

  final multilineTextPainter =
      TextPainter(textDirection: TextDirection.ltr, text: nextSpan);

  multilineTextPainter.layout(maxWidth: maxWidth);

  if (maxHeight < multilineTextPainter.height) {
    return nextSpan.style!.fontSize! - 0.05;
  } else {
    return recursiveFontSizeCheck(nextSpan, maxHeight, maxWidth);
  }
});

List<double> Function(TextSpan text, BoxConstraints constraints)
    returnBoundedProportion = Memoized2<List<double>, TextSpan, BoxConstraints>(
        (TextSpan text, BoxConstraints constraints) {
  final singleLineTextPainter =
      TextPainter(textDirection: TextDirection.ltr, text: text, maxLines: 1);

  final multilineTextPainter =
      TextPainter(textDirection: TextDirection.ltr, text: text);

  singleLineTextPainter.layout(maxWidth: constraints.maxWidth);
  multilineTextPainter.layout(maxWidth: constraints.maxWidth);

  var fontSize = recursiveFontSizeCheck(
      text,
      constraints.minHeight > 0 ? constraints.minHeight : constraints.maxHeight,
      constraints.maxWidth);

  return [
    fontSize,
    singleLineTextPainter.height,
    (text.text?.split('\n').length ?? 1).toDouble()
  ];
});

Memoized2<Paint, BoxConstraints, Gradient> textLayoutShader = Memoized2<
    Paint,
    BoxConstraints,
    Gradient>((BoxConstraints constraints, Gradient gradient) => Paint()
  ..shader = gradient.createShader(
      Rect.fromLTWH(0, 0, constraints.maxWidth, constraints.maxHeight)));

class LayoutText extends StatelessWidget {
  final TextStyle style;
  final String text;
  final String? idtext;
  final double? postHeigth;
  final TextAlign? textAlign;
  final LinearGradient? gradient;
  final bool removeLines;
  final List<TextSpan>? children;
  final int? maxLines;
  // ex 0.5;
  final double? letterSpacing;

  const LayoutText(this.text,
      {super.key,
      required this.style,
      this.textAlign,
      this.letterSpacing,
      this.postHeigth,
      this.idtext,
      this.gradient,
      this.removeLines = true,
      this.children,
      this.maxLines});

  @override
  Widget build(BuildContext context) {
    const a = 10;

    const Map<String, double> scaleExceptions = {
      "breakfast\nsmoothie": 1,
      "26℃": 1,
      "Weather": 1,
      'For this heat': 1,
      "Find it now: Search simplified!": 1,
      "Explore, Discover, and Find what you\'re looking for faster than ever!  Start your search journey now and unlock a world of possibilities. Dive  in and let\'s find what matters most to you!":
          1
      // "A Great Smoothie": 1,
    };

    final TextSpan textWidget = TextSpan(
      text: idtext ?? text,
      style: style.copyWith(
        fontSize: style.fontSize ?? 10,
        shadows: style.shadows != null
            ? [
                ...style.shadows!,
                const BoxShadow(
                  offset: Offset(0, 1),
                  blurRadius: 6,
                  color: Color.fromARGB(a, 26, 30, 255),
                ),
                const BoxShadow(
                  offset: Offset(0, -1),
                  blurRadius: 6,
                  color: Color.fromARGB(a, 83, 255, 26),
                ),
              ]
            : [
                const BoxShadow(
                  offset: Offset(0, 1),
                  blurRadius: 6,
                  color: Color.fromARGB(a, 26, 30, 255),
                ),
                const BoxShadow(
                  offset: Offset(0, -1),
                  blurRadius: 6,
                  color: Color.fromARGB(a, 83, 255, 26),
                ),
              ],
      ),
    );
    List<double>? renderedResults;

    return LayoutBuilder(
      builder: (context, constraints) {
        // const a = 150;
        double fontSize = 0;
        Paint? foreground2;
        if (renderedResults == null) {
          renderedResults = returnBoundedProportion(textWidget!, constraints);
          fontSize = (renderedResults?[0] ?? 16);
          // print("$fontSize, $text");
          foreground2 = (gradient != null)
              ? textLayoutShader(constraints, gradient!)
              : null;
        } else {}
        return RichText(
          textHeightBehavior: const TextHeightBehavior(
              applyHeightToFirstAscent: false, applyHeightToLastDescent: false),
          textAlign: textAlign ?? TextAlign.start,
          overflow: TextOverflow.visible,
          maxLines: maxLines,
          text: TextSpan(
              text: removeLines ? (text.replaceAll("\n", " ")) : text,
              style: (gradient != null)
                  ? textWidget!.style!.copyWith(
                      letterSpacing: letterSpacing != null
                          ? letterSpacing! * fontSize
                          : null,
                      fontSize: fontSize,
                      decorationColor: style.decorationColor ??
                          (gradient?.colors.last ??
                              (style.color ?? Colors.yellow)),
                      foreground: foreground2,
                      height: postHeigth)
                  : textWidget!.style!.copyWith(
                      letterSpacing: letterSpacing != null
                          ? letterSpacing! * fontSize
                          : null,
                      fontSize: fontSize,
                      height: postHeigth,
                      color: textWidget!.style!.color ?? Colors.black),
              children: children),
          textScaler: TextScaler.linear(scaleExceptions[idtext] ?? 1),
        );
      },
    );
  }
}

class LayoutTextInput extends StatelessWidget {
  final TextStyle style;
  final String text;
  final String? idtext;
  final TextAlign? textAlign;
  final LinearGradient? gradient;
  final bool removeLines;
  final Function(String v)? onSubmit;
  final List<TextSpan>? children;
  final int? maxLines;
  final double? postHeigth;
  final double? postFontSize;
  final int? minLines;
  final EdgeInsets edgeInsets;
  final double? letterSpacing;
  final TextEditingController? textEditingController;
  final TextInputAction action;
  final String group;

  const LayoutTextInput(this.text,
      {super.key,
      required this.style,
      this.onSubmit,
      this.group = "",
      this.action = TextInputAction.go,
      this.edgeInsets = const EdgeInsets.all(0),
      this.textAlign,
      this.letterSpacing,
      this.postFontSize,
      this.idtext,
      this.gradient,
      this.minLines,
      this.postHeigth,
      this.textEditingController,
      this.removeLines = true,
      this.children,
      this.maxLines});

  @override
  Widget build(BuildContext context) {
    const a = 10;
    final TextSpan textWidget = TextSpan(
      text: idtext ?? text,
      style: style.copyWith(
        fontSize: style.fontSize ?? 12,
        shadows: style.shadows != null
            ? [
                ...style.shadows!,
                const BoxShadow(
                  offset: Offset(0, 1),
                  blurRadius: 6,
                  color: Color.fromARGB(a, 26, 30, 255),
                ),
                const BoxShadow(
                  offset: Offset(0, -1),
                  blurRadius: 6,
                  color: Color.fromARGB(a, 83, 255, 26),
                ),
              ]
            : [
                const BoxShadow(
                  offset: Offset(0, 1),
                  blurRadius: 6,
                  color: Color.fromARGB(a, 26, 30, 255),
                ),
                const BoxShadow(
                  offset: Offset(0, -1),
                  blurRadius: 6,
                  color: Color.fromARGB(a, 83, 255, 26),
                ),
              ],
      ),
    );
    List<double>? renderedResults;
    return LayoutBuilder(
      builder: (context, constraints) {
        // const a = 150;
        double fontSize = 0;
        Paint? foreground2;
        if (renderedResults == null) {
          renderedResults = returnBoundedProportion(textWidget!, constraints);
          fontSize = renderedResults?[0] ?? 16;
          foreground2 = (gradient != null)
              ? textLayoutShader(constraints, gradient!)
              : null;
        } else {}

        if (postFontSize != null) {
          fontSize *= postFontSize!;
        }

        return TextField(
          onSubmitted: onSubmit,
          clipBehavior: Clip.hardEdge,
          maxLines: maxLines,
          minLines: minLines,
          textCapitalization: TextCapitalization.none,

          controller: textEditingController,
          scrollPadding: const EdgeInsets.all(0),
          // strutStyle: StrutStyle(fontSize: fontSize,
          // fontFamily: 'DM Sans',

          // ),

          keyboardType: TextInputType.multiline,
          // cursorHeight: 24,
          textAlign: textAlign ?? TextAlign.start,
          textInputAction: action,
          decoration: InputDecoration(
            contentPadding: edgeInsets,
            fillColor: const Color(0xFFFFFEFF),
            isDense: true,
            hintText: text,
            hintStyle: TextStyle(
              color: Color(0xFFA4A4A4),
              letterSpacing:
                  letterSpacing != null ? letterSpacing! * fontSize : null,
            ),
            border: InputBorder.none,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            labelText: '',
            isCollapsed: true,
            
            counterStyle: textWidget.style!
                .copyWith(fontSize: fontSize, letterSpacing: -1),
          ),
          style: (gradient != null)
              ? textWidget.style!.copyWith(
                  fontSize: fontSize,
                  decorationColor: style.decorationColor ??
                      (gradient?.colors.last ?? (style.color ?? Colors.yellow)),
                  foreground: foreground2,
                  letterSpacing:
                      letterSpacing != null ? letterSpacing! * fontSize : null,
                  height: postHeigth)
              : textWidget.style!.copyWith(
                  fontSize: fontSize,
                  height: postHeigth,
                  letterSpacing:
                      letterSpacing != null ? letterSpacing! * fontSize : null,
                ),
        );
        // return RichText(
        //   textHeightBehavior: const TextHeightBehavior(
        //       applyHeightToFirstAscent: false, applyHeightToLastDescent: false),
        //   textAlign: textAlign ?? TextAlign.start,
        //   overflow: TextOverflow.visible,
        //   maxLines: maxLines,
        //   text: TextSpan(
        //       text: removeLines ? (text.replaceAll("\n", " ")) : text,
        //       style: (gradient != null)
        //           ? textWidget.style!.copyWith(
        //               fontSize: fontSize,
        //               decorationColor: style.decorationColor ??
        //                   (gradient?.colors.last ??
        //                       (style.color ?? Colors.yellow)),
        //               foreground: foreground2,
        //             )
        //           : textWidget.style!.copyWith(
        //               fontSize: fontSize,
        //             ),
        //       children: children),
        // );
      },
    );
  }
}

// DEBUGGING PROPS
// print(
//     "constraints.maxHeight: ${constraints.maxHeight} textPainter.height: ${textPainter.height * (text.text?.split('\n').length ?? 1)}");
// print(
//     "textPainter.didExceedMaxLines: ${textPainter.didExceedMaxLines} ${text.text?.split('\n').length}");
// print(text.text);
// print(
// "does it fits :${(stylelineSize * letterSize) / (style.height ?? 1.2)}? ${_checkTextFits(textWidget, constraints)}");
