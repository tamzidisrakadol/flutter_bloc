import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

import '../Utils/ImagePickerUtils.dart';

part 'image_picker_event.dart';
part 'image_picker_state.dart';

class ImagePickerBloc extends Bloc<ImagePickerEvent, ImagePickerState> {
  final ImagePickerUtils imagePickerUtils;

  ImagePickerBloc(this.imagePickerUtils) : super(ImageInitial()) {
    on<CaptureImage>((event, emit) async{
      final XFile? file = await imagePickerUtils.captureImage();
      if(file != null){
        emit(ImagePickedSuccess(file));
      }else{
        emit(ImageInitial());
      }
    });

    on<GalleryImage>((event, emit) async{
      final XFile? file = await imagePickerUtils.galleryImage();
      if(file != null){
        emit(ImagePickedSuccess(file));
      }else{
        emit(ImageInitial());
      }
    });

  }

}
