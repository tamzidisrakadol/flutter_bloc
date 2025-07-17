// import 'dart:io';
//
// import 'package:path/path.dart' as p;
//
// import '../../domain/Entities/SongEntity.dart';
//
// class SongModel {
//   final String id;
//   final String title;
//   final String path;
//
//   SongModel({
//     required this.id,
//     required this.title,
//     required this.path,
//   });
//
//   factory SongModel.fromFile(File file) {
//     return SongModel(
//       id: file.path.hashCode.toString(),
//       title: p.basename(file.path),
//       path: file.path,
//     );
//   }
//
//   SongEntity toEntity() {
//     return SongEntity(
//       title: title,
//       path: path,
//       duration: Duration(),
//     );
//   }
// }