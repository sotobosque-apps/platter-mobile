import 'package:flutter/material.dart';
import 'package:platter/layout.dart';
import 'package:platter/layout_text.dart';
import 'package:platter/mobile_constants.dart';

class ProductMatches extends StatelessWidget {
  const ProductMatches({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: AspectRatio(
          aspectRatio: 485 / 1400,
          child: OrientedLayout(
              orientation: LayoutOrientation.vertical,
              primaryAxisAlignItems: LayoutAlign.min,
              counterAxisAlignItems: LayoutAlign.min,
              diameter: 364.5,
              padding: [32, 0, 33, 0],
              itemSpacing: 0,
              children: [
                SafeArea(child: SizedBox.shrink()),
                {41: antiwhite},
                {
                31: LayoutText('Product matches', style: TextStyle(fontFamily: 'DM Sans', fontWeight: FontWeight.bold, height:31 / 24 ))
                },
                {17: DecoratedBox(decoration: BoxDecoration())},
                {
                  16: LayoutText(
                      'All available at amazon. this is affiliated sourced content.',
                      style: TextStyle(fontFamily: 'DM Sans', height: 16 / 12))
                },
                {25: DecoratedBox(decoration: BoxDecoration())},
                {
                  168: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: OrientedLayout(
                      orientation: LayoutOrientation.horizontal,
                      primaryAxisAlignItems: LayoutAlign.min,
                      counterAxisAlignItems: LayoutAlign.min,
                      diameter: 168,
                      padding: [0, 0, 0, 0],
                      itemSpacing: 48,
                      children: [
                        {
                          130: ProductMatch(text: 'Cuisinart 7-Piece Cookware Set, Chef\'s Classic', url: 'https://m.media-amazon.com/images/I/71LCov736wL._AC_SL1500_.jpg')
                        },
                         {
                          130: ProductMatch(text: 'Cuisinart 7-Piece Cookware Set, Chef\'s Classic', url: 'https://m.media-amazon.com/images/I/71LCov736wL._AC_SL1500_.jpg')
                        },
                         {
                          130: ProductMatch(text: 'Cuisinart 7-Piece Cookware Set, Chef\'s Classic', url: 'https://m.media-amazon.com/images/I/71LCov736wL._AC_SL1500_.jpg')
                        },
                      ]),)
                },
                {54: DecoratedBox(decoration: BoxDecoration())},
                {31: DecoratedBox(decoration: BoxDecoration())},
                {
                  168: SingleChildScrollView(scrollDirection: Axis.horizontal,child: OrientedLayout(
                      orientation: LayoutOrientation.horizontal,
                      primaryAxisAlignItems: LayoutAlign.min,
                      counterAxisAlignItems: LayoutAlign.min,
                      diameter: 168,
                      padding: [0, 0, 0, 0],
                      itemSpacing: 48,
                      children: [
                         {
                          130: ProductMatch(text: 'Cuisinart 7-Piece Cookware Set, Chef\'s Classic', url: 'https://m.media-amazon.com/images/I/71LCov736wL._AC_SL1500_.jpg')
                        },
                         {
                          130: ProductMatch(text: 'Cuisinart 7-Piece Cookware Set, Chef\'s Classic', url: 'https://m.media-amazon.com/images/I/71LCov736wL._AC_SL1500_.jpg')
                        },
                         {
                          130: ProductMatch(text: 'Cuisinart 7-Piece Cookware Set, Chef\'s Classic', url: 'https://m.media-amazon.com/images/I/71LCov736wL._AC_SL1500_.jpg')
                        },
                      ]),)
                },
                {54: DecoratedBox(decoration: BoxDecoration())},
                {31: DecoratedBox(decoration: BoxDecoration())},
                {
                  168:SingleChildScrollView( 
                    scrollDirection: Axis.horizontal,
                    child:OrientedLayout(
                      orientation: LayoutOrientation.horizontal,
                      primaryAxisAlignItems: LayoutAlign.min,
                      counterAxisAlignItems: LayoutAlign.min,
                      diameter: 168,
                      padding: [0, 0, 0, 0],
                      itemSpacing: 48,
                      children: [
                         {
                          130: ProductMatch(text: 'Cuisinart 7-Piece Cookware Set, Chef\'s Classic', url: 'https://m.media-amazon.com/images/I/71LCov736wL._AC_SL1500_.jpg')
                        },
                         {
                          130: ProductMatch(text: 'Cuisinart 7-Piece Cookware Set, Chef\'s Classic', url: 'https://m.media-amazon.com/images/I/71LCov736wL._AC_SL1500_.jpg')
                        },
                         {
                          130: ProductMatch(text: 'Cuisinart 7-Piece Cookware Set, Chef\'s Classic', url: 'https://m.media-amazon.com/images/I/71LCov736wL._AC_SL1500_.jpg')
                        },
                      ]))
                },
                {54: DecoratedBox(decoration: BoxDecoration())}
              ])),
    );
  }
}

class ProductMatch extends StatelessWidget {
  const ProductMatch({
    super.key,
    required this.text,
    required this.url,
  });

  final String text;
  final String url;

  @override
  Widget build(BuildContext context) {
    return OrientedLayout(
        orientation: LayoutOrientation.vertical,
        primaryAxisAlignItems: LayoutAlign.min,
        counterAxisAlignItems: LayoutAlign.center,
        diameter: 130,
        padding: [0, 0, 0, 0],
        itemSpacing: 15,
        children: [
          {
            51: LayoutText(
                text,
                idtext: 'e\ne\ne',
                style: TextStyle(fontFamily: 'Noto Serif HK', height: 17/12 ))
          },
          {102: DecoratedBox(decoration: BoxDecoration(image: DecorationImage(image: NetworkImage(url))))}
        ]);
  }
}
