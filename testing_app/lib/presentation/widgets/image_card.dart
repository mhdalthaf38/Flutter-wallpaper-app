import 'package:flutter/material.dart';
import 'package:testing_app/models/photo_model.dart';
import 'package:testing_app/presentation/screens/main/image_view_screen.dart';


class ImageCard extends StatelessWidget {
  final PhotoModel photo;
  const ImageCard({required this.photo});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => ImageViewScreen(photo: photo)),
      ),
      child: Card(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(photo.src, fit: BoxFit.cover),
        ),
      ),
    );
  }
}
