import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';


@RoutePage()
class FullPhotoPage extends StatelessWidget {
  const FullPhotoPage({required this.imageUrl, super.key});
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: PhotoView(imageProvider: NetworkImage(imageUrl)));
  }
}