import 'package:equatable/equatable.dart';
import 'package:testing_app/models/photo_model.dart';

abstract class PhotoState extends Equatable {
  @override
  List<Object> get props => [];
}

class PhotoInitial extends PhotoState {}

class PhotoLoading extends PhotoState {}

class PhotoLoaded extends PhotoState {
  final List<PhotoModel> photos;
  PhotoLoaded(this.photos);

  @override
  List<Object> get props => [photos];
}

class PhotoError extends PhotoState {
  final String message;
  PhotoError(this.message);

  @override
  List<Object> get props => [message];
}
