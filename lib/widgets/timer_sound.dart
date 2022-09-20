import 'package:audioplayers/audioplayers.dart';

class TimerSound {
  Future playSound() async {
    const String dingUrl =
        'https://www.youtube.com/watch?v=qZC5gtOw3DU&ab_channel=RyanCarvalho';
    final player = AudioPlayer();
    return await player.play(UrlSource(dingUrl));
  }
}
