part of 'song_bloc.dart';

abstract class MusicPlayerEvent extends Equatable {
  const MusicPlayerEvent();

  @override
  List<Object> get props => [];
}

class LoadSongsEvent extends MusicPlayerEvent {}

class RequestPermissionsEvent extends MusicPlayerEvent {}
