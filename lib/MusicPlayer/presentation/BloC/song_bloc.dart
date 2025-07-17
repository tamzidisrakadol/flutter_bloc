import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_b_sm/MusicPlayer/domain/Repositories/SongRepository.dart';
import 'package:meta/meta.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../domain/Entities/SongEntity.dart';
import '../../domain/UseCase/GetLocalSongs.dart';
import '../../domain/UseCase/RequestPermissions.dart';

part 'song_event.dart';
part 'song_state.dart';

class MusicPlayerBloc extends Bloc<MusicPlayerEvent, MusicPlayerState> {
  final GetSongs getSongs;
//  final RequestPermissions requestPermissions;

  MusicPlayerBloc({
    required this.getSongs,
   // required this.requestPermissions,
  }) : super(MusicPlayerInitial()) {
    on<LoadSongsEvent>(_onLoadSongs);
  //  on<RequestPermissionsEvent>(_onRequestPermissions);
  }

  Future<void> _onLoadSongs(
      LoadSongsEvent event,
      Emitter<MusicPlayerState> emit,
      ) async {
    emit(MusicPlayerLoading());
    final result = await getSongs();
    result.fold(
          (failure) => emit(MusicPlayerError(failure.message)),
          (songs) => emit(MusicPlayerLoaded(songs)),
    );
  }


  // Future<void> _onRequestPermissions(
  //     RequestPermissionsEvent event,
  //     Emitter<MusicPlayerState> emit,
  //     ) async {
  //   emit(MusicPlayerLoading());
  //   final result = await requestPermissions();
  //   result.fold(
  //         (failure) => emit(MusicPlayerPermissionError(failure.message)),
  //         (_) => add(LoadSongsEvent()),
  //   );
  // }
}