import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing_app/core/services/pixels_api_services.dart';
import 'package:testing_app/models/photo_model.dart';
import 'photo_event.dart';
import 'photo_state.dart';

class PhotoBloc extends Bloc<PhotoEvent, PhotoState> {
  final PexelsApiService _apiService;
  List<PhotoModel> _photos = [];
  int _page = 1;

  PhotoBloc(this._apiService) : super(PhotoInitial()) {
    on<FetchPhotos>(_onFetchPhotos);
  }

  Future<void> _onFetchPhotos(FetchPhotos event, Emitter<PhotoState> emit) async {
    if (state is PhotoLoading) return;

    emit(PhotoLoading());
    try {
      final newPhotos = await _apiService.fetchPhotos(_page);
      _photos.addAll(newPhotos);
      _page++;
      emit(PhotoLoaded(List.from(_photos)));
    } catch (e) {
      emit(PhotoError("Failed to load photos"));
    }
  }
}
