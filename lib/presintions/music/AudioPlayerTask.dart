// import 'package:audio_service/audio_service.dart';
// import 'package:just_audio/just_audio.dart';
//
// class AudioPlayerTask extends BackgroundAudioTask {
//   final _audioPlayer = AudioPlayer();
//
//   @override
//   Future<void> onStart(Map<String, dynamic>? params) async {
//     // Set the audio source
//     final audioUrl = 'https://firebasestorage.googleapis.com/v0/b/online-books-1c0e0.appspot.com/o/audio%2FAtomic%20Habits%201-qism%20%23Atomodatlar%23Atomic_habits.mp3?alt=media&token=9ba75c19-d4e1-480a-a9e8-0f7dfdd95fd9';
//     await _audioPlayer.setUrl(audioUrl);
//
//     // Play the audio
//     _audioPlayer.play();
//
//     // Broadcast the state to the UI
//     _audioPlayer.positionStream.listen((position) {
//       AudioServiceBackground.setState(
//         controls: [MediaControl.pause],
//         position: position,
//         processingState: AudioProcessingState.ready,
//       );
//     });
//   }
//
//   @override
//   Future<void> onStop() async {
//     await _audioPlayer.stop();
//     await _audioPlayer.dispose();
//     await super.onStop();
//   }
//
//   @override
//   Future<void> onPause() async {
//     await _audioPlayer.pause();
//     AudioServiceBackground.setState(
//       controls: [MediaControl.play],
//       processingState: AudioProcessingState.ready,
//     );
//   }
//
//   @override
//   Future<void> onPlay() async {
//     await _audioPlayer.play();
//     AudioServiceBackground.setState(
//       controls: [MediaControl.pause],
//       processingState: AudioProcessingState.ready,
//     );
//   }
//
//   @override
//   Future<void> onSeekTo(Duration position) async {
//     await _audioPlayer.seek(position);
//   }
// }
