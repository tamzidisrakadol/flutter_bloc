import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'slider_event.dart';
part 'slider_state.dart';


class SliderBloc extends Bloc<SliderEvent, SliderInitial> {
  SliderBloc() : super(SliderInitial(0.0)) {
    on<SliderValueChanged>((event, emit) {
      emit(SliderInitial(event.newValue));
    });
  }
}