import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_b_sm/MusicPlayer/data/Model/SongModel.dart';
import 'package:flutter_b_sm/MusicPlayer/domain/Entities/SongEntity.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../core/errors/failures.dart';


abstract class MusicPlayerLocalDataSource {
  Future<Either<Failure, List<Song>>> getSongs();
 // Future<Either<Failure, bool>> requestPermissions();
}

class MusicPlayerLocalDataSourceImpl implements MusicPlayerLocalDataSource {

  @override
  Future<Either<Failure, List<Song>>> getSongs() async {
    try {

      final externalDir = await getExternalStorageDirectory();
      if (externalDir == null) {
        return Left(CacheFailure('No external storage found'));
      }

      final musicDir = Directory('/storage/emulated/0/snaptube/download/SnapTube Audio');
      if (!await musicDir.exists()) {
        return const Right([]);
      }

      final files = await musicDir.list().where((file) {
        final ext = p.extension(file.path).toLowerCase();
        return ext == '.mp3' || ext == '.wav' || ext == '.m4a';
      }).toList();

      final songs = await Future.wait(files.map((file) async {
        final stat = await file.stat();
        return Song(
          id: file.path,
          title: p.basenameWithoutExtension(file.path),
          artist: 'Unknown',
          album: 'Unknown',
          path: file.path,
          duration: Duration.zero, // You might want to extract this from metadata
        );
      }));

      return Right(songs);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  // @override
  // Future<Either<Failure, bool>> requestPermissions() async {
  //   try {
  //     // Check Android version and request appropriate permissions
  //     Permission permission;
  //     if (await Permission.storage.isRestricted) {
  //       permission = Permission.manageExternalStorage;
  //     } else {
  //       permission = Permission.storage;
  //     }
  //
  //     // Request permission
  //     final status = await permission.request();
  //
  //     // Handle the permission status
  //     if (status.isGranted) {
  //       return const Right(true);
  //     } else if (status.isPermanentlyDenied) {
  //       // Open app settings if permission is permanently denied
  //       await openAppSettings();
  //       return Left(PermissionFailure(
  //           'Permission permanently denied. Please enable storage access in app settings.'));
  //     } else {
  //       return Left(PermissionFailure('Storage permission not granted'));
  //     }
  //   } catch (e) {
  //     return Left(PermissionFailure('Permission request failed: ${e.toString()}'));
  //   }
  // }
}