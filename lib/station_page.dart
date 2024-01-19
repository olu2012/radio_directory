import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:radio_streaming_app/model/radio_station.dart';

class StationPage extends StatefulWidget {
final Station station;

StationPage({Key? key, required this.station}) : super(key: key);

@override
_StationPageState createState() => _StationPageState();
}

class _StationPageState extends State<StationPage> {
AudioPlayer audioPlayer = AudioPlayer();
bool isPlaying = false;

@override
void initState() {
super.initState();
audioPlayer.onPlayerStateChanged.listen((state) {
setState(() {
isPlaying = state == PlayerState.PLAYING;
});
});
}

@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(
title: Text(widget.station.name),
),
body: Center(
child: Column(
children: [
// Display station logo and description
SizedBox(height: 100),
// Play/Stop button
IconButton(
icon: Icon(isPlaying ? Icons.stop : Icons.play_arrow),
onPressed: () {
if (isPlaying) {
audioPlayer.pause();
} else {
audioPlayer.play(widget.station.streamUrl);
}
},
),
],
),
),
);
}
}