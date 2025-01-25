import 'package:equatable/equatable.dart';

abstract class PhotoEvent {
}

class FetchPhotos extends PhotoEvent {}
class downloadImage extends PhotoEvent {
  final dynamic photo;
  final dynamic context;
  downloadImage(this.photo, this.context);
}