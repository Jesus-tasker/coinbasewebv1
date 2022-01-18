/*
//este funciona en app
import 'package:cache_audio_player/cache_audio_player.dart';

playLocalAsset() async {
  //cache_audio_player 1.0.0  es para online funciona pero no se como subir sonidos.. .
  //print("sonido reporoducior");

  final CacheAudioPlayer audioPlayer = CacheAudioPlayer();

//Always register listeners in order to receive updates from event channel.
  audioPlayer.registerListeners();

//Event channel callbacks:
  audioPlayer.onStateChanged.listen((AudioPlayerState state) {
    /* setState(() {
      //or do whatever you need to do with the new state
     _state = state;
  });*/
  });

  audioPlayer.onPlayerBuffered.listen((double percentageBuffered) {
    /* setState(() {
     _bufferedPercentage = percentageBuffered;
  });*/
  });

  audioPlayer.onTimeElapsed.listen((double timeInSeconds) {
/*  setState(() {
      _timeInSeconds = timeInSeconds;
   });*/
  });

  audioPlayer.onError.listen((Object error) {
    /* setState(() {
      _error = error;
  });*/
  });

  String sonido1 =
      "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3";
  var sonido2 =
      "https://drive.google.com/drive/u/0/folders/1FCupOuILwFToWre5okAwmw9n5s8Mc-rY";

//no fuicono con el url de descarga debe ser .mp3 en la red
  // String sonido_play ="http://www.sonidosmp3gratis.com/download.php?id=9650&sonido=golpe%20cerrar%20puerta";
  // audioPlayer.loadUrl("assets/yes.mp3"); //no funciona local
  audioPlayer.loadUrl("assets/yes.mp3");

  //chache2.seek(value)
  audioPlayer.play();

  // return await cache.play("yes.mp3");
}
*/
