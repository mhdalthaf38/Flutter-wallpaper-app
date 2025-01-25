import 'package:equatable/equatable.dart';
import 'package:testing_app/models/photo_model.dart';

abstract class PhotoState{

}

class PhotoInitial extends PhotoState {}

class PhotoLoading extends PhotoState {}

class PhotoLoaded extends PhotoState {
  final List<PhotoModel> photos;
  PhotoLoaded(this.photos);

 
}

class PhotoError extends PhotoState {
  final String message;
  PhotoError(this.message);


}
class DownloadedImage extends PhotoState {
  final String imagePath;
  DownloadedImage(this.imagePath);
}
class DownloadError extends PhotoState {
  final String errorMessage;
  DownloadError(this.errorMessage);
}
