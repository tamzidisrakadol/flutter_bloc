part of 'song_bloc.dart';

abstract class MusicPlayerState extends Equatable {
  const MusicPlayerState();

  @override
  List<Object> get props => [];
}

class MusicPlayerInitial extends MusicPlayerState {}

class MusicPlayerLoading extends MusicPlayerState {}

class MusicPlayerLoaded extends MusicPlayerState {
  final List<Song> songs;

  const MusicPlayerLoaded(this.songs);

  @override
  List<Object> get props => [songs];
}

class MusicPlayerError extends MusicPlayerState {
  final String message;

  const MusicPlayerError(this.message);

  @override
  List<Object> get props => [message];
}

class MusicPlayerPermissionError extends MusicPlayerState {
  final String message;

  const MusicPlayerPermissionError(this.message);

  @override
  List<Object> get props => [message];
}