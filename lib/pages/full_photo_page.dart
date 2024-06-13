import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:suuq/utils/app_colors.dart';

@RoutePage()
class FullPhotoPage extends StatelessWidget {
  const FullPhotoPage({required this.imageUrl, super.key});
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.black,
          iconTheme: const IconThemeData(color: AppColors.white),
        ),
        body: PhotoView(imageProvider: NetworkImage(imageUrl)));
  }
}
