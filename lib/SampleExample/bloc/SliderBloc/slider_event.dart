part of 'slider_bloc.dart';

@immutable
sealed class SliderEvent {}

class SliderValueChanged extends SliderEvent {
  final double newValue;
  SliderValueChanged(this.newValue);
}

