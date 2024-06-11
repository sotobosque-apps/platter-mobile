import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:platter/change_notifiers/AppStatusNotifier.dart';
import 'package:provider/provider.dart';

class galleryView extends StatefulWidget {
  const galleryView({super.key});

  @override
  State<galleryView> createState() => _galleryViewState();
}

class _galleryViewState extends State<galleryView> {
  late final AppStatusNotifier notifier =
        Provider.of<AppStatusNotifier>(context, listen: true);

  @override
  Widget build(BuildContext context) {
    
    print(notifier.routeArgs?["CONTENT"]);
    return Container(
        color: Colors.black,
        child: PhotoViewGallery.builder(
          scrollPhysics: const BouncingScrollPhysics(),
          builder: (BuildContext context, int index) {
            return PhotoViewGalleryPageOptions(
              imageProvider: NetworkImage(
                  (notifier.routeArgs?["CONTENT"] ?? [])[index] ?? ''),
              initialScale: PhotoViewComputedScale.contained * 0.8,
            );
          },
          itemCount: notifier.routeArgs["CONTENT"]?.length ?? 0,
          loadingBuilder: (context, event) => Center(
            child: Container(
              width: 20.0,
              height: 20.0,
              child: CircularProgressIndicator(
                value: event == null
                    ? 0
                    : event.cumulativeBytesLoaded /
                        (event.expectedTotalBytes ?? 1),
              ),
            ),
          ),
          backgroundDecoration: BoxDecoration(color: Colors.black),
          // pageController:
          //     widget.pageController,
          // onPageChanged:
          //     onPageChanged,
        ));
  }
}
