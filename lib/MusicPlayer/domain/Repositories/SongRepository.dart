import 'package:dartz/dartz.dart';
import 'package:flutter_b_sm/MusicPlayer/domain/Entities/SongEntity.dart';
import '../../core/errors/failures.dart';
import '../../data/DataSource/LocalSongDataSource.dart';

abstract class MusicPlayerRepository {
  Future<Either<Failure, List<Song>>> getSongs();
 // Future<Either<Failure, bool>> requestPermissions();
}


class MusicPlayerRepositoryImpl implements MusicPlayerRepository {
  final MusicPlayerLocalDataSource localDataSource;

  MusicPlayerRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, List<Song>>> getSongs() async {
    try {
      final result = await localDataSource.getSongs();
      return result;
    } catch (e) {
      return Left(CacheFailure('Failed to get songs: ${e.toString()}'));
    }
  }

  // @override
  // Future<Either<Failure, bool>> requestPermissions() async {
  //   try {
  //     final result = await localDataSource.requestPermissions();
  //     return result;
  //   } catch (e) {
  //     return Left(PermissionFailure('Failed to request permissions: ${e.toString()}'));
  //   }
  // }
}