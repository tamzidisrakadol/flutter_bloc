part of 'image_picker_bloc.dart';

abstract class ImagePickerState {}

class ImageInitial extends ImagePickerState {}

class ImagePickedSuccess extends ImagePickerState {
  final XFile image;
  ImagePickedSuccess(this.image);
}

class ImagePickedFailure extends ImagePickerState {
  final String error;
  ImagePickedFailure(this.error);
}