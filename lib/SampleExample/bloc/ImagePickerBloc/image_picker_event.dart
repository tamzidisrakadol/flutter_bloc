part of 'image_picker_bloc.dart';

@immutable
sealed class ImagePickerEvent {}

class CaptureImage extends ImagePickerEvent{}
class GalleryImage extends ImagePickerEvent{}

