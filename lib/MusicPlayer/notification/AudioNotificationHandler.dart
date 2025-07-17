// import 'package:audio_service/audio_service.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:just_audio/just_audio.dart';
// import 'package:rxdart/rxdart.dart';
//
// class AudioNotificationHandler extends BaseAudioHandler {
//   final _player = AudioPlayer();
//   final _playlist = ConcatenatingAudioSource(children: []);
//   final _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//
//   AudioNotificationHandler() {
//     _init();
//   }
//
//   Future<void> _init() async {
//     await _initNotifications();
//
//     _player.playbackEventStream.map(_transformEvent).pipe(playbackState);
//     mediaItem.add(null);
//
//     _player.currentIndexStream.listen((index) {
//       if (index != null) {
//         // Update media item when track changes
//       }
//     });
//   }
//
//   Future<void> _initNotifications() async {
//     const AndroidInitializationSettings initializationSettingsAndroid =
//     AndroidInitializationSettings('app_icon');
//
//     final InitializationSettings initializationSettings =
//     InitializationSettings(android: initializationSettingsAndroid);
//
//     await _flutterLocalNotificationsPlugin.initialize(
//       initializationSettings,
//     );
//   }
//
//   PlaybackState _transformEvent(PlaybackEvent event) {
//     return PlaybackState(
//       controls: [
//         MediaControl.skipToPrevious,
//         if (_player.playing) MediaControl.pause else MediaControl.play,
//         MediaControl.skipToNext,
//       ],
//       systemActions: const {
//         MediaAction.seek,
//         MediaAction.seekForward,
//         MediaAction.seekBackward,
//       },
//       androidCompactActionIndices: const [0, 1, 2],
//       processingState: const {
//         ProcessingState.idle: AudioProcessingState.idle,
//         ProcessingState.loading: AudioProcessingState.loading,
//         ProcessingState.buffering: AudioProcessingState.buffering,
//         ProcessingState.ready: AudioProcessingState.ready,
//         ProcessingState.completed: AudioProcessingState.completed,
//       }[_player.processingState]!,
//       playing: _player.playing,
//       updatePosition: _player.position,
//       bufferedPosition: _player.bufferedPosition,
//       speed: _player.speed,
//       queueIndex: event.currentIndex,
//     );
//   }
//
//   @override
//   Future<void> play() => _player.play();
//
//   @override
//   Future<void> pause() => _player.pause();
//
//   @override
//   Future<void> skipToNext() => _player.seekToNext();
//
//   @override
//   Future<void> skipToPrevious() => _player.seekToPrevious();
//
//   @override
//   Future<void> seek(Duration position) => _player.seek(position);
//
//   @override
//   Future<void> stop() async {
//     await _player.stop();
//     return super.stop();
//   }
// }