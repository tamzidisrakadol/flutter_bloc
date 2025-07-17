import 'package:dartz/dartz.dart';
import 'package:flutter_b_sm/MusicPlayer/core/errors/failures.dart';
import '../Entities/SongEntity.dart';
import '../Repositories/SongRepository.dart';

class GetSongs {
  final MusicPlayerRepository repository;

  GetSongs(this.repository);

  Future<Either<Failure, List<Song>>> call() async {
    return await repository.getSongs();
  }
}